#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: $0 [option]"
    echo ""
    echo "Options:"
    echo "  -h,  --help         Display this help message"
    echo "  -sd, --show-date    Display the current date"
    echo "  -g,  --greet        Display a greeting message"
    echo "  -lf, --list-files   List files in the current directory"
    echo "  -du, --disk-usage   Show disk usage"
    echo ""
}

# Function to display the current date
show_date() {
    echo "Current date: $(date)"
}

# Function to display a greeting message
greet() {
    echo "Hello, welcome to the script!"
}

# Function to list files in the current directory
list_files() {
    echo "Listing files in the current directory:"
    ls
}

# Function to show disk usage
disk_usage() {
    echo "Disk usage:"
    df -h
}

# Check if no arguments were provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Use --help or -h for usage information."
    exit 1
fi

# Process command-line arguments
case $1 in
    -h|--help)
        show_help
        ;;
    -sd|--show-date)
        show_date
        ;;
    -g|--greet)
        greet
        ;;
    -lf|--list-files)
        list_files
        ;;
    -du|--disk-usage)
        disk_usage
        ;;
    *)
        echo "Error: Unknown option '$1'. Use --help or -h for usage information."
        exit 1
        ;;
esac
