#!/bin/bash

# Function to validate IP address
validate_ip() {
    if [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$  ]]; then
        return 0
    else
        return 1
    fi
}

# Function to perform actions
perform_action() {
    read -p "Do you want to (p)ing, (t)raceroute, or (s)sh into the IP? " action

    case $action in
        p|P)
            ping -c 4 $1
            ;;
        t|T)
            traceroute $1
            ;;
        s|S)
            read -p "Enter the SSH username: " username
            read -s -p "Enter the SSH password: " password
            echo ""
            read -p "Enter the command to run on SSH: " ssh_command
            sshpass -p $password ssh $username@$1 $ssh_command
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Main script starts here
read -p "Enter the IP address: " ip

if validate_ip $ip; then
    perform_action $ip
else
    echo "Invalid IP address format."
    exit 1
fi
