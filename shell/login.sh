#!/bin/bash

passwd=123123
function loginMessage()
{
    echo "##### input lo+name to enter your destination #### 
    like: 
    loj ===> jsl local pc
    loq ===> qzk local pc
    jsl   ===> jsl remote pc
    serv  ===> service pc 120
    "
    echo "**************login oa :please enter your password.*************"
    echo "ssh $1@192.168.anonymous!!!"
}
function login()
{
    loginMessage

    echo " ooooooooooooooooooooooooooooooooooo:destination pc=====> $1 !!"

    if [ $1 = "loq" ];then

        sshpass -p kylin ssh kylin@192.168.78.223
        echo "ssh kylin@192.168.78.223"

    elif [ $1 = "loj" ];then
        sshpass -p $passwd ssh kylin@192.168.70.226 

    elif [ $1 = "serv" ];then
        sshpass -p $passwd ssh kylin@192.168.70.120 



    elif [ $1 = "we-are-anonymous" ];then
        ssh $1@192.168.78.219

    else
        sshpass -p $passwd ssh $1@192.168.78.219
        #ssh $1@192.168.78.219 |echo "123123"
        echo "ssh $1@192.168.78.219"
    fi

}

login $1
