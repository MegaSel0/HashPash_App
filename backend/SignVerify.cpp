#include "SignVerify.h"
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/evp.h>
#include <openssl/err.h>
#include <openssl/sha.h>
#include <vector>
#include <QByteArray>
#include <QString>
#include <iostream>
#include <QMap>
#include <QVariant>
#include <iomanip>  // برای std::setw و std::setfill

// Constructor
SignVerify::SignVerify(QObject *parent) : QObject(parent) {}

// تابع برای گزارش خطاها
void SignVerify::logErrors() {
    // بهتر است خطاها در فایل لاگ ذخیره شوند تا اطلاعات حساس به کاربر نشان داده نشود
    ERR_print_errors_fp(stderr);
}

// رمزنگاری داده‌ها با کلید عمومی
QString SignVerify::encryptMessage(const QString &message, const QString &publicKey) {
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

    // Encrypting in chunks
    size_t chunkSize = 245; // 2048-bit RSA with OAEP padding can handle 245 bytes of data
    QByteArray messageBytes = message.toUtf8();
    size_t messageSize = messageBytes.size();
    std::vector<unsigned char> encryptedData;

    for (size_t i = 0; i < messageSize; i += chunkSize) {
        size_t len = std::min(chunkSize, messageSize - i);
        std::vector<unsigned char> chunk(len);
        memcpy(chunk.data(), messageBytes.data() + i, len);

        size_t outlen;
        if (EVP_PKEY_encrypt(ctx, nullptr, &outlen, chunk.data(), len) <= 0) {
            std::cerr << "Error determining encrypted length" << std::endl;
            logErrors();
            EVP_PKEY_CTX_free(ctx);
            EVP_PKEY_free(evpPublicKey);
            return "";
        }

        encryptedData.resize(encryptedData.size() + outlen);
        if (EVP_PKEY_encrypt(ctx, encryptedData.data() + encryptedData.size() - outlen, &outlen, chunk.data(), len) <= 0) {
            std::cerr << "Error encrypting message chunk" << std::endl;
            logErrors();
            EVP_PKEY_CTX_free(ctx);
            EVP_PKEY_free(evpPublicKey);
            return "";
        }
    }

    EVP_PKEY_CTX_free(ctx);
    EVP_PKEY_free(evpPublicKey);

    QByteArray encryptedMessage(reinterpret_cast<const char*>(encryptedData.data()), encryptedData.size());
    return encryptedMessage.toBase64();
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

    size_t rsaBlockSize = EVP_PKEY_size(evpPrivateKey); // اندازه بلاک RSA که برابر با طول کلید است
    size_t maxChunkSize = rsaBlockSize; // اندازه حداکثر تکه قابل رمزگشایی

    std::vector<unsigned char> decryptedData;

    for (size_t i = 0; i < encryptedBytes.size(); i += maxChunkSize) {
        size_t len = std::min(maxChunkSize, static_cast<size_t>(encryptedBytes.size() - i));
        size_t outlen = rsaBlockSize;

        std::vector<unsigned char> decryptedChunk(outlen);
        if (EVP_PKEY_decrypt(ctx, decryptedChunk.data(), &outlen,
                             reinterpret_cast<const unsigned char*>(encryptedBytes.data() + i), len) <= 0) {
            std::cerr << "Error decrypting message chunk" << std::endl;
            logErrors();
            EVP_PKEY_CTX_free(ctx);
            EVP_PKEY_free(evpPrivateKey);
            return "";
        }

        decryptedData.insert(decryptedData.end(), decryptedChunk.begin(), decryptedChunk.begin() + outlen);
    }

    EVP_PKEY_CTX_free(ctx);
    EVP_PKEY_free(evpPrivateKey);

    QString decryptedText = QString::fromUtf8(reinterpret_cast<const char*>(decryptedData.data()), decryptedData.size());

    std::cerr << "Decrypted data: " << decryptedText.toStdString() << std::endl;

    return decryptedText;
}

// تولید کلیدهای RSA با طول 3072 بیت
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

    if (EVP_PKEY_CTX_set_rsa_keygen_bits(ctx, 3072) <= 0) {  // تغییر طول کلید به 3072 بیت
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

    char *pubKeyData = nullptr;
    char *privKeyData = nullptr;
    long pubLen = BIO_get_mem_data(pub, &pubKeyData);
    long privLen = BIO_get_mem_data(priv, &privKeyData);

    QByteArray publicKey(pubKeyData, pubLen);
    QByteArray privateKey(privKeyData, privLen);

    EVP_PKEY_free(pkey);
    BIO_free_all(pub);
    BIO_free_all(priv);

    QVariantMap keys;
    keys["publicKey"] = QString::fromUtf8(publicKey);
    keys["privateKey"] = QString::fromUtf8(privateKey);

    return keys;
}

// تابع امضای دیجیتال
QString SignVerify::signMessage(const QString &message, const QString &privateKey) {
    QByteArray keyData = privateKey.toUtf8();
    BIO *bio = BIO_new_mem_buf(keyData.data(), -1);
    EVP_PKEY *evpPrivateKey = PEM_read_bio_PrivateKey(bio, nullptr, nullptr, nullptr);
    BIO_free(bio);

    if (!evpPrivateKey) {
        std::cerr << "Error reading private key" << std::endl;
        logErrors();
        return "";
    }

    EVP_MD_CTX *mdctx = EVP_MD_CTX_new();
    if (!mdctx) {
        std::cerr << "Error creating context" << std::endl;
        logErrors();
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    if (EVP_DigestSignInit(mdctx, nullptr, EVP_sha256(), nullptr, evpPrivateKey) <= 0) {
        std::cerr << "Error initializing signing" << std::endl;
        logErrors();
        EVP_MD_CTX_free(mdctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    if (EVP_DigestSignUpdate(mdctx, message.toUtf8().data(), message.size()) <= 0) {
        std::cerr << "Error updating signature" << std::endl;
        logErrors();
        EVP_MD_CTX_free(mdctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    size_t sig_len;
    if (EVP_DigestSignFinal(mdctx, nullptr, &sig_len) <= 0) {
        std::cerr << "Error determining signature length" << std::endl;
        logErrors();
        EVP_MD_CTX_free(mdctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    std::vector<unsigned char> sig(sig_len);
    if (EVP_DigestSignFinal(mdctx, sig.data(), &sig_len) <= 0) {
        std::cerr << "Error creating signature" << std::endl;
        logErrors();
        EVP_MD_CTX_free(mdctx);
        EVP_PKEY_free(evpPrivateKey);
        return "";
    }

    EVP_MD_CTX_free(mdctx);
    EVP_PKEY_free(evpPrivateKey);

    QByteArray signature(reinterpret_cast<const char*>(sig.data()), sig_len);
    return signature.toBase64();
}

// تابع برای تایید امضا
bool SignVerify::verifySignature(const QString &message, const QString &signature, const QString &publicKey) {
    QByteArray keyData = publicKey.toUtf8();
    BIO *bio = BIO_new_mem_buf(keyData.data(), -1);
    EVP_PKEY *evpPublicKey = PEM_read_bio_PUBKEY(bio, nullptr, nullptr, nullptr);
    BIO_free(bio);

    if (!evpPublicKey) {
        std::cerr << "Error reading public key" << std::endl;
        logErrors();
        return false;
    }

    EVP_MD_CTX *mdctx = EVP_MD_CTX_new();
    if (!mdctx) {
        std::cerr << "Error creating context" << std::endl;
        logErrors();
        EVP_PKEY_free(evpPublicKey);
        return false;
    }

    if (EVP_DigestVerifyInit(mdctx, nullptr, EVP_sha256(), nullptr, evpPublicKey) <= 0) {
        std::cerr << "Error initializing verification" << std::endl;
        logErrors();
        EVP_MD_CTX_free(mdctx);
        EVP_PKEY_free(evpPublicKey);
        return false;
    }

    if (EVP_DigestVerifyUpdate(mdctx, message.toUtf8().data(), message.size()) <= 0) {
        std::cerr << "Error updating verification" << std::endl;
        logErrors();
        EVP_MD_CTX_free(mdctx);
        EVP_PKEY_free(evpPublicKey);
        return false;
    }

    QByteArray sigBytes = QByteArray::fromBase64(signature.toUtf8());
    if (EVP_DigestVerifyFinal(mdctx, reinterpret_cast<const unsigned char*>(sigBytes.data()), sigBytes.size()) <= 0) {
        std::cerr << "Signature verification failed" << std::endl;
        logErrors();
        EVP_MD_CTX_free(mdctx);
        EVP_PKEY_free(evpPublicKey);
        return false;
    }

    EVP_MD_CTX_free(mdctx);
    EVP_PKEY_free(evpPublicKey);
    return true;
}
