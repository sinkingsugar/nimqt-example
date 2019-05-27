#-------------------------------------------------
#
# Project created by QtCreator 2019-05-27T17:25:46
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = nimqt
TEMPLATE = app

# Nim related stuff:

# must use a variable as input
NIM_MAIN = main.nim
NimBuildStep.input = NIM_MAIN

# use non-existing file here to execute every time, nim will cache by itself
NimBuildStep.output = null.txt

# the nim compiler call
NimBuildStep.commands = nim cpp -d:qtInclude=$$[QT_INSTALL_HEADERS] --app:staticlib -o:nim_main.a ${QMAKE_FILE_NAME}

# some name that displays during execution
NimBuildStep.name = running Pre-Build nim build

# "no_link" tells qmake we don’t need to add the output to the object files for linking, and "no_clean" means there is no clean step for them.
# "target_predeps" tells qmake that the output of this needs to exist before we can do the rest of our compilation.
NimBuildStep.CONFIG += no_link no_clean target_predeps

# Add the compiler to the list of 'extra compilers'.
QMAKE_EXTRA_COMPILERS += NimBuildStep

# Nim related stuff over

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++11

SOURCES += \
        mainwindow.cpp

HEADERS += \
        mainwindow.h

FORMS += \
        mainwindow.ui

LIBS += \
        nim_main.a

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
