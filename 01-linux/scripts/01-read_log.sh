#!/bin/bash

##########################################################################################
# Script Name: read.sh
# Description: This script demonstrates a simple echo in Linux using Bash scripting.
# Author: Milad Norouzi
# Date: January 1, 2022
# Version: 1.0
##########################################################################################

now() {
        date "+%Y-%m-%dT%H:%M:%S"
}

log() {
         echo -e "`now` $@ "
}

log "start echo command"

# variables

VAR1=10
echo $VAR1

VAR2=20
echo $VAR2

VAR3="hello world"
echo $VAR3


# read


echo "enter your name: "
read name
echo "your name is $name"

read -p "enter your name: " name
echo "your name is $name"

read -s -p "enter your password: " password
echo "your password is $password"

###

# Prompt the user to enter the first number
echo "Enter the first number:"
read num1

# Prompt the user to enter the second number
echo "Enter the second number:"
read num2

# Calculate the sum
sum=$((num1 + num2))

# Display the result
echo "The sum of $num1 and $num2 is: $sum"

###

# Prompt the user to enter a directory name
echo "Enter the directory name:"
read dirname

# Create the directory
mkdir "$dirname"

# Prompt the user to enter a file name
echo "Enter the file name:"
read filename

# Create the file inside the directory
touch "$dirname/$filename"

echo "Directory '$dirname' and file '$filename' created successfully."



