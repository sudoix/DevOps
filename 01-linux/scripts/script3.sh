#!/bin/bash

# Scripte to get a car name and check the name and print some messages

read -p "Enter the car name: " CAR_NAME

# validate car name

CAR_NAME=`echo $CAR_NAME | tr [:upper:] [:lower:] | tr -d [:digit:] | tr -d [:punct:]`

if [ -z $CAR_NAME ]; then
    echo "Car name is empty, please enter a valid car name."
    exit 0
fi

if [ $CAR_NAME = "benz" ] || [ $CAR_NAME = "bmw" ]; then
    echo "Good choice!"
elif [ $CAR_NAME = "audi" ]; then
    echo "Not bad!"
else
    echo "Bad choice!"
fi
