#!/bin/bash

# 0 Successful completion
# 1 General errors
# 2 Misuse of shell builtins
# 126 Command invoked cannot execute
# 127 Command not found
# 128 Invalid argument to exit
# 128+x fatal signals
# 130 Script terminated by Control-C
# 255 Exit status out of range

# $? - exit status of last command
# $0 - name of the script
# $1 to 9 - arguments passed to the script
# $@ - all arguments passed to the script
# $# - number of arguments passed to the script
# $$ - process id of the script
# $! - process id of the last background process
# $RANDOM - random number
