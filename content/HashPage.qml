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
                t_1.open()
            }
        }
    }
}
