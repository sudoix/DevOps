#!/bin/bash

##########################################################################################
# Script Name: case.sh
# Description: This script demonstrates a simple case in Linux using Bash scripting.
# Author: Milad Norouzi
# Date: January 1, 2022
# Version: 1.0
##########################################################################################

# case sysntax

case expression in
  pattern1)
    # code to execute if expression matches pattern1
    ;;
  pattern2)
    # code to execute if expression matches pattern2
    ;;
  pattern3)
    # code to execute if expression matches pattern3
    ;;
  *)
    # code to execute if expression matches none of the patterns
    ;;
esac

#####

fruit="apple"

case $fruit in
  "apple")
    echo "It's an apple"
    ;;
  "banana")
    echo "It's a banana"
    ;;
  *)
    echo "It's neither an apple nor a banana"
    ;;
esac

###

read -p "Enter your favorite color: " color

case $color in
  "red" | "blue")
    echo "Nice choice!"
    ;;
  "green" | "yellow")
    echo "That's a vibrant color!"
    ;;
  "black" | "white")
    echo "Classic!"
    ;;
  *)
    echo "I'm not familiar with that color."
    ;;
esac

## action on service

read -p "Enter the action (start/stop/restart/reload): " action

case $action in
  "start")
    sudo systemctl start <service_name>
    ;;
  "stop")
    sudo systemctl stop <service_name>
    ;;
  "restart")
    sudo systemctl restart <service_name>
    ;;
  "reload")
    sudo systemctl reload <service_name>
    ;;
  *)
    echo "Invalid action. Please enter start, stop, restart, or reload."
    ;;
esac

# handle different file types:

read -p "Enter the file name: " filename

case $filename in
  *.txt)
    echo "Text file detected."
    ;;
  *.png | *.jpg | *.jpeg)
    echo "Image file detected."
    ;;
  *.mp3 | *.wav)
    echo "Audio file detected."
    ;;
  *.mp4 | *.avi | *.mkv)
    echo "Video file detected."
    ;;
  *)
    echo "Unknown file type."
    ;;
esac

# find extention of file and seperate all the files by extension

for file in $(ls)
do
Extension=${file##*.}
case "$Extension" in
  sh) echo "Shell script: $file";;
  md) echo "A markdown file: $file";;
  png) echo "PNG image file: $file";;
  txt) echo "A text file: $file";;
  zip) echo "An archive: $file";;
  conf) echo "A configuration file: $file";;
  py) echo "A Python script: $file";;
  *) echo "Unknown file type: $file";;
esac
done