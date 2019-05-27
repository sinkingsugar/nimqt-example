# Qt and nim sample

### By leveraging nimline/fragments (https://github.com/fragcolor-xyz/nimline) easily use Qt with nim

## Things to notice:

### In the generated `mainwindow.cpp` we need to manually add externs to nim calls, e.g.:
```
//nim extern
extern "C" void buttonClick();

# nim side
proc buttonClick() {.exportc, dynlib, cdecl.} = echo "hello button2"
```

### I'm not a Qt expert, many other cool things can be done probably

### Qt side it all boils down to this (in the `.pro` file)
```
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
```