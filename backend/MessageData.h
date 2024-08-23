#ifndef MESSAGEDATA_H
#define MESSAGEDATA_H

#include <QObject>

class MessageData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id CONSTANT)
    Q_PROPERTY(QString publicKey READ publicKey CONSTANT)
    Q_PROPERTY(QString message READ message CONSTANT)
    Q_PROPERTY(QString hash READ hash CONSTANT)
    Q_PROPERTY(QString dateTime READ dateTime CONSTANT)

public:
    MessageData(int id, const QString &publicKey, const QString &message, const QString &hash, const QString &dateTime, QObject *parent = nullptr)
        : QObject(parent), m_id(id), m_publicKey(publicKey), m_message(message), m_hash(hash), m_dateTime(dateTime) {}

    int id() const { return m_id; }
    QString publicKey() const { return m_publicKey; }
    QString message() const { return m_message; }
    QString hash() const { return m_hash; }
    QString dateTime() const { return m_dateTime; }

private:
    int m_id;
    QString m_publicKey;
    QString m_message;
    QString m_hash;
    QString m_dateTime;
};

#endif // MESSAGEDATA_H
