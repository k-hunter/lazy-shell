#/****************************************************
#Copyright (C) 2018 Fkscty Ltd. All rights reserved.

#      Filename: pcscope-ctags-db-gen.sh
#
#        Author: $AUTHOR
#   Description: ---
#        Create: Thu 23 Aug 2018 07:51:53 PM CST
# Last Modified: Fri 24 Aug 2018 09:23:08 AM CST
#****************************************************/

#!/bin/bash

separator_line="----------------------------------------\n"

cscope_database_gen()
{
    echo "this is my secend shell of gen cscope database"    
    echo "back up daily is a good habit"
    find . -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" > cscope.files
    cscope -bkq -i cscope.files
}

ctags_tags_gen()
{
    echo -e "generating tags,please wait...\n$separator_line"
    #ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -R -f ~/.vim/systags /usr/include /usr/local/include
    #ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -R -f .  . 

    ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -R -f

    #ctags -R 
    #ctags --languages=Asm,c,c++,java -R
    #ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S  -R -f ./ ./
}


database_gen()
{
    start_time=`date +%s`              #定义脚本运行的开始时间
    [ -e /tmp/fd1 ] || mkfifo /tmp/fd1 #创建有名管道
    exec 3<>/tmp/fd1                   #创建文件描述符，以可读（<）可写（>）的方式关联管道文件，这时候文件描述符3就有了有名管道文件的所有特性
    rm -rf /tmp/fd1                    #关联后的文件描述符拥有管道文件的所有特性,所以这时候管道文件可以删除，我们留下文件描述符来用就可以了
    for ((i=1;i<=4;i++))
    do
        echo >&3                   #&3代表引用文件描述符3，这条命令代表往管道里面放入了一个"令牌"
    done

    read -u3                           #代表从管道中读取一个令牌
    {
        {
            echo -e $separator_line 
            echo "generating cscope_database,please waiting ..."
            cscope_database_gen > /dev/null  
        }&
        #{
            #echo -e $separator_line 
            #echo "generating ctags_tags,please waiting ..."
            ##ctags_tags_gen 
            #ctags_tags_gen > /dev/null 
        #}&
        echo >&3                   
    }&
   
    
    read -u3                           
    {
        {
            echo -e $separator_line 
            echo "generating ctags_tags,please waiting ..."
            ctags_tags_gen > /dev/null 
        }&
        echo >&3                   #代表我这一次命令执行到最后，把令牌放回管道
    }&
    #done
    wait
    echo -e "all target  finished!"
    stop_time=`date +%s`  #定义脚本运行的结束时间

    echo "all database_gen take TIME:`expr $stop_time - $start_time`"
    echo -e $separator_line 
    exec 3<&-                       #关闭文件描述符的读
    exec 3>&-                       #关闭文件描述符的写
    echo "damn_it_stop_now" > stop_processbar_flag.txt
}


show_process_bar()
{
    touch stop_processbar_flag.txt 
    stop_processbar_flag="damn_it_stop_now"
    while [[ "$stop_processbar_flag" != "$(cat stop_processbar_flag.txt)" ]];
    do 
        sleep 0.1
        echo -n "|"
    done
}


clean_show_result()
{
    echo "cleaning the following temp files:"
    echo -e $separator_line
    ls -lh cscope.files stop_processbar_flag.txt
    rm cscope.files stop_processbar_flag.txt 
    echo -e $separator_line

    echo "tags and cscope files :"

    echo -e $separator_line
    ls -lh cscope* tags 
    echo -e $separator_line

}

#main
main(){
    database_gen 
    show_process_bar
    clean_show_result 
}

main
