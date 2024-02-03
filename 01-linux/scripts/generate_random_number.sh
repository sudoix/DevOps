#!/bin/bash

# Generate a random number between 1 and 10
random_number=$((1 + $RANDOM % 10))

# Print the random number
echo $random_number

#To generate a random number between 3 and 10 in a bash script,
#you can adjust the calculation to start at 3 and add a random number up to 8
# (since 10 - 3 = 7, and we add 1 to include 10 in the range). Here's how you can do it:

# Generate a random number between 3 and 10
random_number=$((3 + $RANDOM % 8))

# Print the random number
echo "Generated number: $random_number"

# Check if the number is odd
if [ $((random_number % 2)) -ne 0 ]; then
    echo "The number is odd."
else
    echo "The number is even."
fi