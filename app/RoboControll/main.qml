import QtQuick 2.7
import QtQuick.Controls 1.5
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






    signal distanceChanged(real distance)
    onDistanceChanged:{
        if (distanceData.count == 20)
        {
            distanceData.removePoints(0,1);
            axisXd.max = axisXd.max+1
            axisXd.min = axisXd.min+1
        }
        var x = distanceData.count < 19 ? distanceData.count : axisXd.max
        distanceData.append(x,distance)
    }

    signal rgbChanged(real r,real g,real b)
    onRgbChanged:{
        if (rChannel.count == 20) //all channel has the same count
        {
            rChannel.removePoints(0,1);
            gChannel.removePoints(0,1);
            bChannel.removePoints(0,1);
            axisXc.max = axisXc.max+1
            axisXc.min = axisXc.min+1
        }
        var x = rChannel.count < 19 ? rChannel.count : axisXc.max
        rChannel.append(x,r)
        gChannel.append(x,g)
        bChannel.append(x,b)
    }

    //Signals
    signal tcpConnect(string address)
    signal tcpDisconnect()
    signal tcpSend(string message,bool isEmulated)
    signal speedAndSteerChanged(real speed,real steer,bool isForward,bool isBackward,bool isStop)

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

                property bool isStopped: true
                property bool isForward: false
                MouseArea
                {
                    property int correctedMouseX: 0
                    property int correctedMouseY: 0
                    anchors.fill: parent
                    onPositionChanged:
                    {
                        //Positioning of the red circle
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


                        var xRange = controllTarget.width - controllCrosshair.width;
                        var yRange = controllTarget.width - controllCrosshair.width;


                        if (controllTarget.isStopped)
                        {
                            controllTarget.isStopped = false

                            if (-controllCrosshair.y/yRange*2+1 > 0)
                            {
                                speedAndSteerChanged(-controllCrosshair.y/yRange*2+1,controllCrosshair.x/xRange*2-1,true,false,false)
                                controllTarget.isForward = true;
                                controllTarget.isStopped = false
                            }
                            else if (-controllCrosshair.y/yRange*2+1 < 0)
                            {
                                speedAndSteerChanged(+controllCrosshair.y/yRange*2-1,controllCrosshair.x/xRange*2-1,false,true,false)
                                controllTarget.isForward = false;
                                controllTarget.isStopped = false

                            }
                            else //speed is 0
                            {
                                speedAndSteerChanged(-controllCrosshair.y/yRange*2+1,controllCrosshair.x/xRange*2-1,false,false,false)
                            }
                        }
                        else
                        {
                            if (controllTarget.isForward)
                            {
                                //speed > 0
                                if (-controllCrosshair.y/yRange*2+1 > 0)
                                {
                                    speedAndSteerChanged(-controllCrosshair.y/yRange*2+1,controllCrosshair.x/xRange*2-1,false,false,false)
                                }
                                else
                                {
                                    speedAndSteerChanged(controllCrosshair.y/yRange*2-1,controllCrosshair.x/xRange*2-1,false,true,false)
                                    controllTarget.isForward = false
                                }
                            }
                            else
                            {
                                //speed > 0
                                if (-controllCrosshair.y/yRange*2+1 > 0)
                                {
                                    speedAndSteerChanged(-controllCrosshair.y/yRange*2+1,controllCrosshair.x/xRange*2-1,true,false,false)
                                    controllTarget.isForward = true
                                }
                                else
                                {
                                    speedAndSteerChanged(controllCrosshair.y/yRange*2-1,controllCrosshair.x/xRange*2-1,false,false,false)
                                }
                            }
                        }

                    }
                    onDoubleClicked:
                    {
                        controllTarget.isStopped = true
                        speedAndSteerChanged(0,0,false,false,true)
                        controllCrosshair.x = controllTarget.width/2 - controllCrosshair.width/2
                        controllCrosshair.y = controllTarget.height/2 - controllCrosshair.height/2
                    }

                }


                Rectangle
                {
                    width: 20
                    height: 20
                    id: controllCrosshair
                    x: controllTarget.width/2 - controllCrosshair.width/2
                    y: controllTarget.height/2 - controllCrosshair.width/2
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

                    CheckBox
                    {
                        id: isShowAllOnPlot
                        text: "Show every data on plot"
                        enabled: false
                        checked: true
                    }

                    /*Button
                    {
                        text: "For Debug"
                        onClicked: {


                            if (rChannel.count == 20) //all channel has the same count
                            {
                                rChannel.removePoints(0,1);
                                gChannel.removePoints(0,1);
                                bChannel.removePoints(0,1);
                                axisXc.max = axisXc.max+1
                                axisXc.min = axisXc.min+1
                            }
                            var x = rChannel.count < 19 ? rChannel.count : axisXc.max
                            rChannel.append(x,(Math.sin(x/3)+1)/2)
                            gChannel.append(x,(Math.sin(x/3 + 1)+1)/2)
                            bChannel.append(x,(Math.sin(x/3 + 2)+1)/2)


                        }
                    }

                    Label{
                        id: debugLabel1
                    }

                    Label{
                        id: debugLabel2
                    }

                    Label{
                        id: debugLabel3
                    }

                    Label{
                        id: debugLabel4
                    }*/
                }

            }




        }

        ColumnLayout
        {
            ChartView {
                id: distancePlot
                width: 400
                Layout.fillHeight: true
                title: "Distance sensor"
                antialiasing: true

                ValueAxis {
                       id: axisXd
                       min: 0
                       max: 19
                   }

                ValueAxis {
                       id: axisYd
                       min: 0
                       max: 5
                   }


                LineSeries {
                    id: distanceData
                    name: "distance (m)"
                    axisX: axisXd
                    axisY: axisYd
                }


            }

            ChartView {
                id: rgbPlot
                width: 400
                Layout.fillHeight: true
                title: "Light sensor"
                antialiasing: true

                ValueAxis {
                       id: axisXc
                       min: 0
                       max: 19
                   }

                ValueAxis {
                       id: axisYc
                       min: 0
                       max: 1
                   }








                LineSeries {
                    id: rChannel
                    color: "#FF1111"
                    name: "Red (%)"
                    axisX: axisXc
                    axisY: axisYc

                }

                LineSeries {
                    id: gChannel
                    color: "#11FF11"
                    name: "Green (%)"
                    axisX: axisXc
                    axisY: axisYc

                }

                LineSeries {
                    id: bChannel
                    color: "#1111FF"
                    name: "Blue (%)"
                    axisX: axisXc
                    axisY: axisYc

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
