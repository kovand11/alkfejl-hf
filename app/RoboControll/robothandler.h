#ifndef ROBOTHANDLER_H
#define ROBOTHANDLER_H

#include <QObject>
#include <QDebug>
#include <QAbstractSocket>
#include <QTcpSocket>


class RobotHandler : public QObject
{
    Q_OBJECT
public:
    explicit RobotHandler(QObject *parent = 0);

signals:
    void connectionStatusChanged(QString status);
    void logLine(QString msg);
    void logClear();

public slots:
    void onConnect(QString address);
    void onDisconnect();
    void onSend(QString speed);

private slots:
    void readTcpData();
    void onTcpConnected();
    void onTcpDisconnected();
    void onTcpError();


private:
    QTcpSocket *tcpSocket;


};

#endif // ROBOTHANDLER_H
