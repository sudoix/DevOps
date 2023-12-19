#!/bin/bash

##########################################################################################
# Script Name: echo.sh
# Description: This script demonstrates a simple echo in Linux using Bash scripting.
# Author: Milad Norouzi
# Date: January 1, 2022
# Version: 1.0
##########################################################################################

# if [ condition ]; then
#     # Code to execute if the condition is true
# else
#     # Code to execute if the condition is false
# fi


# Define a variable
age=18

# Check if the age is greater than or equal to 18
if [ $age -ge 18 ]; then
    echo "You are an adult."
else
    echo "You are not an adult yet."
fi


# Define two variables
number1=5
number2=10

# Compare the values of the variables using an if statement
if [ $number1 -gt $number2 ]; then
    echo "Number 1 is greater than Number 2."
elif [ $number1 -lt $number2 ]; then
    echo "Number 1 is less than Number 2."
else
    echo "Number 1 is equal to Number 2."
fi

# bash and &&

if [ $age -ge 18 ] && [ "$citizen" == "yes" ]; then
  echo "You meet the criteria for voting."
fi

# bash or ||

if [ "$status" == "active" ] || [ "$role" == "admin" ]; then
  echo "Access granted."
fi

# not equal to

if [ "$name" != "John" ]; then
  echo "Name is not John."
fi

# check the directory exist

if [ -d "$directory" ]; then
  echo "Directory exists."
else
  echo "Directory does not exist."
fi

# check the file exist

if [ -f "$file" ]; then
  echo "File exists."
else
  echo "File does not exist."
fi

# Check if the variables are equal using the = operator

if [ "$variable1" = "$variable2" ]; then
  echo "Variables are equal."
else
  echo "Variables are not equal."
fi

# Check if the variables are not equal using the != operator

if [ "$variable1" != "$variable2" ]; then
  echo "Variables are not equal."
else
  echo "Variables are equal."
fi

# Check if the variable is not empty using the -n operator

if [ -n "$variable" ]; then
  echo "Variable is not empty."
else
  echo "Variable is empty."
fi

# Check if the variable is empty using the -z operator

if [ -z "$variable" ]; then
  echo "Variable is empty."
else
  echo "Variable is not empty."
fi

# elif

read -p "Enter a number: " num

if [ $num -gt 0 ]; then
    echo "Number is positive"
elif [ $num -lt 0 ]; then
    echo "Number is negative"
else
    echo "Number is zero"
fi

# check the file or directory

file_name=$1

if [ -f $file_name ]; then
    echo "File exists"
elif [ -d $file_name ]; then
    echo "Directory exists"
else
    echo "File or directory does not exist"
    echo -e "would you like to create a file? (y/n)"
    read answer
    if [ $answer == "y" ]; then
        touch $file_name
        echo "File created"
    elif [ $answer == "n" ]; then
        echo "File or directory does not exist"
    else
        echo "File or directory does not exist"
        exit 0
    fi
fi




