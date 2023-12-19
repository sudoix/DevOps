#!/bin/bash

##########################################################################################
# Script Name: echo.sh
# Description: This script demonstrates a simple echo in Linux using Bash scripting.
# Author: Milad Norouzi
# Date: January 1, 2022
# Version: 1.0
##########################################################################################

# Print hello world

echo hello world
echo hello world!
# Run in terminal
echo hello world!!
echo hello world!!!!!!! # :)

# For print !!!! in normal mode
echo hello world\!\!\!\!

echo -e "hello \nworld" # Use ""
echo -e "hello \tworld" # Use ""
echo -e "hello \nworld" # Run in sh
echo -e hello \nworld

# Redirect and append
echo -e "hello world" > file.txt
echo -e "hello world" >> file.txt

# Read file
cat file.txt





