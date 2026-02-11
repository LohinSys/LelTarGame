@echo off
echo Resetting linux...
rmdir /s /q linux
mkdir linux
echo Resetting windows...
rmdir /s /q windows
mkdir windows
cd windows
mkdir x64
mkdir x86
echo All done!