import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQml 2.8


ApplicationWindow {
    id:root
    visible: true
    width: 640
    height: 480
    minimumWidth: topLayout.width + 40

    title: qsTr("RoboControll")

    //Slots (kinda)
    signal addLogLine(string msg)
    onAddLogLine: logTextEdit.append(msg)

    signal setConnectionStatus(string status)
    onSetConnectionStatus: connectionStatusLabel.text = status

    signal clearLog()
    onClearLog: logTextEdit.clear()

    //Signals
    signal robotConnect(string address)
    signal robotDisconnect()
    signal robotSend(string message)

    ColumnLayout{
        id: topLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10,10,10,10
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: parent.height



        RowLayout
        {
            spacing: 10

            Label
            {
                text: qsTr("Address: ")
            }

            TextField{
                id: speedTextField
                placeholderText: qsTr("ip:port")
            }

            Button{
                id: connectButton
                text: qsTr("Connect")
                onClicked:{
                    robotConnect(speedTextField.text)
                }
            }

            Button{
                id: disconnectButton
                text: qsTr("Disonnect")
                onClicked:{
                    robotDisconnect()
                }
            }

            Label
            {
                id: connectionStatusLabel
                text: ""
            }



        }





        RowLayout
        {
            spacing: 10
            Label
            {
                text: qsTr("Command: ")
            }

            TextField{
                id: commandTextField
                placeholderText: qsTr("command")
            }

            Button{
                id: submitButton
                text: "Send"
                onClicked:{
                    robotSend(commandTextField.text)
                }
            }
        }


        TextArea {
            id: logTextEdit
            //wrapMode: TextArea.Wrap
        }

    }
}

/*Button{
    id: stopButton
    text: "Stop"
    onClicked:{
        robotStop()
    }
}*/
