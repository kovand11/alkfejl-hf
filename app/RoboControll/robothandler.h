#ifndef ROBOTHANDLER_H
#define ROBOTHANDLER_H

#include <utility>

#include <QObject>
#include <QDebug>
#include <QAbstractSocket>
#include <QTcpSocket>

#include <QTcpSocket>

/**@brief The RobotHandler is responsible for the communication between the robot and the UI.
 *
 * The class receives and sends commands from/to the UI with the help of the signals and slots mechanism.
 * It can be connected either to a robot or an emulated robot (which can be controlled through the UI).
*/
class RobotHandler : public QObject
{
    Q_OBJECT
public:
    /**
     * @brief RobotHandler constructor.
     * @param parent A pointer to the parent, if the instance has a parent object.
     * @note It is recommended to specify a parent object in order to call the RobotHandler's destructor automatically on destruction of the parent.
     */
    explicit RobotHandler(QObject *parent = 0);

signals:
    /**
     * @brief Notifies the UI of a change in the connection status.
     * @param busy True, if tcpStatus is busy, false otherwise.
     * @param connected True, if tcpStatus is connected, false otherwise.
     */
    void connectionStatusChanged(bool busy,bool connected);

    /**
     * @brief Signals the arrival of a new message to be written to the log on the UI.
     * @note It is recommended to connect this signal to the UI.
     * @param msg Any message containing human readable text/information.
     */
    void logLine(QString msg);

    /**
     * @brief Tells the UI to clear the log.
     * @note It is recommended to connect this signal to the UI.
     */
    void logClear();

    /**
     * @brief Notifies the UI about the changed touch sensor value and supplies the new value.
     * @note It is recommended to connect this signal to the UI.
     * @param checked True, if touch sensor is active, false otherwise.
     */
    void touchSensorChanged(bool checked);

    /**
     * @brief Notifies the UI about the changed speed and supplies the new value.
     * @note It is recommended to connect this signal to the UI.
     * @param speed The new speed value in m/s.
     */
    void speedChanged(QString speed);

    /**
     * @brief Notifies the UI about the changed steer and supplies the new value.
     * @note It is recommended to connect this signal to the UI.
     * @param steer The new steering angle.
     */
    void steerChanged(QString steer);

    /**
     * @brief Notifies the UI about the changed distance value and supplies the new value.
     * @note It is recommended to connect this signal to the UI.
     * @param distance The new distance value in cm-s.
     */
    void distanceChanged(qreal distance);

    /**
     * @brief Notifies the UI about the changed RGB sensor value and supplies the new R, G and B color values.
     * @note It is recommended to connect this signal to the UI.
     * @param r The sensors red value.
     * @param g The sensors green value.
     * @param b The sensors blue value.
     */
    void rgbChanged(qreal r,qreal g,qreal b);

public slots:
    /**
     * @brief Validates the received address, connects tcpSocket to the specified IP and port and emits connectionStatusChanged signal.
     * @param address The address in <IP>:<port> format.
     */
    void onConnect(QString address);

    /**
     * @brief Disconnects tcpSocket from the host and emits connectionStatusChanged signal.
     */
    void onDisconnect();

    /**
     * @brief Sends command to the robot or (in emulation mode) takes it as if it were sent by the robot 
     * @param command Includes the verb and optionally parameter(s) separated by spaces (" ").
     * @param isEmulatedInput indicates emulation mode
     */
    void onSend(QString command,bool isEmulatedInput);

private slots:
    /**
     * @brief Reads any data from tcpSocket.
     */
    void readTcpData();

    /**
     * @brief Informs the UI and the user of the successful connection by emiting the signals connectionStatusChanged and logLine.
     */
    void onTcpConnected();

    /**
     * @brief Informs the UI and the user of the disconnection by emiting the signals connectionStatusChanged and logLine.
     */
    void onTcpDisconnected();

    /**
     * @brief Notifies the UI and the user of the error by emiting the signals connectionStatusChanged and logLine.
     */
    void onTcpError();

    /**
     * @brief Determines the proper command and sends it to the robot.
     * @param speed Specifies the speed value [m/s] to be sent to the robot.
     * @param steer Specifies the steering angle to be sent to the robot.
     * @param isForward If true, the robot will be directed to move forward.
     * @param isBackward If true, the robot will be directed to move backward.
     * @param isStop If true, the "stop" command is sent.
     */
    void speedAndSteerChanged(qreal speed,qreal steer,bool isForward,bool isBackward,bool isStop);

    /**
     * @brief Sends the command "steertest" to the robot.
     */
    void steerTest();

    /**
     * @brief Sends the command "starttest" to the robot.
     */
    void startTest();


private:
    /**
     * @brief Client TCP Socket.
     */
    QTcpSocket *tcpSocket;

    /**
     * @brief Splits command into verb and parameters.
     * @param command Command including a verb and optionally parameter(s) separated by space (" ") characters.
     * @return Returns a pair which consists of the verb and the parameter list.
     */
    static std::pair<QString,QStringList> preprocessCommand(QString command);

    /**
     * @brief Interprets the command specified by the verb and the parameters.
     * @param verb Representing a valid command.
     * @warning Allowed verbs are: ping, touch, speed, steer, distance, rgb, startresult, steerresult, log
     * @param params Depending on the command it can be empty or can contain parameter values.
     */
    void executeCommand(QString verb,QStringList params);

    /**
     * @brief Sends command to robot if the device (tcpSocket) is open, i.e. can be written to. Outputs command to logLine.
     * @param command The command (verb and parameters) received from the UI.
     */
    void sendCommandToRobot(QString command);
};

#endif // ROBOTHANDLER_H
