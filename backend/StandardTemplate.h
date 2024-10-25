#ifndef STANDARDTEMPLATE_H
#define STANDARDTEMPLATE_H

#include <QByteArray>
#include <QString>

class StandardTemplate
{
public:

    static QByteArray hideData(const QByteArray &data);

    // تابع پنهان‌گشایی
    static QString revealData(const QString &hiddenData);
};

#endif // STANDARDTEMPLATE_H
