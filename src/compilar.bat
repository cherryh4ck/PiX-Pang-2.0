echo off
cls
fxc -g pixpang.prg
move pixpang.dcb ..\pixpang.dcb
pause
cd ..
fxi pixpang.dcb
exit