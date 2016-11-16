#ifndef ROBOTHANDLER_H
#define ROBOTHANDLER_H

#include <QObject>
#include <QDebug>

class RobotHandler : public QObject
{
    Q_OBJECT
public:
    explicit RobotHandler(QObject *parent = 0);

signals:
    void logLine(QString msg);
    void logClear();

public slots:
    void onRobotStart(QString speed);
    void onRobotStop();
};

#endif // ROBOTHANDLER_H
