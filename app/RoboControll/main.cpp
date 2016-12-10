#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <robothandler.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject* root = engine.rootObjects().first();

    RobotHandler *robotHandler = new RobotHandler();

    //UI to C++
    QObject::connect(root,SIGNAL(robotSend(QString)),robotHandler,SLOT(onSend(QString)));
    QObject::connect(root,SIGNAL(robotDisconnect()),robotHandler,SLOT(onDisconnect()));
    QObject::connect(root,SIGNAL(robotConnect(QString)),robotHandler,SLOT(onConnect(QString)));

    //C++ to UI
    QObject::connect(robotHandler,SIGNAL(logLine(QString)),root,SIGNAL(addLogLine(QString)));
    QObject::connect(robotHandler,SIGNAL(logClear()),root,SIGNAL(clearLog()));
    QObject::connect(robotHandler,SIGNAL(connectionStatusChanged(QString)),root,SIGNAL(setConnectionStatus(QString)));

    return app.exec();
}
