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
            logLine("Error: Invalid port");
            return;
        }

        tcpSocket->connectToHost(ip,port);
        emit connectionStatusChanged(true,false);
    }
    else
    {
        emit connectionStatusChanged(false,false);
        emit logLine("Invalid address");
        return;
    }



}

void RobotHandler::onDisconnect()
{
    tcpSocket->disconnectFromHost();
    emit connectionStatusChanged(false,false);
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
    emit connectionStatusChanged(false,true);
    emit logLine("Successfully connected");
}

void RobotHandler::onTcpDisconnected()
{
    emit connectionStatusChanged(false,false);
    emit logLine("Disconnected");
}

void RobotHandler::onTcpError()
{
    emit connectionStatusChanged(false,false);
    emit logLine("Error: Unknown Tcp");
}






