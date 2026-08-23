@echo off
echo Resetting linux...
rmdir /s /q linux
mkdir linux\x64
mkdir linux\arm64
echo Resetting windows...
rmdir /s /q windows
mkdir windows\x64
mkdir windows\arm64
mkdir windows\x86
echo All done!