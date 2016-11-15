import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

ApplicationWindow {
    id:root
    visible: true
    width: 640
    height: 480
    minimumWidth: startStopRow.width + 40

    title: qsTr("RoboControll")

    ColumnLayout{
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10,10,10,10
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: parent.height
        RowLayout
        {
            id: startStopRow
            Label
            {
                text: qsTr("Speed: ")
            }

            TextField{
                id: speedTextField
                placeholderText: qsTr("speed")
                inputMethodHints: Qt.ImhDigitsOnly
            }

            Button{
                id: startButton
                text: "Start"
                onClicked: logTextEdit.text += "Robot started at speed: " + speedTextField.text + "\n"
            }

            Button{
                id: stopButton
                text: "Stop"
                onClicked: logTextEdit.text += "Robot stopped\n"
            }

        }


        Flickable {
            id: flickable
            Layout.fillHeight: true
            Layout.maximumHeight: root.height - startStopRow.height - 20
            TextArea {
                id: logTextEdit
                wrapMode: TextArea.Wrap
            }
            ScrollBar.vertical: ScrollBar { }
        }




    }







}
