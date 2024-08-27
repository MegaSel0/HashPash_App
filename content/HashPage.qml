import QtQuick 6.2
import QtQuick.Controls 6.2
import Test_1

HashPageForm {
    property alias customMenuBar: customMenuBar

    CustomMenuBar {
        id: customMenuBar
        ToolButton {
            id: history
            anchors.left: parent.left
            anchors.leftMargin: 5
            icon.source: "images/history.svg"
            onClicked: {
              historyDialog.visible = true
            }
        }

        ToolButton {
                   id: encryption
                   anchors.right: parent.right
                   anchors.rightMargin: 5
                   icon.source: "images/encryption4.svg"
                   icon.color: "#ffffff"
                   onClicked: {
                       encryptionDialog.visible = true
                   }
               }
           }





    EncryptionDialog {
        id: encryptionDialog
    }

    HistoryDialog {
        id: historyDialog
    }

}
