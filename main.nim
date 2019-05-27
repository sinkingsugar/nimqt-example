import os
import nimline

# this is needed in the custom build step e.g: nim.exe cpp -d:qtInclude=%{Qt:QT_INSTALL_HEADERS} --app:staticlib -o:main.a main.nim
const qtInclude {.strdefine.} = ""
let includes {.compileTime.} = "-I" & qtInclude & " -I" & qtInclude & "/QtWidgets"
{.passC: includes.}

defineCppType(QApplication, "QApplication", "QApplication")
defineCppType(MainWindow, "MainWindow", "mainwindow.h")

var nargv =  newSeq[string](paramCount())
var x = 0
while x < paramCount():
  nargv[x] = paramStr(x+1)  # first is program name
  x += 1

var argv = nargv.allocCStringArray()

proc buttonClick() {.exportc, dynlib, cdecl.} = echo "hello button2"

proc main() {.noinit.} =
  var
    argc = cint(paramCount())
    a = cppinit(QApplication, argc, argv)
    w = cppinit(MainWindow)
  
  w.show().to(void)
  quit(a.exec().to(cint))

main()
