# -*-Coding = UTF-8-*-
# Wrinteen by GitHub@TritiumXs

import power_print
from sys import executable
from tempfile import gettempdir
from zipfile import ZipFile
from ctypes import windll
from os import system, makedirs, path, remove
from shutil import rmtree
from wget import download, filename_from_url
from time import sleep
from requests import get
from sys import exit
from platform import system as p_system

print("\033[2J")

# 设置变量
adb_url = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip?hl=zh-cn"
driver_url = "https://dl.google.com/android/repository/usb_driver_r13-windows.zip?hl=zh-cn"

tmp_path = gettempdir()

install_path = "C:\\"

def check_system():
    if p_system() != "Windows":
        power_print.p_tips("该脚本仅适用于Windows")
        sleep(5)
        exit(-2)

# 欢迎界面
def hello():
    power_print.total_title("一键配置ADB环境    ", symbol_length=46)
    print("Powered by GitHub@TritiumXs")
    print()


# 对服务器进行响应
def response(url):
    server_code = get(url).status_code  # 获取服务器状态码
    if server_code != 200:
        power_print.p_tips("连接至服务器时出错！返回状态码为" + str(server_code), mode="error")
        power_print.p_tips("正在退出")
        sleep(1)
        exit(-2)


# 下载platform-tools并处理
def process_adb():
    power_print.title("正在下载platform-tools")
    response(adb_url)  # 测试服务器连接
    adb_name = filename_from_url(adb_url)  # 获取adb安装包名字
    dl_path = download(adb_url, out=path.join(tmp_path, adb_name))  # 下载安装包&&获取下载路径
    print()
    power_print.p_tips("文件已经下载到: " + dl_path)

    power_print.p_tips("正在解压platform-tools")
    mk_path(install_path + "platform-tools")  # 试图创建文件夹
    ZipFile(tmp_path + "\\" + adb_name).extractall(install_path)  # 解压文件夹

    power_print.p_tips("正在设置环境变量")
    # 设置环境变量
    system("powershell $addPath=‘" + install_path + "platform-tools’; $target=‘Machine’ ; $path = ["
                                                    "Environment]::GetEnvironmentVariable(‘Path’, $target); $newPath "
                                                    "= $path + ‘;’ + $addPath; ["
                                                    "Environment]::SetEnvironmentVariable(“Path”, $newPath, $target)")


# 下载usb驱动并处理
def process_driver():
    power_print.title("正在下载GoogleUSB-Driver")
    response(driver_url)  # 测试服务器
    driver_name = filename_from_url(driver_url)  # 获取驱动安装包名
    dl_path = download(driver_url, out=path.join(tmp_path, driver_name))  # 下载安装包&&获取下载路径
    print()
    power_print.p_tips("文件已经下载到:" + dl_path)

    power_print.p_tips("正在解压Driver")
    mk_path(tmp_path + "\\" + "usb_driver")  # 试图创建文件夹

    # 解压安装包
    ZipFile(dl_path).extractall(tmp_path)

    power_print.p_tips("正在安装Driver")
    system("pnputil -i -a " + tmp_path + "\\usb_driver\\*.inf")


# 清理临时文件
def del_file():
    power_print.title("正在清理文件")
    del_files = (
        "platform-tools-latest-windows.zip", "platform-tools-latest-windows (1).zip", "usb_driver_r13-windows.zip",
        "usb_driver_r13-windows (1).zip")

    # 删除安装包
    for filename in del_files:
        if path.exists(tmp_path + "\\" + filename):
            remove(path.join(tmp_path, filename))

    # 删除临时文件夹
    try:
        rmtree(tmp_path + "\\" + "usb_driver")
    except:
        pass

    try:
        rmtree(tmp_path + "\\" + "platform-tools")
    except:
        pass

    sleep(2)
    power_print.p_tips("清理完成！正在退出")
    sleep(1)


# 建立文件夹函数
def mk_path(dir_path):
    # 判断目录是否存在
    folder = path.exists(dir_path)
    if not folder:
        makedirs(dir_path)


# 提权&&判断函数
def uac():
    while not bool(windll.shell32.IsUserAnAdmin()):
        print("正在检测权限")
        windll.shell32.ShellExecuteW(None, "runas", executable, __file__, None, 1)  # 提权代码

        # 当没有管理员权限时，提权
        if not bool(windll.shell32.IsUserAnAdmin()):
            power_print.p_tips("权限获取失败！", mode="warning")
            print("按下回车关闭，或输入r并回车重试")
            i = input()
            if i != "R" and i != "r":
                exit(-1)
            else:
                windll.shell32.ShellExecuteW(None, "runas", executable, __file__, None, 1)
    power_print.p_tips("正在以管理员权限运行")
    print()


# 主函数
if __name__ == "__main__":
    check_system()
    hello()
    uac()
    process_adb()
    process_driver()
    del_file()
    exit(0)
