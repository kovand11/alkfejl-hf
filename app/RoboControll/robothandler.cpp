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
        emit logLine("Error: Invalid address");
        return;
    }



}

void RobotHandler::onDisconnect()
{
    tcpSocket->disconnectFromHost();
    emit connectionStatusChanged(false,false);
}


void RobotHandler::onSend(QString command,bool isEmulatedInput)
{
    if (isEmulatedInput)
    {
        //        verb     parameters
        std::pair<QString, QStringList> preprocessedCommand = preprocessCommand(command);
        executeCommand(preprocessedCommand.first,preprocessedCommand.second);
    }
    else
    {
        sendCommandToRobot(command);
    }
}

void RobotHandler::readTcpData()
{
    QByteArray data = tcpSocket->readAll();
    std::pair<QString, QStringList> preprocessedCommand = preprocessCommand(QString(data));
    executeCommand(preprocessedCommand.first,preprocessedCommand.second);
    emit logLine(QString(data));
}

void RobotHandler::onTcpConnected()
{
    emit connectionStatusChanged(false,true);
    emit logLine("Event: Successfully connected");
}

void RobotHandler::onTcpDisconnected()
{
    emit connectionStatusChanged(false,false);
    emit logLine("Event: Disconnected");
}

void RobotHandler::onTcpError()
{
    emit connectionStatusChanged(false,false);
    emit logLine("Error: Unknown Tcp");
}

void RobotHandler::speedAndSteerChanged(qreal speed,qreal steer,bool isForward,bool isBackward,bool isStop)
{
    if (isForward)
        sendCommandToRobot("forward");

    if (isBackward)
        sendCommandToRobot("backward");

    sendCommandToRobot("speed " + QString::number(speed) );
    sendCommandToRobot("turn " + QString::number(steer) );

    if (isStop)
        sendCommandToRobot("stop");
}

void RobotHandler::steerTest()
{
    sendCommandToRobot("steertest");
}

void RobotHandler::startTest()
{
    sendCommandToRobot("starttest");
}

std::pair<QString, QStringList> RobotHandler::preprocessCommand(QString command)
{
    QStringList splitted = command.split(' ');
    QString verb = splitted.at(0);
    splitted.removeAt(0);
    QStringList params = splitted;
    return std::pair<QString, QStringList>(verb,params);
}

void RobotHandler::executeCommand(QString verb, QStringList params)
{
    if (verb == "")
    {
        logLine("Error: Empty incomming command");
    }

    else if (verb == "ping")
    {
        sendCommandToRobot("ok");
    }

    else if (verb == "touch")
    {
        if (params.length() == 1)
        {
            emit touchSensorChanged( params.at(0) != "0" && params.at(0) != "false");
        }
        else
        {
            logLine("Error: touch has an invalid param list: " + params.join(','));
        }
    }

    else if (verb == "speed")
    {
        if (params.length() == 1)
        {
            bool ok;
            double speed = params.at(0).toDouble(&ok);
            if (!ok)
                logLine("Error: speed has an invalid param : " + params.at(0));
            else
                emit speedChanged(QString::number(speed,'f',2));
        }
        else
            logLine("Error: speed has an invalid param list: " + params.join(','));
    }

    else if (verb == "steer")
    {
        if (params.length() == 1)
        {
            bool ok;
            double steer = params.at(0).toDouble(&ok);
            if (!ok)
                logLine("Error: steer has an invalid param : " + params.at(0));
            else
                emit steerChanged(QString::number(steer,'f',2));
        }
        else
            logLine("Error: steer has an invalid param list: " + params.join(','));

    }

    else if (verb == "distance")
    {
        if (params.length() == 1)
        {
            bool ok;
            double distance = params.at(0).toDouble(&ok);
            if (!ok)
                logLine("Error: distance has an invalid param : " + params.at(0));
            else
                emit distanceChanged(distance);
        }
        else
            logLine("Error: distance has an invalid param list: " + params.join(','));


    }


    else if (verb == "rgb")
    {
        if (params.length() == 3)
        {
            bool okR;
            bool okG;
            bool okB;
            qreal r= params.at(0).toDouble(&okR);
            qreal g= params.at(1).toDouble(&okG);
            qreal b= params.at(2).toDouble(&okB);
            if (!(okR && okG && okB))
                logLine("Error: distance has at least one invalid parameter : " + params.join(','));
            else
                emit rgbChanged(r,g,b);
        }
        else
            logLine("Error: distance has an invalid param list: " + params.join(','));

    }

    else if (verb == "startresult" || verb == "turnresult")
    {
        logLine(verb+ ": " + params.join(','));
    }

    else if (verb == "log")
    {
        logLine("Robotlog: " + params.join(' '));
    }

    else
    {
        logLine("Error: Unknown command: " + verb);
    }

}

void RobotHandler::sendCommandToRobot(QString command)
{
    if (tcpSocket->isOpen())
    {
        tcpSocket->write(command.toStdString().c_str());
        tcpSocket->flush();
    }

    if (true)
        logLine("Output: " + command);
}






