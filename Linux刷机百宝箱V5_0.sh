#!/bin/bash

# Copyright Baidaidai——GFWD ，盗用者死🐎🐎

#Power by yhangy.top

#Create By VSCode

echo "   您正在使用由_白呆呆_开发的Linux刷机百宝箱V4.0📦"
sleep 3
echo "   感谢您支持正版，支持原创，享受正版品质!"
sleep 3
echo "   如果您是从非Github上下载的，可能有格机的风险!!!"
echo "   项目的官网是'https://github.com/Baidaidai-GFWD/Linux_MagicBox'"
echo "   如果您是付费购买的，请立刻举报&退款"
sleep 4
read -p "   输入”一切问题均由使用者承担“以继续: " answer

if [ "$answer" == "一切问题均由使用者承担" ]; then
    while true; do
        while true; do
            adb devices | grep -w "device"

            if [ $? -eq 1 ]; then
                echo "设备未通过数据线/ADB无线调试连接到电脑"
                sleep 1.5
                echo "玩个锤子🔨"
                sleep 1.5
                echo "若已用数据线连接请检查数据线状态,未连接设备脚本'暂不运行!'"
                sleep 2
                clear
            else
                echo "请输入想要使用的功能："
                read -p "1.进入fastboot 2.重启 3.进入recovery 4.退出 5.adb搞基功能:" cho1
                #用户选择进入了fastboot
                if [ "$cho1" == 1 ]; then
                    adb reboot bootloader
                    #进入fastboot
                    if [ $? -eq 0 ]; then
                        echo "正在进入fastboot"
                        sleep 3
                        echo "似乎fastboot加载正常？"
                        echo "若屏幕中有fastboot或米兔图案则为进入fastboot成功"
                        sleep 2
                        echo "请问您接下来想要做什么？"
                        #选项很重要
                        while true; do
                            read -p "1.抹除Data分区 2.刷入修改过的boot.img 3.进入fastobooted 4.重启 5.刷入通用系统镜像GSI 6.退出" cho2
                            #用户选择抹data分区
                            if [ "$cho2" == 1 ]; then
                                echo "您选择了‘抹除Data分区’"
                                echo "我们需要再次确认您的选择"
                                read -p "请输入y后执行，若输入n会直接退出" emecho
                                #确认用户选择
                                if [ "$emecho" == "y" ]; then
                                    fastboot erase data
                                    if [ $? -eq 0 ]; then
                                        echo "清除数据完成，脚本结束！"
                                        sleep 3
                                        clear
                                        exit 0
                                    else
                                        echo "清除数据失败"
                                        sleep 1
                                        echo "疑似变砖？请谨慎对待！！！"
                                        sleep 3
                                        clear
                                        exit 1
                                    fi

                                elif [ "$emecho" == "n" ]; then
                                    echo "您选择了退出脚本"
                                    sleep 1
                                    echo "脚本正在退出"
                                    sleep 2
                                    clear
                                    exit 0

                                else
                                    echo "我不能确确定您的选择"
                                    echo "即将退出脚本"
                                    sleep 3
                                    clear
                                    exit 1
                                fi
                            #用户选择了刷boot
                            elif [ "$cho2" == 2 ]; then
                                echo "您选择了刷入修改过的boot.img镜像,"
                                sleep 1
                                echo "请注意，必须将.img文件命名为'boot.img'！！！"
                                sleep 1
                                while true; do
                                    read -p "请在箭头后面拖入您想要刷入的boot.img，若想退出则输入'退出'  👉" img
                                    if [ "$img" == "退出" ]; then
                                        echo "您选择了退出"
                                        sleep 1
                                        echo "正在退出"
                                        sleep 3
                                        clear
                                        exit 0
                                    elif [[ "$img" == *.img ]]; then
                                        echo "您拖入了一个boot.img文件"
                                        sleep 1
                                        fastboot flash boot $img
                                        if [ $? -eq 0 ]; then
                                            sleep 2
                                            echo "刷入成功,正在退出脚本并为您设备重启"
                                            sleep 3
                                            fastboot reboot
                                            clear
                                            exit 0
                                        else
                                            echo "刷入失败，请检查boot.img是否正常？"
                                            sleep 1
                                            echo "脚本退出中。。。"
                                            sleep 3
                                            clear
                                            exit 1
                                        fi
                                    else
                                        echo "您即没有选择刷机，也没有选择退出"
                                        sleep 1
                                        echo "请重新选择！"
                                        sleep 3
                                        clear
                                    fi
                                done
                            #进入fastbooted
                            elif [ "$cho2" == 3 ]; then
                                echo "您选择了进入fastbooted"
                                fastboot reboot fastboot
                                if [ $? -eq 0 ]; then
                                    sleep 3
                                    echo "似乎fastbooted加载正常？"
                                    echo "若屏幕中有‘fastbooted’的蓝色字样则为进入成功！"
                                    echo "脚本结束"
                                    sleep 3
                                    clear
                                    exit 0
                                else
                                    echo "fastbooted加载出错，请重试!"
                                    echo "脚本结束"
                                    sleep 3
                                    clear
                                    exit 1
                                fi
                            #重启
                            elif [ "$cho2" == 4 ]; then
                                echo "您选择了重启"
                                fastboot reboot
                                if [ $? -eq 0 ]; then
                                    sleep 3
                                    echo "似乎'重启'正常？"
                                    echo "若屏幕中有'小米logo字样'则为进入成功！"
                                    echo "脚本结束"
                                    sleep 3
                                    clear
                                    exit 0
                                else
                                    echo "重启出错，请重试!"
                                    echo "脚本结束"
                                    sleep 3
                                    clear
                                    exit 1
                                fi
                            #用户选择刷入GSI
                            elif [ "$cho2" == 5 ]; then
                                echo "您选择了刷入通用系统镜像GSI"
                                sleep 1
                                echo "声明：本脚本不具有分辨手机系统分区与您要刷入的GSI分区是否一致，请您自行确认后再刷入"
                                sleep 3
                                echo "为了防止您错误选择而造成数据的损失，请跟随指引完成验证···"
                                sleep 1
                                while true; do
                                    read -p "请输入y以继续,输入n以退出" queren
                                    if [ "$queren" == y ]; then
                                        echo "请将您要刷入的GSI包命名成如下格式' GSI.img'"
                                        sleep 1
                                        while true; do
                                            read -p "请在箭头后拖入您所准备的GSI包，若退出请输入'退出'  请拖入'GSI.img'👉" GSI
                                            if [[ "$GSI" == *img ]]; then
                                                fastboot flash system $GSI
                                                if [ $? -eq 0 ]; then
                                                    sleep 3
                                                    echo "刷入完成，正在为您重启中,可能需要等待一会儿"
                                                    sleep 3
                                                    fastboot reboot
                                                    echo "重启完成，正在退出脚本，欢迎下次使用！"
                                                    sleep 3
                                                    clear
                                                    exit 0
                                                else
                                                    echo "刷入GSI镜像失败，请重试"
                                                    sleep 1
                                                    echo "脚本退出中"
                                                    sleep 1
                                                    clear
                                                    exit 1
                                                fi
                                            elif [ "$GSI" == "退出" ]; then
                                                echo "您选择了退出"
                                                sleep 1
                                                echo "脚本正在退出"
                                                sleep 1
                                                clear
                                                exit 0
                                            else
                                                echo "您即没有选择退出，也没有选择刷入GSI镜像"
                                                sleep 2
                                                echo "请重新进行选择!"
                                                sleep 3
                                                clear
                                            fi
                                        done
                                    elif [ "$queren" == n ]; then
                                        echo "您选择了退出"
                                        sleep 1
                                        echo "脚本正在关闭，感谢您的使用！"
                                        sleep 3
                                        clear
                                        exit 0
                                    else
                                        echo "您未输入任何值"
                                        sleep 1
                                        echo "请重新选择"
                                        sleep 2
                                        clear
                                    fi
                                done
                            #用户选择退出脚本
                            elif [ "$cho2" == 6 ]; then
                                echo "您选择了'退出'"
                                echo "欢迎您的下次使用！"
                                echo "脚本结束"
                                sleep 3
                                clear
                                exit 0
                            #用户未选择，要求重新选择～～～
                            else
                                echo "您未选定任何值"
                                sleep 1
                                echo "请重新选择！"
                                sleep 3
                                clear
                            fi
                        done
                    else
                        echo "进入fastboot失败"
                        sleep 1
                        echo "请检查设备连接状态以及fastboot版本"
                        sleep 2
                        echo “正在退出脚本”
                        sleep 3
                        clear
                        exit 1
                    fi
                #用户选择了重启
                elif [ "$cho1" == 2 ]; then
                    adb reboot
                    if [ $? -eq 0 ]; then
                        echo "重启中"
                        sleep 5
                        echo "貌似重启成功？"
                        sleep 1
                        echo "请检查若屏幕中出现'小米logo'则重启成功"
                        sleep 3
                        clear
                        exit 0
                    else
                        echo "重启失败，请检查设备状态！"
                        sleep 3
                        clear
                        exit 1
                    fi

                #用户选择了进入recovery
                elif [ "$cho1" == 3 ]; then
                    adb reboot recovery
                    if [ $? -eq 0 ]; then
                        echo "正在进入recovery界面"
                        sleep 3
                        echo "貌似进入recovery成功？"
                        sleep 1
                        echo "请检查若屏幕中出现'recovery菜单'则进入成功"
                        sleep 3
                        clear
                        exit 0
                    else
                        echo "进入recovery失败，请检查设备状态！"
                        sleep 3
                        clear
                        exit 1
                    fi
                #用户选择了退出脚本
                elif [ "$cho1" == 4 ]; then
                    echo "无论如何，非常感谢您支持并下载了此项目"
                    echo "正在退出"
                    sleep 3
                    clear
                    exit 0
                #用户选择了ADB搞基功能
                elif [ "$cho1" == 5 ]; then
                    echo "您选择了adb搞基功能"
                    sleep 3
                    echo "请在冒号后输入您想使用的模块"
                    while true; do
                        #ADB搞基头选项
                        read -p "1.删除安装模块 2.系统调试模块 3.禁用模块🖕 4.退出脚本    :" mk1
                        if [ "$mk1" == 1 ]; then
                            echo "您选择了删除安装模块"
                            sleep 2
                            echo "请选择您需要请输入'删除apk/安装apk'"
                            sleep 1
                            #删除&安装APK选项
                            read -p "删除apk  安装apk  :" apk
                            while true; do
                                #用户选择了删除APK
                                if [ "$apk" == "删除apk" ]; then
                                    echo "您已经进入了连续删除apk选项"
                                    sleep 1
                                    echo "若想终止可在任意时刻输入'退出'即可"
                                    sleep 3
                                    while true; do
                                        read -p "请在冒号':'后输入您想要卸载的应用包名:" bm
                                        if [[ "$bm" == com.* ]]; then
                                            echo "删除中"
                                            adb shell pm uninstall --user 0 $bm
                                            if [ $? -eq 0 ]; then
                                                echo "删除成功"
                                                sleep 0.5
                                            else
                                                echo "删除失败，可能是权限不足？"
                                            fi
                                        elif [ "$bm" == "退出" ]; then
                                            echo "正在结束脚本中"
                                            sleep 3
                                            clear
                                            exit 0
                                        else
                                            echo "未检测到您输入了一个正确的值"
                                            sleep 1
                                            echo "请重新输入"
                                            sleep 1
                                        fi
                                    done
                                #用户选择了安装APk
                                elif [ "$apk" == "安装apk" ]; then
                                    echo "您已进入了连续安装apk选项"
                                    echo "请将待安装的软件命名为'az.apk'!!"
                                    sleep 1
                                    echo "若想终止可在任意时刻输入'退出'即可"
                                    sleep 3
                                    while true; do
                                        read -p "请在箭头后拖入您想要安装的应用👉" az
                                        if [[ "$az" == *apk ]]; then
                                            echo "安装中"
                                            adb install $az
                                            if [ $? -eq 0 ]; then
                                                echo "安装成功"
                                                sleep 0.5
                                            else
                                                echo "安装失败，可能是定制系统？"
                                            fi
                                        elif [ "$az" == "退出" ]; then
                                            echo "正在结束脚本中"
                                            sleep 3
                                            clear
                                            exit 0
                                        else
                                            echo "未检测到您输入了一个正确的值"
                                            sleep 1
                                            echo "请重新输入"
                                            sleep 1
                                        fi
                                    done
                                else
                                    echo "您未输入正确值"
                                    sleep 1
                                    echo "请重新输入"
                                    sleep 3
                                    clear
                                fi
                            done
                        #用户选择了系统调试
                        elif [ "$mk1" == 2 ]; then
                            echo "您选择了系统调试模块"
                            sleep 3
                            echo "请在冒号后输入您想要进入的模块的代号"
                            while true; do
                                #系统调试首选项
                                read -p "1.屏幕调试 2.电池调试 3.退出脚本  :" tsmk
                                #用户选择了屏幕调试
                                if [ "$tsmk" == 1 ]; then
                                    echo "您选择了屏幕调试"
                                    sleep 2
                                    echo "请在冒号后输入您想要调试的屏幕功能代号"
                                    while true; do
                                        #屏幕调试主选项
                                        read -p "1.状态栏隐藏 2.导航栏隐藏 3.导航栏&状态栏恢复 4.修改分辨率 5.修改DPI 6.退出脚本  :" pmts
                                        if [ "$pmts" == 1 ]; then
                                            #用户选择了状态栏隐藏
                                            echo "您选择了状态栏隐藏"
                                            adb shell settings put global policy_control immersive.status=*
                                            if [ $? -eq 0 ]; then
                                                echo "状态栏隐藏成功"
                                                echo "有些深度定制的系统有可能会失败，请谅解！"
                                                sleep 2
                                            else
                                                echo "状态栏隐藏失败"
                                                sleep 2
                                            fi
                                        elif [ "$pmts" == 2 ]; then
                                            #用户选择了导航栏隐藏
                                            echo "您选择了导航栏隐藏"
                                            adb shell settings put global policy_control immersive.navigation=*
                                            if [ $? -eq 0 ]; then
                                                echo "导航栏隐藏成功"
                                                echo "有些深度定制的系统有可能会失败，请谅解！"
                                                sleep 2
                                            else
                                                echo "导航栏隐藏失败"
                                                sleep 2
                                            fi
                                        elif [ "$pmts" == 3 ]; then
                                            #用户选择双恢复
                                            echo "您选择了状态栏&导航栏恢复"
                                            adb shell settings put global policy_control null
                                            if [ $? -eq 0 ]; then
                                                echo "恢复成功"
                                                echo "有些深度定制的系统有可能会失败，请谅解！"
                                                sleep 2
                                            else
                                                echo "恢复失败"
                                                sleep 2
                                            fi
                                        elif [ "$pmts" == 4 ]; then
                                            echo "您选择了修改分辨率"
                                            sleep 1
                                            echo "请在冒号后输入您想要修改的分辨率，例如'1080x1920'"
                                            while true; do
                                                read -p "请输入想要修改的分辨率，若想退出脚本则输入'退出'  :" fbl
                                                if [[ "$fbl" == *x* ]]; then
                                                    adb shell wm size $fbl
                                                    if [ $? -eq 0 ]; then
                                                        echo "修改分辨率成功"
                                                    else
                                                        echo "修改分辨率失败"
                                                    fi
                                                elif [ "$fbl" == "退出" ]; then
                                                    echo "您选择了退出"
                                                    sleep 3
                                                    clear
                                                    exit 0
                                                else
                                                    echo "您未选择合适的选项"
                                                    sleep 1
                                                    echo "请重新输入"
                                                fi
                                            done
                                        elif [ "$pmts" == 5 ]; then
                                            echo "您选择了修改DPI"
                                            sleep 1
                                            echo "请在冒号后输入您想要修改的DPI,例如'320'"
                                            while true; do
                                                read -p "请输入您希望修改的DPI,若想退出请输入'退出':" dpi
                                                if [ "$dpi" == "退出" ]; then
                                                    echo "您选择了退出"
                                                    sleep 3
                                                    clear
                                                    exit 0
                                                else
                                                    adb shell wm density $dpi
                                                    if [ $? == 0 ]; then
                                                        echo "DPI修改成功"
                                                        sleep 3
                                                    else
                                                        echo "DPI修改失败"
                                                        sleep 3
                                                    fi
                                                fi
                                            done
                                        elif [ "$pmts" == 6 ]; then
                                            echo "您选择了退出脚本"
                                            sleep 2
                                            echo "正在退出脚本"
                                            sleep 2
                                            clear
                                            exit 0
                                        else
                                            echo "您未输入正确选项"
                                            sleep 2
                                            echo "请重新输入！"
                                            sleep 2
                                            clear
                                        fi
                                    done
                                elif [ "$tsmk" == 2 ]; then
                                    echo "您选择了电池调试"
                                    sleep 3
                                    echo "请在冒号后输入您想进入的电池调试的模块代号"
                                    while true; do
                                        read -p "1.修改电池温度 2.修改电池百分比 3.修改电池充电状态为无线充电 4.退出脚本   :" dcts
                                        if [ "$dcts" == 1 ]; then
                                            echo "您选择了修改电池温度"
                                            sleep 2
                                            while true; do
                                                read -p "请输入想要修改的温度值，若想退出请输入'退出'" dcwd
                                                sleep 1
                                                if [ "$dcwd" == "退出" ]; then
                                                    echo "您选择退出脚本"
                                                    sleep 2
                                                    echo "脚本退出中"
                                                    sleep 2
                                                    clear
                                                    exit 0
                                                else
                                                    adb shell dumpsys battery set temperature $dcwd
                                                    if [ $? == 0 ]; then
                                                        echo "电池温度修改成功"
                                                        sleep 2
                                                    else
                                                        echo "电池温度修改失败"
                                                        sleep 2
                                                    fi
                                                fi
                                            done
                                        elif [ "$dcts" == 2 ]; then
                                            echo "您选择了修改电池百分比"
                                            sleep 2
                                            while true; do
                                                read -p "请输入想要修改的电池百分比，若想退出请输入'退出'" dcbfb
                                                sleep 1
                                                if [ "$dcbfb" == "退出" ]; then
                                                    echo "您选择退出脚本"
                                                    sleep 2
                                                    echo "脚本退出中"
                                                    sleep 2
                                                    clear
                                                    exit 0
                                                else
                                                    adb shell dumpsys battery set level $dcbfb
                                                    if [ $? == 0 ]; then
                                                        echo "电池百分比修改成功"
                                                        sleep 2
                                                    else
                                                        echo "电池百分比修改失败"
                                                        sleep 2
                                                    fi
                                                fi
                                            done
                                        elif [ "$dcts" == 3 ]; then
                                            echo "您选择了修改电池充电状态为无线充电"
                                            sleep 2
                                            adb shell dumpsys battery set level $dcbfb
                                            if [ $? == 0 ]; then
                                                echo "电池百分比修改成功"
                                                sleep 2
                                            else
                                                echo "电池百分比修改失败"
                                                sleep 2
                                            fi
                                        elif [ "$dcts" == 4 ]; then
                                            echo "您选择了退出脚本"
                                            sleep 2
                                            echo "脚本退出中"
                                            sleep 2
                                            clear
                                            exit 0
                                        else
                                            echo "您未输入正确选项"
                                            sleep 3
                                            echo "请重新输入！"
                                            sleep 2
                                        fi
                                    done
                                elif [ "$tsmk" == 3 ]; then
                                    echo "您选择了退出脚本"
                                    sleep 2
                                    echo "脚本退出中"
                                    sleep 2
                                    clear
                                    exit 0
                                else
                                    echo "您未输入任何选项"
                                    sleep 2
                                    echo "请重新输入！"
                                    sleep 2
                                    clear
                                fi
                            done
                        elif [ "$mk1" == 3 ]; then
                            echo "您选择的是禁用模块🖕"
                            sleep 2
                            while true; do
                                read -p "您已进入连续禁用模式，请在冒号后拖入您想要禁用的软件'包名'，例如'com.xiaomi.shop'，若想退出请随时输入'退出'  :  " jyrj
                                if [ "$jyrj" != "" ]; then
                                    if [ "$jyrj" == "退出" ]; then
                                        echo "您选择了退出脚本"
                                        sleep 2
                                        echo "正在退出脚本中"
                                        sleep 2
                                        clear
                                        exit 0
                                    else
                                        adb shell pm disable-user $jyrj
                                        if [ $? -eq 0 ]; then
                                            echo "禁用软件成功！"
                                            sleep 2
                                        else
                                            echo "禁用软件失败，权限不足？"
                                            sleep 2
                                        fi
                                    fi

                                else
                                    echo "您未输入任何值，请重新输入！"
                                    sleep 2
                                    clear
                                fi
                            done
                        elif [ "$mk1" == 4 ]; then
                            echo "您选择了退出脚本"
                            sleep 2
                            echo "正在退出脚本中"
                            sleep 2
                            clear
                            exit 0
                        else
                            echo "您未输入正确的选项"
                            sleep 2
                            echo "请重新输入！"
                            sleep 2
                        fi
                    done
                #用户未选择，要求重新输入
                else
                    echo "您未选择任何选项"
                    sleep 1
                    echo "请重新进行选择！"
                    sleep 3
                    clear
                fi
            fi
        done
    done
else
    echo "由于您未按标准输入正确答案"
    echo "已退出脚本"
    sleep 3
    clear
    exit 1
fi
