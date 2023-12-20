#!/bin/bash

##########################################################################################
# Script Name: while.sh
# Description: This script demonstrates a simple while in Linux using Bash scripting.
# Author: Milad Norouzi
# Date: January 1, 2022
# Version: 1.0
##########################################################################################

# while syntax

while condition
do
  # code to be executed
done

while [ condition ]; do commands; done
while control-command; do COMMANDS; done

############################################################################################

count=1

while [ $count -le 5 ]
do
  echo "Count: $count"
  count=$((count+1))
done

#!/bin/bash

while IFS= read -r line
do
  echo "Line: $line"
done < file.txt

#!/bin/bash

while true
do
  read -p "Enter a number (or 'q' to quit): " input
  if [ "$input" == "q" ]; then
    break
  fi
  echo "You entered: $input"
done

#!/bin/bash

array=("apple" "banana" "cherry" "date")

index=0
while [ $index -lt ${#array[@]} ]
do
  echo "${array[$index]}"
  index=$((index+1))
done

## Example of a while loop that checks if a file exists

#!/bin/bash

file="example.txt"

while [ ! -f "$file" ]
do
  sleep 1
done
echo "File found!"

## Example of a while loop that performs a task until a condition is true:

#!/bin/bash

while [ $(date +%H:%M) != "08:00" ]
do
  echo "Waiting for 8:00 AM"
  sleep 60
done
echo "It's 8:00 AM!"

## Example of a while loop that reads user input and validates it:

#!/bin/bash

while true
do
  read -p "Enter a positive number: " number
  if [[ $number =~ ^[1-9][0-9]*$ ]]; then
    break
  else
    echo "Invalid input! Please enter a positive number."
  fi
done
echo "You entered: $number"

