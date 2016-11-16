#include "robothandler.h"

RobotHandler::RobotHandler(QObject *parent) : QObject(parent)
{

}


void RobotHandler::onRobotStart(QString speed)
{
    //conversion with QString::toInt()
    qDebug() <<  "C++: Start" << speed;
    emit logLine("Received from C++: "+ speed);
}

void RobotHandler::onRobotStop()
{
    qDebug() <<  "C++: Stop";
    emit logClear();
}


