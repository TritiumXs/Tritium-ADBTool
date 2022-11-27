@echo off
title ADB工具
color 0D

:home
cls
echo ************************
echo *        ADB工具        *
echo *    by NeX-Tritium    *
echo ************************
echo.
echo *使用前请打开adb调试并安装好驱动
echo.
echo 请选择你的操作
echo ========================
echo a) 重启
echo b) 安装软件
echo c) 返回Fastboot工具箱
echo q) 退出

CHOICE /C abcq /N
if %errorlevel%==1 goto reboot
if %errorlevel%==2 goto install
if %errorlevel%==3 goto fb
if %errorlevel%==4 exit

:reboot
cls
echo 请选择你的操作
echo ========================
echo 1) 正常重启
echo 2) 重启到Recovery
echo 3) 重启到Fastboot
echo b) 返回

CHOICE /C 123b /N
if %errorlevel%==1 goto r1
if %errorlevel%==2 goto r2
if %errorlevel%==3 goto r3
if %errorlevel%==4 goto home


:r1
cls
echo ========================
%b2eincfilepath%\platform-tools\adb.exe reboot
goto done

:r2
cls
echo ========================
%b2eincfilepath%\platform-tools\adb.exe recovery
goto done

:r3
cls
echo ========================
%b2eincfilepath%\platform-tools\adb.exe fastboot
goto done

:install
cls
echo ========================
set /p path=请将apk文件拖动到这里并回车:
echo 开始安装...
%b2eincfilepath%\platform-tools\adb.exe install %path%
goto done

:done
echo 完成!
pause
goto home

:done
echo 完成！
pause
goto home

:fb
cls
%b2eincfilepath%\fbtool.bat