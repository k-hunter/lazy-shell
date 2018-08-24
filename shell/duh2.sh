#!/bin/bash
#the shell is to show the size of present directory

depth=$1

echo "input the depth you like :"
du -h --max-depth=$depth |sort -hr
