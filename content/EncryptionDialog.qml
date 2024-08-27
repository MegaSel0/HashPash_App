import QtQuick 6.2
import QtQuick.Controls 6.2
import Test_1

Dialog {
    id: encryptionDialog
    title: "Generate Keys"
    width: parent ? parent.width * 0.6 : 320
    height: parent ? parent.height * 0.9 : 240
    anchors {
        centerIn: parent
    }
    signal privateKeyUpdated(string newPrivateKey)

    Component.onCompleted: {
        var keys = database.getLastKeys();
        publicKeyField.text = keys.publicKey || "";
        privateKeyField.text = keys.privateKey || "";
    }

    Column {
        anchors.fill: parent
        spacing: 20
        padding: 20


        CustomTextArea {
            id: publicKeyFieldTextArea
            width: parent.width - 50
            height: 150

            anchors {
                horizontalCenter: parent.horizontalCenter
                topMargin: 30
            }
            textInput{
                id:publicKeyField
                readOnly:true
            }

            placeholderText: qsTr("Public Key")
        }


        CustomTextArea {
            id: privateKeyFieldTextArea
            width: parent.width - 50
            height: 150

            anchors {
                horizontalCenter: parent.horizontalCenter
                topMargin: 30
            }
            textInput{
                id:privateKeyField
                readOnly:true
            }

            placeholderText: qsTr("Private Key")

            onTextChanged: {
                        encryptionDialog.privateKeyUpdated(privateKeyField.text)
                    }
        }


        Button {
            text: "Generate Keys"
            anchors{
                horizontalCenter: parent.horizontalCenter
            }

            onClicked: {
                var keys = SignVerify.generateKeys();
                publicKeyField.text = keys.publicKey;
                privateKeyField.text = keys.privateKey;
                database.saveKeys(keys.publicKey, keys.privateKey);
            }
        }
    }
}
