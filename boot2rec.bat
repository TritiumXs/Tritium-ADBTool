@echo off
title ADB����
color 0D

:home
cls
echo ************************
echo *        ADB����        *
echo *    by NeX-Tritium    *
echo ************************
echo.
echo *ʹ��ǰ���adb���Բ���װ������
echo.
echo ��ѡ����Ĳ���
echo ========================
echo a) ����
echo b) ��װ���
echo c) ����Fastboot������
echo q) �˳�

CHOICE /C abcq /N
if %errorlevel%==1 goto reboot
if %errorlevel%==2 goto install
if %errorlevel%==3 goto fb
if %errorlevel%==4 exit

:reboot
cls
echo ��ѡ����Ĳ���
echo ========================
echo 1) ��������
echo 2) ������Recovery
echo 3) ������Fastboot
echo b) ����

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
set /p path=�뽫apk�ļ��϶������ﲢ�س�:
echo ��ʼ��װ...
%b2eincfilepath%\platform-tools\adb.exe install %path%
goto done

:done
echo ���!
pause
goto home

:done
echo ��ɣ�
pause
goto home

:fb
cls
%b2eincfilepath%\fbtool.bat