#ifndef SQLITEDATABASE_H
#define SQLITEDATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDateTime>
#include <QVariantList>

class SQLiteDatabase : public QObject
{
    Q_OBJECT
public:
    explicit SQLiteDatabase(QObject *parent = nullptr);
    ~SQLiteDatabase();

    Q_INVOKABLE bool insertData(const QString &publicKey, const QString &message, const QString &hash);
    Q_INVOKABLE bool insertDecryptionData(const QString &privateKey, const QString &decryptedMessage, const QString &hash);


    Q_INVOKABLE QVariantList fetchData() const;
    Q_INVOKABLE bool deleteData(int id);  // اضافه کردن تابع deleteData

private:
    QSqlDatabase db;
    bool createTable();
};

#endif // SQLITEDATABASE_H
