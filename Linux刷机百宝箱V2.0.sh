#!/bin/bash

# Copyright Baidaidai——GFWD ，盗用者死🐎🐎

#Power by yhangy.top

#Create By VSCode

echo "   您正在使用由_白呆呆_开发的Linux刷机百宝箱📦"
sleep 3
echo "   感谢您支持正版，支持原创，享受正版品质!"
sleep 3
echo "   如果您是从非Github上下载的，可能有格机的风险!!!"
echo "   如果您是付费购买的，请立刻举报&退款"
sleep 3
read -p "   输入”一切问题均由使用者承担“以继续：" answer

if [ "$answer" == "一切问题均由使用者承担" ]; then
    echo "请输入想要使用的功能："
    read -p "1.进入fastboot 2.重启 3.进入recovery 4.退出 :" cho1
    if [ "$cho1" == 1 ]; then
        adb reboot bootloader
        echo "正在进入fastboot"
        #进入fastboot
        if [ $? -eq 0 ]; then
            sleep 3
            echo "似乎fastboot加载正常？"
            echo "若屏幕中有fastboot或米兔图案则为进入fastboot成功"
            sleep 2
            echo "请问您接下来想要做什么？"
            #选项很重要
            read -p "1.抹除Data分区 2.刷入修改过的boot.img 3.进入fastobooted 4.重启 5.退出" cho2
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
            #刷入镜像
            elif [ "$cho2" == 2 ]; then
                echo "您选择了刷入修改过的boot.img镜像,"
                sleep 1
                echo "请注意，必须将.img文件命名为'boot.img'！！！"
                sleep 1
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
                    echo "即将退出"
                    sleep 3
                    clear
                    exit 1
                fi
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
            #用户选择退出脚本
            elif [ "$cho2" == 5 ]; then
                echo "您选择了'退出'"
                echo "欢迎您的下次使用！"
                echo "脚本结束"
                sleep 3
                clear
                exit 0
            fi
        #用户未选择，要求重新选择～～～
        else
            echo "您未输入任何值"
            sleep 1
            echo "脚本即将退出"
            sleep 3
            clear
            exit 1
        fi
    #用户选择了重启
    elif [ "$cho1" == 2 ]; then
        adb reboot
        echo "重启中"
        if [ $? -eq 0 ]; then
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
        echo "正在进入recovery界面"
        if [ $? -eq 0 ]; then
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
    else
        echo "您未选择任何选项，脚本即将退出"
        sleep 3
        clear
        exit 1
    fi
else
    echo "由于您未按标准输入正确答案"
    echo "已退出脚本"
    sleep 3
    clear
    exit 1
fi
