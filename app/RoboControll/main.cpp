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
    QObject::connect(root,SIGNAL(robotStart(QString)),robotHandler,SLOT(onRobotStart(QString)));
    QObject::connect(root,SIGNAL(robotStop()),robotHandler,SLOT(onRobotStop()));

    //C++ to UI
    QObject::connect(robotHandler,SIGNAL(logLine(QString)),root,SIGNAL(addLogLine(QString)));
    QObject::connect(robotHandler,SIGNAL(logClear()),root,SIGNAL(clearLog()));

    return app.exec();
}
