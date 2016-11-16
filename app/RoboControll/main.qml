import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQml 2.8


ApplicationWindow {
    id:root
    visible: true
    width: 640
    height: 480
    minimumWidth: startStopRow.width + 40

    title: qsTr("RoboControll")

    //Slots (kinda)
    signal addLogLine(string msg)
    onAddLogLine: logTextEdit.append(msg)

    signal clearLog()
    onClearLog: logTextEdit.clear()

    //Signals
    signal robotStart(string speed)
    signal robotStop()

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
            }

            Button{
                id: startButton
                text: "Start"
                onClicked:{
                    robotStart(speedTextField.text)
                }
            }

            Button{
                id: stopButton
                text: "Stop"
                onClicked:{
                    robotStop()
                }
            }
        }
        TextArea {
            id: logTextEdit
            wrapMode: TextArea.Wrap
        }

    }
}
