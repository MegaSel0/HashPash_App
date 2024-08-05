#include "SignVerify.h"
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include <openssl/err.h>
#include <vector>
#include <QByteArray>
#include <QString>
#include <iostream>

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
    RSA *rsa = PEM_read_bio_RSA_PUBKEY(bio, nullptr, nullptr, nullptr);
    BIO_free(bio);

    if (!rsa) {
        std::cerr << "Error reading public key" << std::endl;
        logErrors();
        return "";
    }

    int rsa_size = RSA_size(rsa);
    std::vector<unsigned char> encrypted(rsa_size);
    int len = RSA_public_encrypt(message.toUtf8().size(), reinterpret_cast<const unsigned char*>(message.toUtf8().data()), encrypted.data(), rsa, RSA_PKCS1_OAEP_PADDING);

    if (len == -1) {
        std::cerr << "Error encrypting message" << std::endl;
        logErrors();
        RSA_free(rsa);
        return "";
    }

    RSA_free(rsa);
    QByteArray encryptedMessage(reinterpret_cast<const char*>(encrypted.data()), len);
    return encryptedMessage.toBase64(); // استفاده از Base64 برای انتقال به راحتی
}

// رمزگشایی داده‌ها با کلید خصوصی
QString SignVerify::decryptMessage(const QString &encryptedMessage, const QString &privateKey) {
    std::cerr << "Decrypting message..." << std::endl;
    QByteArray keyData = privateKey.toUtf8();
    BIO *bio = BIO_new_mem_buf(keyData.data(), -1);
    RSA *rsa = PEM_read_bio_RSAPrivateKey(bio, nullptr, nullptr, nullptr);
    BIO_free(bio);

    if (!rsa) {
        std::cerr << "Error reading private key" << std::endl;
        logErrors();
        return "";
    }

    QByteArray encryptedBytes = QByteArray::fromBase64(encryptedMessage.toUtf8());
    int rsa_size = RSA_size(rsa);
    std::vector<unsigned char> decrypted(rsa_size);
    int len = RSA_private_decrypt(encryptedBytes.size(), reinterpret_cast<const unsigned char*>(encryptedBytes.data()), decrypted.data(), rsa, RSA_PKCS1_OAEP_PADDING);

    if (len == -1) {
        std::cerr << "Error decrypting message" << std::endl;
        logErrors();
        RSA_free(rsa);
        return "";
    }

    RSA_free(rsa);
    return QString::fromUtf8(reinterpret_cast<const char*>(decrypted.data()), len);
}

