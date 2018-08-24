#!/bin/bash
#adb logcat |grep -i --color=auto  -E "$1|$2|$3" 
#adb logcat |grep -i -n --color=auto -E 'halo|nfc' 
#adb logcat |grep -i -n --color=auto -E "$1|$2" 
if [ $1 =  ];then 
    
    adb logcat
    #echo  "Error ! please input your variables after shell"
else
    adb logcat |grep -i -n --color=auto -E "$1" 
fi

#adb logcat |grep -i -n --color=auto -E 'halo|nfc' 
