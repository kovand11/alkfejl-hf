//#define REAL_CHECK_SPEED_FORMAT_READY

#include <QString>
#include <QVector>
#include <QtTest>

// Use dummy class until the real functions are ready
#ifdef REAL_CHECK_SPEED_FORMAT_READY
#include "../RoboControll/robothandler.h"
#else
class RobotHandler : public QObject
{
    Q_OBJECT
public:
    bool checkSpeedFormat(QString speed)
    {
        Q_UNUSED(speed);
        return true;
    }
    bool checkVectorFormat(QVector<int> intVector)
    {
        Q_UNUSED(intVector);
        return true;
    }
};
#endif /*REAL_CHECK_SPEED_FORMAT_READY*/

class UnitTest : public QObject
{
    Q_OBJECT

public:
    UnitTest();

private Q_SLOTS:
    //Test functions
    void case_RobotHandler_checkSpeedFormat_data();
    void case_RobotHandler_checkSpeedFormat();

    void case_RobotHandler_checkVectorFormat();

private:
    //Instance of UUT
    RobotHandler testRobotHandler;
};

UnitTest::UnitTest()
    : testRobotHandler()
{
}

void UnitTest::case_RobotHandler_checkSpeedFormat_data()
{
    QTest::addColumn<QString>("string");
    QTest::addColumn<QString>("result");

    QTest::newRow("Any positive number is valid.")       << "1"      << "true";
    QTest::newRow("Any positive decimal number is valid.")        << "2.3"    << "true";
    QTest::newRow("Not a number.")   << "text"   << "false";
    QTest::newRow("Speed cannot be negative.")       << "-4"     << "false";
}

void UnitTest::case_RobotHandler_checkSpeedFormat()
{
    QFETCH(QString, string);
    QFETCH(QString, result);

    QCOMPARE(testRobotHandler.checkSpeedFormat(string), result == "true");
}

// TODO: modify test case when the real function is ready.
void UnitTest::case_RobotHandler_checkVectorFormat()
{
    // Assuming vector should not contain negative numbers
    QVector<int> test(3);
    test[0] = 1;
    test[1] = 2;
    test[2] = 0;
    QVERIFY2(testRobotHandler.checkVectorFormat(test) == true, "All elements are non-negative, must return true.");
    test[1] *= -1;
    QVERIFY2(testRobotHandler.checkVectorFormat(test) == false, "Some elements are negative, must return false.");
}

QTEST_APPLESS_MAIN(UnitTest)

#include "tst_unittest.moc"
