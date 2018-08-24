#!/bin/bash
youname = xxx
youpwd = 123456
path_to_save_img="/home/$youname/project/img"
shell_path="/home/$youname/shell"
function fastboot_flash() {
   
    echo "here we go to flash them! >>>>>>>>>>>>"
    echo $youpwd | sudo -S ls
    #sshpass -p 123123 sudo adb reboot bootloader
    sudo adb reboot bootloader
    echo ">>>>>>>"
    sudo fastboot flash boot boot.img
    echo ">>>>>>>"
    sudo fastboot flash system system.img
    echo ">>>>>>>"
    sudo fastboot flash userdata userdata.img
    echo ">>>>>>>"
    sudo fastboot reboot
    echo "fastboot_flash finished..."
}


#main interface
cd $shell_path
echo "enter $shell_path"
case $1 in 
    4r| 4l| 7r| 7l| 15r| 15l)
        ./getimg.sh $1
        cd  $path_to_save_img
        echo "enter $path_to_save_img,and exec fastboot_flash"
        ls
        fastboot_flash
        ;;

    *)
        if [[ $1 ]];then 
            echo "the device number you input is not supported! check and try again"
        else
            echo " you input device number with null,
            we will flash directly using img or the default img of which you set (in present directory) "
            ./getimg.sh 4l
            cd $path_to_save_img
            fastboot_flash 
        fi
        ;;

    esac


