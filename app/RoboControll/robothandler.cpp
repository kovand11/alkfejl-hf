#include "robothandler.h"

RobotHandler::RobotHandler(QObject *parent) : QObject(parent)
{
    tcpSocket = new QTcpSocket(this);
    connect(tcpSocket,&QTcpSocket::readyRead,this,&RobotHandler::readTcpData);
    connect(tcpSocket,&QTcpSocket::connected,this,&RobotHandler::onTcpConnected);
    connect(tcpSocket,&QTcpSocket::disconnected,this,&RobotHandler::onTcpDisconnected);



}

void RobotHandler::onConnect(QString address)
{
    QStringList ipAndPort = address.split(':');

    if (ipAndPort.size() == 2)
    {
        QString ip =ipAndPort.at(0);
        bool ok;
        int port = ipAndPort.at(1).toInt(&ok);
        if (!ok)
        {
            emit connectionStatusChanged("Invalid port");
            return;
        }

        tcpSocket->connectToHost(ip,port);
        emit connectionStatusChanged("Connecting");
    }
    else
    {
        emit connectionStatusChanged("Invalid address");
        return;
    }



}

void RobotHandler::onDisconnect()
{
    tcpSocket->disconnectFromHost();
    emit connectionStatusChanged("User disconnected");
}


void RobotHandler::onSend(QString message)
{
    tcpSocket->write(message.toStdString().c_str());
}

void RobotHandler::readTcpData()
{
    emit logLine(QString(tcpSocket->readAll()));
}

void RobotHandler::onTcpConnected()
{
    emit connectionStatusChanged("Connected");
}

void RobotHandler::onTcpDisconnected()
{
    emit connectionStatusChanged("Disconnected");
}

void RobotHandler::onTcpError()
{
    emit connectionStatusChanged("Error");
}






