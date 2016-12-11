QT       += qml quick testlib

QT       -= gui
QT       += testlib

TARGET = tst_unittest
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += tst_unittest.cpp
DEFINES += SRCDIR=\\\"$$PWD/\\\"
