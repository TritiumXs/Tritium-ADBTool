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
title Fastbootˢд����
color 0D
cls

:home
cls
echo ************************
echo *     Fastboot����     *
echo *    by NeX-Tritium    *
echo ************************
echo ��ѡ����Ĳ���
echo ========================
echo a) �г��豸
echo b) ˢд
echo c) ˢ��zip
echo d) ����bootloader
echo e) ˢ��platform-toolsĿ¼�µ����о���
echo f) ����adb������
echo q) �˳�

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
echo ��ɣ�
pause
goto home

:flall
cls
%b2eincfilepath%\platform-tools\fastboot.exe flashall
goto done

:zip
cls
set /p path=�뽫Zip���϶������ﲢ�س�:
%b2eincfilepath%\platform-tools\fastboot.exe update %path%
goto done

:adb
cls
%b2eincfilepath%\boot2rec.bat
goto home

:pre
cls
echo ========================
echo ����ˢ����ļ���%~nx1
echo ========================
echo.
echo ========================
echo ��ѡ��ˢ��ķ���
echo.
echo a) boot����
echo b) recovery����
echo 1) system����
echo 2) dtbo����
echo 3) vendor����
echo 4) vbmeta����
echo q) ����
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
echo ׼����ϣ��Ƿ����ڿ�ʼ��д?
echo [Y]�� [N]��
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
echo ׼����ϣ��Ƿ����ڿ�ʼ��д?
echo [Y]�� [N]��
CHOICE /C YN /N
if %errorlevel%==1 goto %part%
if %errorlevel%==2 goto pre

:vbmeta
echo ========================
echo �Ƿ�Ҫ����avb? [Y]�� [N]��
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
echo ���ڽ���Bootloader...
%b2eincfilepath%\platform-tools\fastboot.exe oem unlock
goto done

:end
cls
echo ========================
echo �Ƿ���Ҫ��������?
echo a) ����
echo b) �������˵�
echo c) ��������
echo d) �ػ�
echo d) �˳�
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
echo a) ��������
echo b) ������Fastboot
echo c) ������Recovery (���ļ�)
echo d) ������9008ģʽ (����ͨ)
echo q) ����
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
set /p path=�뽫Recovery�ļ��϶������ﲢ�س�:
%b2eincfilepath%\platform-tools\fastboot.exe boot %path%
goto done

:rebootd
cls
%b2eincfilepath%\platform-tools\fastboot.exe oem edl
goto done


:erase
echo ========================
echo a) ����data
echo b) ����cache
echo c) �ָ���������
echo q) ����
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
echo ��ɣ�
pause
cls
goto end