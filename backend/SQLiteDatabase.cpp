#include "SQLiteDatabase.h"
#include <QDebug>

SQLiteDatabase::SQLiteDatabase(QObject *parent) : QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("messages.db");

    if (!db.open()) {
        qDebug() << "Failed to open the database:" << db.lastError();
    } else {
        qDebug() << "Database opened successfully!";
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
        qDebug() << "Failed to create table:" << query.lastError();
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
        qDebug() << "Failed to create decryptions table:" << query.lastError();
        return false;
    }

    qDebug() << "Table created or already exists.";
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
        qDebug() << "Failed to insert data:" << query.lastError();
        return false;
    }

    qDebug() << "Data inserted successfully.";
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
        qDebug() << "Failed to insert decryption data:" << query.lastError();
        return false;
    }

    qDebug() << "Decryption data inserted successfully.";
    return true;
}

QVariantList SQLiteDatabase::fetchData() const
{
    QVariantList result;
    QSqlQuery query("SELECT id, publicKey, message, hash, dateTime FROM messages ORDER BY dateTime DESC");

    if (!query.exec()) {
        qDebug() << "Failed to fetch data:" << query.lastError();
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

    qDebug() << "Fetched data:" << result;
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
        qDebug() << "Failed to delete data:" << query.lastError();
        return false;
    }

    qDebug() << "Data deleted successfully.";
    return true;
}
