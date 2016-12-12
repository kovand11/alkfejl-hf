#ifndef ROBOTHANDLER_H
#define ROBOTHANDLER_H

#include <utility>

#include <QObject>
#include <QDebug>
#include <QAbstractSocket>
#include <QTcpSocket>

#include <QTcpSocket>


class RobotHandler : public QObject
{
    Q_OBJECT
public:
    explicit RobotHandler(QObject *parent = 0);

signals:
    void connectionStatusChanged(bool,bool);
    void logLine(QString msg);
    void logClear();
    void touchSensorChanged(bool);
    void speedChanged(QString);
    void steerChanged(QString);

public slots:
    void onConnect(QString address);
    void onDisconnect();
    void onSend(QString command,bool isEmulatedInput);

private slots:
    void readTcpData();
    void onTcpConnected();
    void onTcpDisconnected();
    void onTcpError();


private:
    QTcpSocket *tcpSocket;
    static std::pair<QString,QStringList> preprocessCommand(QString command);
    void executeCommand(QString verb,QStringList params);
    void sendCommandToRobot(QString command);


};

#endif // ROBOTHANDLER_H
