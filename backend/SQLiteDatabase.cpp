#include "SQLiteDatabase.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDateTime>
#include <QVariant>

SQLiteDatabase::SQLiteDatabase(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("messages.db");

    if (!db.open()) {
        // حذف qDebug() خطا
    } else {
        createTable();
    }
}

SQLiteDatabase::~SQLiteDatabase()
{
    if (db.isOpen()) {
        db.close();
    }
}

bool SQLiteDatabase::createTable()
{
    QSqlQuery query;
    QString createTableQuery = R"(
        CREATE TABLE IF NOT EXISTS messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            publicKey TEXT NOT NULL,
            message TEXT NOT NULL,
            hash TEXT NOT NULL,
            dateTime TEXT NOT NULL
        )
    )";

    if (!query.exec(createTableQuery)) {
        return false;
    }

    QString createTableQuery2 = R"(
        CREATE TABLE IF NOT EXISTS decryptions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            privateKey TEXT NOT NULL,
            decryptedMessage TEXT NOT NULL,
            hash TEXT NOT NULL,
            dateTime TEXT NOT NULL
        )
    )";

    if (!query.exec(createTableQuery2)) {
        return false;
    }

    QString createTableQuery3 = R"(
    CREATE TABLE IF NOT EXISTS keys (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        publicKey TEXT NOT NULL,
        privateKey TEXT NOT NULL,
        dateTime TEXT NOT NULL
    )
)";

    if (!query.exec(createTableQuery3)) {
        return false;
    }

    QString createTableQuery4 = R"(
        CREATE TABLE IF NOT EXISTS user_passwords (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            hashedPassword TEXT NOT NULL,
            dateTime TEXT NOT NULL
        )
    )";

    if (!query.exec(createTableQuery4)) {
        return false;
    }

    return true;
}

bool SQLiteDatabase::insertData(const QString &publicKey, const QString &message, const QString &hash)
{
    QSqlQuery query;
    query.prepare(R"(
        INSERT INTO messages (publicKey, message, hash, dateTime)
        VALUES (:publicKey, :message, :hash, :dateTime)
    )");

    query.bindValue(":publicKey", publicKey);
    query.bindValue(":message", message);
    query.bindValue(":hash", hash);
    query.bindValue(":dateTime", QDateTime::currentDateTime().toString(Qt::ISODate));

    if (!query.exec()) {
        return false;
    }

    return true;
}

bool SQLiteDatabase::insertDecryptionData(const QString &privateKey, const QString &decryptedMessage, const QString &hash)
{
    QSqlQuery query;
    query.prepare(R"(
        INSERT INTO decryptions (privateKey, decryptedMessage, hash, dateTime)
        VALUES (:privateKey, :decryptedMessage, :hash, :dateTime)
    )");

    query.bindValue(":privateKey", privateKey);
    query.bindValue(":decryptedMessage", decryptedMessage);
    query.bindValue(":hash", hash);
    query.bindValue(":dateTime", QDateTime::currentDateTime().toString(Qt::ISODate));

    if (!query.exec()) {
        return false;
    }

    return true;
}

QVariantList SQLiteDatabase::fetchData() const
{
    QVariantList result;
    QSqlQuery query("SELECT id, publicKey, message, hash, dateTime FROM messages ORDER BY dateTime DESC");

    if (!query.exec()) {
        return result;
    }

    while (query.next()) {
        QVariantMap record;
        record["id"] = query.value(0).toInt();
        record["publicKey"] = query.value(1).toString();
        record["message"] = query.value(2).toString();
        record["hash"] = query.value(3).toString();
        record["dateTime"] = query.value(4).toString();
        result.append(record);
    }

    return result;
}

bool SQLiteDatabase::deleteData(int id)
{
    QSqlQuery query;
    query.prepare(R"(
        DELETE FROM messages WHERE id = :id
    )");
    query.bindValue(":id", id);

    if (!query.exec()) {
        return false;
    }

    return true;
}

bool SQLiteDatabase::saveKeys(const QString &publicKey, const QString &privateKey) {
    QSqlQuery query;


    if (!query.exec("DELETE FROM keys")) {
        return false;
    }


    query.prepare(R"(
        INSERT INTO keys (publicKey, privateKey, dateTime)
        VALUES (:publicKey, :privateKey, :dateTime)
    )");

    query.bindValue(":publicKey", publicKey);
    query.bindValue(":privateKey", privateKey);
    query.bindValue(":dateTime", QDateTime::currentDateTime().toString(Qt::ISODate));

    if (!query.exec()) {
        return false;
    }

    return true;
}

QVariantMap SQLiteDatabase::getLastKeys() const {
    QVariantMap keys;
    QSqlQuery query("SELECT publicKey, privateKey FROM keys ORDER BY dateTime DESC LIMIT 1");

    if (query.exec() && query.next()) {
        keys["publicKey"] = query.value(0).toString();
        keys["privateKey"] = query.value(1).toString();
    }

    return keys;
}

bool SQLiteDatabase::saveUserPassword(const QString &hashedPassword) {
    QSqlQuery query;


    if (!query.exec("DELETE FROM user_passwords")) {
        return false;
    }


    query.prepare(R"(
        INSERT INTO user_passwords (hashedPassword, dateTime)
        VALUES (:hashedPassword, :dateTime)
    )");

    query.bindValue(":hashedPassword", hashedPassword);
    query.bindValue(":dateTime", QDateTime::currentDateTime().toString(Qt::ISODate));

    if (!query.exec()) {
        return false;
    }

    return true;
}

QString SQLiteDatabase::getUserPassword() const {
    QSqlQuery query;


    query.prepare("SELECT hashedPassword FROM user_passwords ORDER BY dateTime DESC LIMIT 1");

    if (query.exec()) {
        if (query.next()) {
            return query.value(0).toString();
        }
    }

    return QString();
}
