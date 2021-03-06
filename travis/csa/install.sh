#!/bin/bash

set -e

# prepare build files
./autogen.sh

./clang+llvm-6.0.0-x86_64-linux-gnu-ubuntu-14.04/bin/scan-build -o scanbuildoutput -plist -v ./configure
./clang+llvm-6.0.0-x86_64-linux-gnu-ubuntu-14.04/bin/scan-build -o scanbuildoutput -plist -v make -j3

if grep -r "\.c" scanbuildoutput | grep "<string>" | grep -v "<key>"; then echo "error" && /bin/false; else echo "ok"; fi 
