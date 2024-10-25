#include "StandardTemplate.h"
#include <QDebug>
#include <QtConcurrent>
#include <QFuture>
#include <QVector>

QByteArray replaceInPart(const QByteArray &dataPart, const char sourceChars[], const QByteArray targetChars[], int size) {
    QByteArray part = dataPart;
    for (int i = 0; i < size; ++i) {
        part.replace(sourceChars[i], targetChars[i]);
    }
    return part;
}

QByteArray StandardTemplate::hideData(const QByteArray &data) {
    QByteArray dataFile = data;

    const char sourceChars[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'X', 'Y',
                                'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'm', 'n', 'r', 's', 'u', 'x', 'y'};
    const QByteArray targetChars[] = {
        QByteArray::fromRawData("あ", 3), QByteArray::fromRawData("ب", 2), QByteArray::fromRawData("چ", 2), QByteArray::fromRawData("د", 2),
        QByteArray::fromRawData("ئ", 2), QByteArray::fromRawData("ف", 2), QByteArray::fromRawData("گ", 2), QByteArray::fromRawData("ه", 2),
        QByteArray::fromRawData("ا", 2), QByteArray::fromRawData("ج", 2), QByteArray::fromRawData("ک", 2), QByteArray::fromRawData("ل", 2),
        QByteArray::fromRawData("م", 2), QByteArray::fromRawData("ن", 2), QByteArray::fromRawData("پ", 2), QByteArray::fromRawData("ق", 2),
        QByteArray::fromRawData("ר", 2), QByteArray::fromRawData("ס", 2), QByteArray::fromRawData("ת", 2), QByteArray::fromRawData("ו", 2),
        QByteArray::fromRawData("ק", 2), QByteArray::fromRawData("ץ", 2), QByteArray::fromRawData("час", 6), QByteArray::fromRawData("л", 2),
        QByteArray::fromRawData("д", 2), QByteArray::fromRawData("ж", 2), QByteArray::fromRawData("ປ", 3), QByteArray::fromRawData("ກ", 3),
        QByteArray::fromRawData("ຄ", 3), QByteArray::fromRawData("`", 1), QByteArray::fromRawData("你", 3), QByteArray::fromRawData("ani", 3),
        QByteArray::fromRawData("私", 3), QByteArray::fromRawData("^", 1), QByteArray::fromRawData("!", 1), QByteArray::fromRawData("#", 1),
        QByteArray::fromRawData("~", 1)
    };

    int numThreads = QThreadPool::globalInstance()->maxThreadCount();
    int partSize = dataFile.size() / numThreads;

    QVector<QFuture<QByteArray>> futures;

    // تقسیم داده‌ها به چند بخش و پردازش موازی هر بخش
    for (int i = 0; i < dataFile.size(); i += partSize) {
        int currentPartSize = qMin(partSize, dataFile.size() - i);
        QByteArray dataPart = dataFile.mid(i, currentPartSize);
        futures.append(QtConcurrent::run(replaceInPart, dataPart, sourceChars, targetChars, sizeof(sourceChars)));
    }

    // ترکیب کردن داده‌های پردازش‌شده
    QByteArray result;
    for (auto &future : futures) {
        result.append(future.result());
    }

    return result;
}

QString replaceInPart(const QString &dataPart, const QString sourceStrings[], const QString targetChars[], int size) {
    QString part = dataPart;
    for (int i = 0; i < size; ++i) {
        part.replace(sourceStrings[i], targetChars[i]);
    }
    return part;
}

QString StandardTemplate::revealData(const QString &hiddenData) {
    QString dataFile = hiddenData;

    const QString sourceStrings[] = {"あ", "ب", "چ", "د", "ئ", "ف", "گ", "ه", "ا", "ج", "ک", "ل", "م", "ن", "پ", "ق", "ר", "ס", "ת", "ו", "ק", "ץ",
                                     "час", "л", "д", "ж", "ປ", "ກ", "ຄ", "`", "你", "ani", "私", "^", "!", "#", "~"};
    const QString targetChars[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "X", "Y",
                                   "b", "c", "d", "e", "f", "g", "h", "i", "m", "n", "r", "s", "u", "x", "y"};

    int numThreads = QThreadPool::globalInstance()->maxThreadCount();
    int partSize = dataFile.size() / numThreads;

    QVector<QFuture<QString>> futures;

    // تقسیم داده‌ها به چند بخش و پردازش موازی هر بخش
    for (int i = 0; i < dataFile.size(); i += partSize) {
        int currentPartSize = qMin(partSize, dataFile.size() - i);
        QString dataPart = dataFile.mid(i, currentPartSize);

        futures.append(QtConcurrent::run([=]() {
            return replaceInPart(dataPart, sourceStrings, targetChars, sizeof(sourceStrings) / sizeof(sourceStrings[0]));
        }));
    }

    // ترکیب کردن داده‌های پردازش‌شده
    QString result;
    for (auto &future : futures) {
        result.append(future.result());
    }

    return result;
}


