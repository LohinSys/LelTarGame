@echo off
echo Resetting 'linux'...
rd /s /q linux
md linux\x64
md linux\arm64
echo Resetting 'windows'...
rd /s /q windows
md windows\x64
md windows\arm64
md windows\x86
echo All done!