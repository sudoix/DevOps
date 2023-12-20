#!/bin/bash

##########################################################################################
# Script Name: echo.sh
# Description: This script demonstrates a simple echo in Linux using Bash scripting.
# Author: Milad Norouzi
# Date: January 1, 2022
# Version: 1.0
##########################################################################################


# until syntax

until condition
do
  # Loop body
done


#!/bin/bash

counter=0
until [ $counter -ge 5 ]
do
    echo "Counter: $counter"
    ((counter++))
done

#!/bin/bash

file_path="/path/to/your/file"
until [ -f $file_path ]
do
  echo "Waiting for the file to be created..."
  sleep 1
done
echo "The file exists. Proceeding..."

#!/bin/bash
until ping -c1 www.google.com &>/dev/null
do
echo "Waiting for www.google.com - network down?"
sleep 5
done
echo "Ping successful! www.google.com is reachable."

# The script generates random numbers between 1 and 10 until it generates a number greater than 8.

#!/bin/bash
until (( num > 8 ))
do
    # Generate a random number between 1 and 10
    num=$(( (RANDOM % 10) + 1 ))
    echo "Generated number: $num"
done
echo "Loop finished!"
