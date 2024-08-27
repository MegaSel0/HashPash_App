#include "SignVerify.h"
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <vector>
#include <QByteArray>
#include <QString>
#include <iostream>
#include <QMap>
#include <QVariant>


// Constructor
SignVerify::SignVerify(QObject *parent) : QObject(parent) {}

// تابع برای گزارش خطاها
void SignVerify::logErrors() {
    ERR_print_errors_fp(stderr);
}

// رمزنگاری داده‌ها با کلید عمومی
QString SignVerify::encryptMessage(const QString &message, const QString &publicKey) {
    std::cerr << "Encrypting message..." << std::endl;
    QByteArray keyData = publicKey.toUtf8();
    BIO *bio = BIO_new_mem_buf(keyData.data(), -1);
    EVP_PKEY *evpPublicKey = PEM_read_bio_PUBKEY(bio, nullptr, nullptr, nullptr);
    BIO_free(bio);

    if (!evpPublicKey) {
        std::cerr << "Error reading public key" << std::endl;
        logErrors();
        return "";
    }

    EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new(evpPublicKey, nullptr);
    if (!ctx) {
        std::cerr << "Error creating context" << std::endl;
        logErrors();
        EVP_PKEY_free(evpPublicKey);
        return "";
    }

    if (EVP_PKEY_encrypt_init(ctx) <= 0) {
        std::cerr << "Error initializing encryption" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPublicKey);
        return "";
    }

    if (EVP_PKEY_CTX_set_rsa_padding(ctx, RSA_PKCS1_OAEP_PADDING) <= 0) {
        std::cerr << "Error setting padding" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPublicKey);
        return "";
    }

    size_t outlen;
    if (EVP_PKEY_encrypt(ctx, nullptr, &outlen, reinterpret_cast<const unsigned char*>(message.toUtf8().data()), message.toUtf8().size()) <= 0) {
        std::cerr << "Error determining encrypted length" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPublicKey);
        return "";
    }

    std::vector<unsigned char> out(outlen);
    if (EVP_PKEY_encrypt(ctx, out.data(), &outlen, reinterpret_cast<const unsigned char*>(message.toUtf8().data()), message.toUtf8().size()) <= 0) {
        std::cerr << "Error encrypting message" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPublicKey);
        return "";
    }

    EVP_PKEY_CTX_free(ctx);
    EVP_PKEY_free(evpPublicKey);

    QByteArray encryptedMessage(reinterpret_cast<const char*>(out.data()), outlen);
    return encryptedMessage.toBase64(); // استفاده از Base64 برای انتقال به راحتی
}

// رمزگشایی داده‌ها با کلید خصوصی
QString SignVerify::decryptMessage(const QString &encryptedMessage, const QString &privateKey) {
    std::cerr << "Decrypting message..." << std::endl;
    QByteArray keyData = privateKey.toUtf8();
    BIO *bio = BIO_new_mem_buf(keyData.data(), -1);
    EVP_PKEY *evpPrivateKey = PEM_read_bio_PrivateKey(bio, nullptr, nullptr, nullptr);
    BIO_free(bio);

    if (!evpPrivateKey) {
        std::cerr << "Error reading private key" << std::endl;
        logErrors();
        return "";
    }

    EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new(evpPrivateKey, nullptr);
    if (!ctx) {
        std::cerr << "Error creating context" << std::endl;
        logErrors();
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    if (EVP_PKEY_decrypt_init(ctx) <= 0) {
        std::cerr << "Error initializing decryption" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    if (EVP_PKEY_CTX_set_rsa_padding(ctx, RSA_PKCS1_OAEP_PADDING) <= 0) {
        std::cerr << "Error setting padding" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    QByteArray encryptedBytes = QByteArray::fromBase64(encryptedMessage.toUtf8());
    size_t outlen;
    if (EVP_PKEY_decrypt(ctx, nullptr, &outlen, reinterpret_cast<const unsigned char*>(encryptedBytes.data()), encryptedBytes.size()) <= 0) {
        std::cerr << "Error determining decrypted length" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    std::vector<unsigned char> out(outlen);
    if (EVP_PKEY_decrypt(ctx, out.data(), &outlen, reinterpret_cast<const unsigned char*>(encryptedBytes.data()), encryptedBytes.size()) <= 0) {
        std::cerr << "Error decrypting message" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    EVP_PKEY_CTX_free(ctx);
    EVP_PKEY_free(evpPrivateKey);

    return QString::fromUtf8(reinterpret_cast<const char*>(out.data()), outlen);
}

// تولید کلیدهای RSA
QVariantMap SignVerify::generateKeys() {
    std::cerr << "Generating RSA keys..." << std::endl;

    EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new_id(EVP_PKEY_RSA, nullptr);
    if (!ctx) {
        std::cerr << "Error creating context" << std::endl;
        logErrors();
        return QVariantMap();
    }

    if (EVP_PKEY_keygen_init(ctx) <= 0) {
        std::cerr << "Error initializing key generation" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        return QVariantMap();
    }

    if (EVP_PKEY_CTX_set_rsa_keygen_bits(ctx, 2048) <= 0) {
        std::cerr << "Error setting key length" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        return QVariantMap();
    }

    EVP_PKEY *pkey = nullptr;
    if (EVP_PKEY_keygen(ctx, &pkey) <= 0) {
        std::cerr << "Error generating RSA keys" << std::endl;
        logErrors();
        EVP_PKEY_CTX_free(ctx);
        return QVariantMap();
    }

    EVP_PKEY_CTX_free(ctx);

    BIO *pub = BIO_new(BIO_s_mem());
    BIO *priv = BIO_new(BIO_s_mem());

    PEM_write_bio_PUBKEY(pub, pkey);
    PEM_write_bio_PrivateKey(priv, pkey, nullptr, nullptr, 0, nullptr, nullptr);

    char *pubKey = nullptr;
    char *privKey = nullptr;
    size_t pubLen = BIO_get_mem_data(pub, &pubKey);
    size_t privLen = BIO_get_mem_data(priv, &privKey);

    QByteArray publicKey(pubKey, pubLen);
    QByteArray privateKey(privKey, privLen);

    EVP_PKEY_free(pkey);
    BIO_free_all(pub);
    BIO_free_all(priv);

    QVariantMap keys;
    keys["publicKey"] = QString(publicKey);
    keys["privateKey"] = QString(privateKey);

    return keys;
}
