@echo off
title platform-tools工具包
color 0D
cls

:menu
cls
echo ************************
echo *     Platform工具     *
echo *    by NeX-Tritium    *
echo ************************
echo.
echo 请选择你的操作
echo ========================
echo a) 进入Fastboot工具箱
echo b) 进入ADB工具箱
echo c) 阅读readme
echo q) 退出

CHOICE /C abq /N
if %errorlevel%==1 goto fbhome
if %errorlevel%==2 goto adbhome
if %errorlevel%==3 %b2eincfilepath%\readme.txt
if %errorlevel%==4 exit

:fbhome
cls
echo ************************
echo *     Fastboot工具     *
echo *    by NeX-Tritium    *
echo ************************
echo.
echo 请选择你的操作
echo ========================
echo a) 列出设备
echo b) 刷写
echo c) 刷入zip
echo d) 解锁bootloader
echo e) 刷入platform-tools目录下的所有镜像
echo f) 进入Fastboot命令行
echo q) 退出

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
echo 完成！
pause
goto fbhome

:flall
cls
%b2eincfilepath%\platform-tools\fastboot.exe flashall
goto done

:zip
cls
set /p path=请将Zip包拖动到这里并回车:
%b2eincfilepath%\platform-tools\fastboot.exe update %path%
goto done

:fbcmd
cls
echo [Fastboot] *输入命令时请省略fastboot,输入exit退出
:fbcmd1
set /p command=Fastboot$ 
if %command%==exit goto fbhome
%b2eincfilepath%\platform-tools\fastboot.exe %command%
goto fbcmd1


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
if %errorlevel%==7 goto fbhome

cls
echo ========================
echo 准备完毕，是否现在开始烧写?
echo ========================
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
echo ========================
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
echo ========================
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


::ADB TOOL
title ADB工具

:adbhome
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
echo c) 启动ADB命令行
echo d) 启动ADB Shell
echo q) 退出

CHOICE /C abcq /N
if %errorlevel%==1 goto adbreboot
if %errorlevel%==2 goto install
if %errorlevel%==3 goto adbcmd
if %errorlevel%==4 goto adbshell
if %errorlevel%==5 goto menu

:adbreboot
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
set /p path=请将apk文件拖动到这里并回车:
echo 开始安装...
%b2eincfilepath%\platform-tools\adb.exe install %path%
goto done

:done
echo 完成!
pause
goto adbhome

:adbcmd
cls
echo [ADB CMD] *请省略adb,exit退出
echo ========================
:adbcmd1
if %command%==exit goto adb home
set /p command=Android$ 
goto adbcmd1

:adbshrll
cls
echo [ADB SHELL] *exit退出
echo ========================
%b2eincfilepath%\platform-tools\adb.exe shell
goto menu