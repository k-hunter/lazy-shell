#!/usr/bin/expect
#echo "let get a magic:>>>>>>>"
set timeout 10
set password "123123"
spawn sudo ls 
expect "password"
send "$password\n"
interact
#echo "password finished!\n"
