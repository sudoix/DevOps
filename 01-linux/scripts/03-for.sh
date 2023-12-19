#!/bin/bash

##########################################################################################
# Script Name: loop.sh
# Description: This script demonstrates a simple loop in Linux using Bash scripting.
# Author: Milad Norouzi
# Date: January 1, 2022
# Version: 1.0
##########################################################################################

# syntax for loop

# for variable in list
# do
#   # Code to execute for each value in the list
# done

# Loop to print numbers from 1 to 5
for ((i=1; i<=5; i++))
do
  echo $i
done

# Loop to print even numbers from 2 to 10
for ((i=2; i<=10; i+=2))
do
  echo $i
done

# infinite for loop

for (( ; ; ))
do
  # Code to execute indefinitely
done

# count line in /etc/passwd file

for file in /etc/*
do
  # check if file exists in bash using the if #
	if [ "${file}" == "/etc/passwd" ]
	then
		countLine=$(grep -c nameserver /etc/passwd)
		echo "Total line ${countLine} is defined in ${file}"
		break
	fi
done

# ssh to server and run command

for s in server1 server2 server3
do
    ssh milad@${s} "uptime"
done


for s in server0{1..8}
do
    echo "*** Patching and updating ${s} ***"
    ssh milad@${s} "sudo ip -br -c a"
done

# Iterate over the IP addresses using a for loop
for server in "192.168.0.1" "192.168.0.2" "192.168.0.3"
do
    # SSH into the server and run the desired command
    ssh user@$server "sudo ip -br -c a"
done

# Define the server IP addresses in an array
servers=("192.168.0.1" "192.168.0.2" "192.168.0.3")

# Iterate over the array using a for loop
for server in "${servers[@]}"
do
    # SSH into the server and run the desired command
    ssh user@$server "sudo ip -br -c a"
done

###################

# Define the starting and ending IP addresses
start_ip="192.168.0.1"
end_ip="192.168.0.3"

# Extract the prefix of the IP addresses
ip_prefix=$(echo "$start_ip" | cut -d '.' -f 1-3)
echo "IP prefix: $ip_prefix"
# Iterate over the range of IP addresses using a for loop
for ((i=1; i<=3; i++))
do
    # Construct the IP address for each iteration
    current_ip="$ip_prefix.$i"
    echo "Current IP: $current_ip"
    # SSH into the server and run the desired command
    ssh milad@$current_ip "sudo ip -br -c a"
done

# Define the file path
file_path="path/to/ip_addresses.txt"

# Iterate over the IP addresses using a for loop
for ip_address in $(cat "$file_path")
do
    # SSH into the server and run the desired command
    ssh user@$ip_address "sudo ip -br -c a"
done

