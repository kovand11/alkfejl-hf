#ifndef TST_UNITTEST_H
#define TST_UNITTEST_H

//#define REAL_CHECK_SPEED_FORMAT_READY

#include <QString>
#include <QVector>
#include <QtTest>

#ifdef REAL_CHECK_SPEED_FORMAT_READY
#include "../RoboControll/robothandler.h"
#else
/**
 * @brief A dummy class, which will be used until the real functions are ready.
 *
 * @note Please define REAL_CHECK_SPEED_FORMAT_READY to prevent this dummy class from being compiled.
 *
 * This dummy class defines the functions of the real RobotHandler class whit less to no functionality.
 */

class RobotHandler : public QObject
{
    Q_OBJECT
public:
    /**
     * A function which verifies the speed data.
     *
     * @param speed A string that should contain a positive number.
     *
     * @returns Always returns true.
     */
    bool checkSpeedFormat(QString speed)
    {
        Q_UNUSED(speed);
        return true;
    }

    /**
     * A function which verifies the intVector data.
     *
     * @param intVector A QVector that should contain positive elements.
     *
     * @returns Always returns true.
     */
    bool checkVectorFormat(QVector<int> intVector)
    {
        Q_UNUSED(intVector);
        return true;
    }
};
#endif /*REAL_CHECK_SPEED_FORMAT_READY*/

/**
 * @brief A class containing the unit tests.
 *
 * @note: This class is part of a Qt Unit Test project.
 * @warning: This class must not be instantiated anywhere else.
 *
 * Instantiates the Unit Under Test and defines all test cases.
 * Tests all functions except for signals and slots.
 * Functions with a name ending with "_data" are used to provide the test data set for the function with the same name (without "_data").
 */

class UnitTest : public QObject
{
    Q_OBJECT

public:
    /**
     * Default constructor.
     */
    UnitTest() = default;

private Q_SLOTS:
    /**
     * Test data set containing input and expected results for the test case with the same name without "_data".
     */
    void case_RobotHandler_checkSpeedFormat_data();

    /**
     * Test case for RobotHandler::checkSpeedFormat() , which verifies said functions return value for the following inputs:
     *  - positive integer
     *  - positive decimal
     *  - text
     *  - negative integer
     */
    void case_RobotHandler_checkSpeedFormat();

    /**
     * Test case for RobotHandler::checkVectorFormat() , which verifies said functions return value for the following inputs:
     *  - QVector containing non-negative integers.
     *  - QVector containing negative integers.
     */
    void case_RobotHandler_checkVectorFormat();

private:
    /**
     * Instance of the UUT.
     */
    RobotHandler testRobotHandler;
};

#endif // TST_UNITTEST_H

