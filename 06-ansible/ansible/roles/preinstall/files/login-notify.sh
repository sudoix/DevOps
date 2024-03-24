#!/bin/bash

# prepare any message you want
host_name="$(hostname -f)"
login_ip="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
login_date="$(date +"%e %b %Y, %a %r")"
login_name="$(whoami)"

# For new line I use $'\n' here
message="🔥🔥 New login 🔥🔥"$'\n'"$host_name"$'\n'"$login_name"$'\n'"$login_ip"$'\n'"$login_date"

#send it to telegram
telegram-send "$message"