import QtQuick 2.8
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQml 2.8
import QtCharts 2.1


ApplicationWindow {
    id:root
    visible: true
    width: 1280
    minimumWidth: 800
    height: 720
    minimumHeight: 600

    title: qsTr("RoboControll")

    //Properties
    //

    property bool isTcpBusy:false
    property bool isTcpConnected:false


    //Slots (kinda)
    signal addLogLine(string msg)
    onAddLogLine: logTextEdit.append(msg)

    signal setTcpStatus(bool busy,bool connected)
    onSetTcpStatus: {
        isTcpBusy = busy
        isTcpConnected = connected

    }

    signal clearLog()
    onClearLog: logTextEdit.clear()

    signal touchSensorChanged(bool checked)
    onTouchSensorChanged:{
        touchIndicator.checked = checked
    }

    signal speedChanged(string speed)
    onSpeedChanged:{
        speedLabel.text = "Speed: " + speed + " km/h"
    }


    signal steerChanged(string steer)
    onSteerChanged:{
        steerLabel.text = "Steer: " + steer + " deg"
    }

    //Signals
    signal tcpConnect(string address)
    signal tcpDisconnect()
    signal tcpSend(string message,bool isEmulated)

    RowLayout
    {
        id: topLayout
        anchors.fill: parent
        anchors.margins: 10,10,10,10
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.maximumHeight: parent.height






        ColumnLayout{
            anchors.top: parent.top
            //anchors.left: parent.left

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
                    enabled: !(isTcpBusy || isTcpConnected)
                }

                Button{
                    id: connectButton
                    text: isTcpConnected || isTcpBusy ? qsTr("Disconnect") : qsTr("Connect")
                    onClicked:{ isTcpConnected || isTcpBusy ? tcpDisconnect() : tcpConnect(speedTextField.text)
                    }
                }

            }

            Rectangle
            {
                id: controllTarget
                width: 300
                height: 300
                color: "black"
                MouseArea
                {
                    property int correctedMouseX: 0
                    property int correctedMouseY: 0
                    anchors.fill: parent
                    onPositionChanged:
                    {
                        if (mouseX + controllCrosshair.width/2 > controllTarget.width)
                        {
                            correctedMouseX = controllTarget.width - controllCrosshair.width/2
                        }
                        else if (mouseX < controllCrosshair.width/2)
                        {
                            correctedMouseX = controllCrosshair.width/2
                        }
                        else
                        {
                            correctedMouseX = mouseX;
                        }

                        if (mouseY + controllCrosshair.height/2 > controllTarget.height)
                        {
                            correctedMouseY = controllTarget.height - controllCrosshair.height/2
                        }
                        else if (mouseY < controllCrosshair.height/2)
                        {
                            correctedMouseY = controllCrosshair.height/2
                        }
                        else
                        {
                            correctedMouseY = mouseY;
                        }


                        controllCrosshair.x = correctedMouseX - controllCrosshair.width/2
                        controllCrosshair.y = correctedMouseY - controllCrosshair.height/2

                    }
                    onDoubleClicked:
                    {
                        controllCrosshair.x = controllTarget.width/2 - controllCrosshair.width/2
                        controllCrosshair.y = controllTarget.height - controllCrosshair.height
                    }

                }


                Rectangle
                {
                    width: 20
                    height: 20
                    id: controllCrosshair
                    x: controllTarget.width/2 - controllCrosshair.width/2
                    y: controllTarget.height - controllCrosshair.width
                    radius: 20
                    color: "red"
                    visible: isTcpConnected || isEmulatedCheckBox.checked

                }


            }


            GroupBox{
                title: "Test Functions"

                ColumnLayout{

                    RowLayout{
                        spacing: 10
                        Button{
                            text: "Steer test"
                        }

                        Label{
                            text: "Result"
                        }

                    }

                    RowLayout{
                        spacing: 10
                        Button{
                            text: "Start test"

                        }

                        Label{
                            text: "<u>Result</u>"
                            color: "blue"


                        }

                    }





                }







            }

            GroupBox{
                title: "Settings"
                ColumnLayout{
                    CheckBox
                    {
                        id: isShowOutput
                        text: "Show output sent to the robot"
                        enabled: false
                        checked: true
                    }

                    CheckBox
                    {
                        id: isEmulatedCheckBox
                        text: "Emulate robot"
                    }
                }

            }




        }

        ColumnLayout
        {
            ChartView {
                width: 400
                Layout.fillHeight: true
                title: "Distance sensor"
                antialiasing: true


                LineSeries {
                    name: "distance (m)"
                    XYPoint { x: 0; y: 0 }
                    XYPoint { x: 1.1; y: 2.1 }
                    XYPoint { x: 1.9; y: 3.3 }
                    XYPoint { x: 2.1; y: 2.1 }
                    XYPoint { x: 2.9; y: 4.9 }
                    XYPoint { x: 3.4; y: 3.0 }
                    XYPoint { x: 4.1; y: 3.3 }
                }
            }

            ChartView {
                width: 400
                Layout.fillHeight: true
                title: "Light sensor"
                antialiasing: true


                LineSeries {
                    color: "#FF1111"
                    name: "Red (%)"
                    XYPoint { x: 0; y: 0 }
                    XYPoint { x: 1.1; y: 2.1 }
                    XYPoint { x: 1.9; y: 3.3 }
                    XYPoint { x: 2.1; y: 2.1 }
                    XYPoint { x: 2.9; y: 4.9 }
                    XYPoint { x: 3.4; y: 3.0 }
                    XYPoint { x: 4.1; y: 3.3 }
                }

                LineSeries {
                    color: "#11FF11"
                    name: "Green (%)"
                    XYPoint { x: 0; y: 0 }
                    XYPoint { x: 1.1; y: 2.5 }
                    XYPoint { x: 1.9; y: 3.4 }
                    XYPoint { x: 2.1; y: 2.2 }
                    XYPoint { x: 2.9; y: 4.8 }
                    XYPoint { x: 3.4; y: 3.9 }
                    XYPoint { x: 4.1; y: 3.2 }
                }

                LineSeries {
                    color: "#1111FF"
                    name: "Blue (%)"
                    XYPoint { x: 0; y: 0 }
                    XYPoint { x: 1.1; y: 3.5 }
                    XYPoint { x: 1.9; y: 4.9 }
                    XYPoint { x: 2.1; y: 4.21 }
                    XYPoint { x: 2.9; y: 2.8 }
                    XYPoint { x: 3.4; y: 4.8 }
                    XYPoint { x: 4.1; y: 4.2 }
                }


            }

            RowLayout
            {
                spacing: 10
                Label
                {
                    text: "Touch sensor"
                }

                Rectangle
                {
                    property bool checked: false
                    id:touchIndicator
                    width:50
                    height:50
                    radius:50
                    color: checked ? "red" : "black"
                }

                Label
                {
                    id: speedLabel
                    text: "Speed: - km/h"
                }

                Label
                {
                    id: steerLabel
                    text: "Steer: - deg"
                }
            }

        }





        ColumnLayout{
            anchors.top: parent.top
            anchors.right: parent.right

            TextArea {
                id: logTextEdit
                Layout.fillWidth: true
                Layout.fillHeight: true

                menu: Menu{
                    MenuItem{
                        text: "Clear"
                        onTriggered: logTextEdit.text = "";

                    }
                }
            }


            RowLayout
            {
                spacing: 10
                TextField{
                    Layout.fillWidth: true
                    id: commandTextField
                    placeholderText: qsTr("command")
                }

                Button{
                    id: submitButton
                    text: "Send"
                    enabled: isTcpConnected || isEmulatedCheckBox.checked
                    onClicked:{
                        tcpSend(commandTextField.text,isEmulatedCheckBox.checked)
                        if (!isRememberCheckBox.checked)
                            commandTextField.text = ""
                    }
                }

                CheckBox
                {
                    id: isRememberCheckBox
                    text: "Remember"
                }

            }
        }
    }
}
