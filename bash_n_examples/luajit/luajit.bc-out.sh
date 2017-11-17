luajit -bl luajit.lua > luajit.bcode.list
luajit -b -t raw luajit.lua luajit.bcode.raw
luajit -b -t c luajit.lua luajit.bcode.c
luajit -b -t h luajit.lua luajit.bcode.h
luajit -b -t obj luajit.lua luajit.bcode.obj
luajit -b -t o luajit.lua luajit.bcode.o
#luajit -b -t default luajit.lua luajit.bcode.default
