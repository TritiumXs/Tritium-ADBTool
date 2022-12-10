@echo off
title platform-tools���߰�
color 0D
cls

:menu
cls
echo ************************
echo *     Platform����     *
echo *    by NeX-Tritium    *
echo ************************
echo.
echo ��ѡ����Ĳ���
echo ========================
echo a) ����Fastboot������
echo b) ����ADB������
echo c) �Ķ�readme
echo q) �˳�

CHOICE /C abq /N
if %errorlevel%==1 goto fbhome
if %errorlevel%==2 goto adbhome
if %errorlevel%==3 %b2eincfilepath%\readme.txt
if %errorlevel%==4 exit

:fbhome
cls
echo ************************
echo *     Fastboot����     *
echo *    by NeX-Tritium    *
echo ************************
echo.
echo ��ѡ����Ĳ���
echo ========================
echo a) �г��豸
echo b) ˢд
echo c) ˢ��zip
echo d) ����bootloader
echo e) ˢ��platform-toolsĿ¼�µ����о���
echo f) ����Fastboot������
echo q) �˳�

CHOICE /C abcdfq /N
if %errorlevel%==1 goto ls
if %errorlevel%==2 goto pre
if %errorlevel%==3 goto zip
if %errorlevel%==4 goto bl
if %errorlevel%==5 goto fbcmd
if %errorlevel%==6 goto menu

:ls
cls
%b2eincfilepath%\platform-tools\fastboot.exe devices
echo ��ɣ�
pause
goto fbhome

:flall
cls
%b2eincfilepath%\platform-tools\fastboot.exe flashall
goto done

:zip
cls
set /p path=�뽫Zip���϶������ﲢ�س�:
%b2eincfilepath%\platform-tools\fastboot.exe update %path%
goto done

:fbcmd
cls
echo [Fastboot] *��������ʱ��ʡ��fastboot,����exit�˳�
:fbcmd1
set /p command=Fastboot$ 
if %command%==exit goto fbhome
%b2eincfilepath%\platform-tools\fastboot.exe %command%
goto fbcmd1


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
if %errorlevel%==7 goto fbhome

cls
echo ========================
echo ׼����ϣ��Ƿ����ڿ�ʼ��д?
echo ========================
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
echo ========================
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
echo ========================
CHOICE /C abcd /N

if %errorlevel%==1 goto reboot
if %errorlevel%==2 goto fbhome
if %errorlevel%==3 goto erase
if %errorlevel%==4 goto poweroff
if %errorlevel%==5 goto menu

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
echo ========================
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


::ADB TOOL
title ADB����

:adbhome
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
echo c) ����ADB������
echo d) ����ADB Shell
echo q) �˳�

CHOICE /C abcq /N
if %errorlevel%==1 goto adbreboot
if %errorlevel%==2 goto install
if %errorlevel%==3 goto adbcmd
if %errorlevel%==4 goto adbshell
if %errorlevel%==5 goto menu

:adbreboot
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
if %errorlevel%==4 goto adbhome


:r1
cls
echo ========================
%b2eincfilepath%\platform-tools\adb.exe reboot
goto done

:r2
cls
echo ========================
%b2eincfilepath%\platform-tools\adb.exe reboot recovery
goto done

:r3
cls
echo ========================
%b2eincfilepath%\platform-tools\adb.exe reboot fastboot
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
goto adbhome

:adbcmd
cls
echo [ADB CMD] *��ʡ��adb,exit�˳�
echo ========================
:adbcmd1
if %command%==exit goto adb home
set /p command=Android$ 
goto adbcmd1

:adbshrll
cls
echo [ADB SHELL] *exit�˳�
echo ========================
%b2eincfilepath%\platform-tools\adb.exe shell
goto menu