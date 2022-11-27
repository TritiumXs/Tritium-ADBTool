::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHzeyEM0KltAQwuOL1eqCrQI7ufp4qeTrUIRR4I=
::fBE1pAF6MU+EWHzeyEM0KltAQwuOL1eoA7QY5e21+/KTwg==
::fBE1pAF6MU+EWHzeyEM0KltAQwuOL1e8BKET5+S17euTwg==
::fBE1pAF6MU+EWHzeyEM0KltAQwuOL1e4CboIuvr+7KSFo1l9
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCqDJFiA9gIkJxRYXziEPn+1CblS7fD+jw==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
title Fastboot刷写工具
color 0D
cls

:home
cls
echo ************************
echo *     Fastboot工具     *
echo *    by NeX-Tritium    *
echo ************************
echo 请选择你的操作
echo ========================
echo a) 列出设备
echo b) 刷写
echo c) 刷入zip
echo d) 解锁bootloader
echo e) 刷入platform-tools目录下的所有镜像
echo f) 启动adb工具箱
echo q) 退出

CHOICE /C abcdfq /N
if %errorlevel%==1 goto ls
if %errorlevel%==2 goto pre
if %errorlevel%==3 goto zip
if %errorlevel%==4 goto bl
if %errorlevel%==5 goto adb
if %errorlevel%==6 exit

:ls
cls
%b2eincfilepath%\platform-tools\fastboot.exe devices
echo 完成！
pause
goto home

:flall
cls
%b2eincfilepath%\platform-tools\fastboot.exe flashall
goto done

:zip
cls
set /p path=请将Zip包拖动到这里并回车:
%b2eincfilepath%\platform-tools\fastboot.exe update %path%
goto done

:adb
cls
%b2eincfilepath%\boot2rec.bat
goto home

:pre
cls
echo ========================
echo 即将刷入的文件：%~nx1
echo ========================
echo.
echo ========================
echo 请选择刷入的分区
echo.
echo a) boot分区
echo b) recovery分区
echo 1) system分区
echo 2) dtbo分区
echo 3) vendor分区
echo 4) vbmeta分区
echo q) 返回
CHOICE /C ab1234q /N
cls
if %errorlevel%==1 set part=boot
if %errorlevel%==2 set part=recovery
if %errorlevel%==3 set part=system
if %errorlevel%==4 set part=dtbo
if %errorlevel%==5 set part=vendor
if %errorlevel%==6 goto vbmeta
if %errorlevel%==7 goto home

cls
echo 准备完毕，是否现在开始烧写?
echo [Y]是 [N]否
CHOICE /C YN /N
if %errorlevel%==1 goto flashing
if %errorlevel%==2 goto pre



:flashing 
cls
%b2eincfilepath%\platform-tools\fastboot.exe flash %part% %1
goto done

:avbchoice
cls
echo ========================
echo 准备完毕，是否现在开始烧写?
echo [Y]是 [N]否
CHOICE /C YN /N
if %errorlevel%==1 goto %part%
if %errorlevel%==2 goto pre

:vbmeta
echo ========================
echo 是否要解锁avb? [Y]是 [N]否
CHOICE /C YN /N
if %errorlevel%==1 set part=avba
if %errorlevel%==2 set part=avbb
goto avbchoice 


:avba
cls
%b2eincfilepath%\platform-tools\fastboot.exe flash vbmeta %1
goto done

:avbb
cls
%b2eincfilepath%\platform-tools\fastboot.exe --disable-verity --disable-verification flash vbmeta %1
goto done

:bl
cls
echo 正在解锁Bootloader...
%b2eincfilepath%\platform-tools\fastboot.exe oem unlock
goto done

:end
cls
echo ========================
echo 是否还需要其他操作?
echo a) 重启
echo b) 返回主菜单
echo c) 擦除分区
echo d) 关机
echo d) 退出
CHOICE /C abcd /N

if %errorlevel%==1 goto reboot
if %errorlevel%==2 goto home
if %errorlevel%==3 goto erase
if %errorlevel%==4 goto poweroff
if %errorlevel%==5 exit

:poweroff
cls
echo ========================
%b2eincfilepath%\platform-tools\fastboot.exe oem poweroff
goto done

:reboot
cls
echo ========================
echo a) 正常重启
echo b) 重启到Fastboot
echo c) 重启到Recovery (从文件)
echo d) 重启到9008模式 (仅高通)
echo q) 返回
echo ========================
CHOICE /C abcdq /N 

if %errorlevel%==1 goto reboota
if %errorlevel%==2 goto rebootb
if %errorlevel%==3 goto rebootc
if %errorlevel%==4 goto rebootd
if %errorlevel%==5 goto end

:reboota
cls
%b2eincfilepath%\platform-tools\fastboot.exe reboot
goto done

:rebootb
cls
%b2eincfilepath%\platform-tools\fastboot.exe reboot bootloader
goto done

:rebootc
set /p path=请将Recovery文件拖动到这里并回车:
%b2eincfilepath%\platform-tools\fastboot.exe boot %path%
goto done

:rebootd
cls
%b2eincfilepath%\platform-tools\fastboot.exe oem edl
goto done


:erase
echo ========================
echo a) 擦除data
echo b) 擦除cache
echo c) 恢复出厂设置
echo q) 返回
echo ========================

CHOICE /C abcq /N 

if %errorlevel%==1 goto data
if %errorlevel%==2 goto factory
if %errorlevel%==3 goto cache
if %errorlevel%==4 goto done

:data
cls
%b2eincfilepath%\platform-tools\fastboot.exe erase data
goto done

:factory
cls
%b2eincfilepath%\platform-tools\fastboot.exe -w
goto done

:cache
%b2eincfilepath%\platform-tools\fastboot.exe erase cache
goto done

:done
echo 完成！
pause
cls
goto end