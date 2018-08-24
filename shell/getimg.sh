#!/bin/bash

android="/home/munger/project/android-6.0.0_r1/out/target/product/lte26007"
nexus4_remote="/home/pfx/pfx/nexus4/B2G/out/target/product/mako"
nexus7_remote="/home/pfx/pfx/nexus7/B2G-deb-5.1.0/out/target/product/deb"
n15s_remote=""

nexus4_local="/home/munger/project/nexus4/B2G/out/target/product/mako"
nexus7_local=""
n15s_local="/home/munger/project/android-6.0.0_r1/out/target/product/lte26007"

path_to_save_img="/home/munger/project/img"

#showImg
function showImg()
{
    echo "showImg now :######################################################  "
    ls -l *.img
}


#clean
function clean()
{
    rm *.img
    echo "clean the imgs finished.****************************************** "
}

#getImg
#function getImg()
#{
#showImg
#if [ $1 = 2.2 ];then
#clean
#cp /home/munger/project/ffos-v2.2-mako/out/target/product/mako/*.img ./
#rm ra*
#echo "cp /home/munger/project/ffos-v2.2-mako/out/target/product/mako/*.img ./"
#showImg
#echo "get img ######   nexus4 2.2 from local  ###### finished!"
#elif [ $1 = 2.5 ];then
#clean
#cp /home/munger/project/nexus4/B2G/out/target/product/mako/*.img ./
#rm ra*
#echo "cp /home/munger/project/nexus4/B2G/out/target/product/mako/*.img ./"
#showImg
#echo "get img ######   nexus4 2.5 from local  ###### finished!"
#elif [ $1 = "2.2remote" ];then
#clean
#scp pfx@192.168.78.219:/home/pfx/ffos-v2.2-mako/out/target/product/mako/*.img ./
#rm ra*
#echo "cp /home/pfx/ffos-v2.2-mako/out/target/product/mako/*.img ./"
#showImg
#echo "get img ######   nexus4 v2.2 from remote   ###### finished!"
#elif [ $1 = "2.5remote" ];then
#clean
#scp pfx@192.168.78.219:$nexus4_remote/*.img ./
#rm ra*
#echo "cp $nexus4_remote/*.img ./"
#showImg
#echo "get img ######   nexus4 v2.5 from remote   ###### finished!"
#elif [ $1 = 7 ];then
#clean
#scp pfx@192.168.78.219:/home/pfx/pfx/nexus7/B2G-deb-5.1.0/out/target/product/deb/*.img ./
#rm ra*
#echo "cp /home/pfx/pfx/nexus7/B2G-deb-5.1.0/out/target/product/deb/*.img ./"
#showImg
#echo "get img ######   nexus7 from remote   ###### finished!"
#elif [ $1 = 15 ];then
#clean
#cp $android/*.img ./
##rm ra*
#echo "cp $android/*.img ./"
#showImg
#echo "get img ######   15s from local   ###### finished!"

#else 

#echo -e "\033[41;33m  ###########  Error  ########### \033[0m "
#echo -e "please input \n 
#2.2 ===> for nexus4 v2.2\n 
#2.5 ===> for nexus4 v2.5 \n  
#7 ===> for nexus7 \n 
#after ./getimg.sh "
#fi
#echo "getImg done"
#}


function CpImg()
{
    local_host=""
    remote_host="pfx@192.168.78.219"
    clean
    case $device in 
        4r | 7r | 15r ) 
            case $device in
                4r)
                    device_path=$nexus4_remote 
                    ;;
                7r)
                    device_path=$nexus7_remote 
                    ;;
                15r)
                    device_path=$n15s_remote 
                    ;;
            esac
            echo "$device_path"
            echo "entering password ... and downloading ... please waitting >>>"
            #sshpass -p 123123  scp $remote_host:$device_path/*.img ~/project/img/ 
            sshpass -p 123123  scp $remote_host:$device_path/*.img $path_to_save_img 
            echo " ****** imgs download finished!"
            echo "scp $remote_host:$device_path/*.img $path_to_save_img"
            showImg
            ;;


        4l | 7l | 15l ) 
            case $device in
                4l)
                    device_path=$nexus4_local
                    ;;
                7l)
                    device_path=$nexus7_local
                    ;;
                15l)
                    device_path=$n15s_local
                    ;;
            esac
            #echo "$device_path" 
            cp  $local_host$device_path/*.img $path_to_save_img 
            echo "cp $local_host$device_path/*.img $path_to_save_img"
            ;;
    esac
}

function getimg()
{
    device=$1 
    showImg
    case $device in 
        4r|7r|15r|4l|7l|15l)
            CpImg $device  
            showImg
            rm ra*
            showImg 
            echo "get img ######  from remote or local  ###### finished!"
            ;;
        *)
            echo -e "\033[41;33m  ###########  Error  ########### \033[0m "
            echo -e "please input :\n 
            2.2 ===> for nexus4 v2.2\n 
            2.5 ===> for nexus4 v2.5 \n  
            4l ===> for nexus4_local  \n 
            7l ===> for nexus7_local  \n 
            15l ===> for n15s_local \n 
            4r ===> for nexus4_remote \n 
            7r ===> for nexus7_remote \n 
            15r ===> for n15s_remote  \n 
            ******* NOTE: 4l is not 41 ******* \n\n
            after ./getimg.sh "
            echo "
            *************getImg failed!!!**************"

            ;;
    esac
}


#getImg2.5
#else 
#echo -e "\033[41;33m  ###########  Error  ########### \033[0m "
## echo -e "\033[41;33m 红底黄字 \033[0m "
## echo -e "\033[31m 红色字 \033[0m"
#echo "please input "2.2" after ./getimg.sh to get imgs of ffos2.2,  or "2.5" to get imgs of ffos2.5 "
#fi


#main
cd $path_to_save_img
getimg $1
echo "##*****  if get img finished, please run | ./flash.sh | to flash img to your device...  ****##"
