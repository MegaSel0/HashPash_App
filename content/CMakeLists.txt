### This file is automatically generated by Qt Design Studio.
### Do not change

qt_add_library(content STATIC)
qt6_add_qml_module(content
    URI "content"
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        App.qml
        HashPage.qml

        HashPageForm.ui.qml
        PashPage.qml
    RESOURCES
        fonts/fonts.txt
        images/history.svg
        images//lock.svg
        images/lock-open.svg
        images/copy.svg
        images/encryption1.svg
        images/encryption2.svg
        images/encryption3.svg
        images/encryption4.svg
        images/close.svg
        images/about2.svg
        images/trash.svg
        images/Settings.svg
        images/background.png
        images/back.svg
        images/User.png
        animation/ZZ6.gif
        QML_FILES HashPageContent.qml
        QML_FILES PashPageContent.qml
        QML_FILES HistoryDialog.qml
        QML_FILES DetailDialog.qml
        QML_FILES EncryptionDialog.qml
        QML_FILES SettingDialog.qml
        QML_FILES SettingPassword.qml
        QML_FILES LoginUser.qml
        QML_FILES AboutPage.qml


)
