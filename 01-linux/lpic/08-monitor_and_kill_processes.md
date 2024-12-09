![24](../../.gitbook/assets/24-shell.png)

# Monitor and kill processes

### tmux

tmux is a terminal multiplexer for Unix-like operating systems. It allows you to manage multiple terminal sessions within a single terminal window or terminal emulator. With tmux, you can create and switch between multiple terminal panes, split the terminal window into multiple sections, and detach and reattach terminal sessions, making it a powerful tool for multitasking and remote server management. 

tmux command to create a new tmux session:

```
tmux new-session -s mysession
```

You can detach from your tmux session by pressing Ctrl+B then D

`Ctrl+B`. After that, press `D` to detach from the current session.

```
Ctrl+B D — Detach from the current session.
Ctrl+B % — Split the window into two panes horizontally.
Ctrl+B " — Split the window into two panes vertically.
Ctrl+B o — Switch to next pane
Ctrl+B Arrow Key (Left, Right, Up, Down) — Move between panes.
Ctrl+B X — Close pane.
Ctrl+B C — Create a new window.
Ctrl+B N or P — Move to the next or previous window.
Ctrl+B 0 (1,2...) — Move to a specific window by number.
Ctrl+B : — Enter the command line to type commands. Tab completion is available.
Ctrl+B ? — View all keybindings. Press Q to exit.
Ctrl+B W — Open a panel to navigate across windows in multiple sessions.
```

### byobu

It is a terminal multiplexer which means that you can work on multiple screens in a single screen session. It works on most Linux, BSD, and Mac distributions.

You can start byobu session using it by running this command:

```
$ byobu
```
##### Byobu Cheat sheet

```
KEYBINDINGS
       byobu keybindings can be user defined in /usr/share/byobu/keybindings/ (or within .screenrc if byobu-export was used). The  common  key  bindings
       are:

       F2 - Create a new window

       F3 - Move to previous window

       F4 - Move to next window

       F5 - Reload profile

       F6 - Detach from this session

       F7 - Enter copy/scrollback mode

       F8 - Re-title a window

       F9 - Configuration Menu

       F12 -  Lock this terminal

       shift-F2 - Split the screen horizontally

       ctrl-F2 - Split the screen vertically

       shift-F3 - Shift the focus to the previous split region

       shift-F4 - Shift the focus to the next split region

       shift-F5 - Join all splits

       ctrl-F6 - Remove this split

       ctrl-F5 - Reconnect GPG and SSH sockets

       shift-F6 - Detach, but do not logout

       alt-pgup - Enter scrollback mode

       alt-pgdn - Enter scrollback mode

       Ctrl-a $ - show detailed status

       Ctrl-a R - Reload profile

       Ctrl-a ! - Toggle key bindings on and off

       Ctrl-a k - Kill the current window

       Ctrl-a ~ - Save the current window's scrollback buffer
       Ctrl+shift + f3 - Move to left tab
       Ctrl+shift + f4 - Move to right tab
```

### screen

 **screen** command in Linux provides the ability to launch and use multiple shell sessions from a single _ssh_ session. 

When a process is started with ‘screen’, the process can be detached from session and then can reattach the session at a later time. When the session is detached, the process that was originally started from the screen is still running and managed by the screen itself. The process can then re-attach the session at a later time, and the terminals are still there, the way it was left. (you might need to install it)

#### Start screen for the first time

simple use screen command ** :**

```
root@ubuntu16-1:~# screen
```

```
Screen version 4.03.01 (GNU) 28-Jun-15

Copyright (c) 2010 Juergen Weigert, Sadrul Habib Chowdhury
Copyright (c) 2008, 2009 Juergen Weigert, Michael Schroeder, Micah Cowan,
Sadrul Habib Chowdhury
Copyright (c) 1993-2002, 2003, 2005, 2006, 2007 Juergen Weigert, Michael
Schroeder
Copyright (c) 1987 Oliver Laumann

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 3, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program (see the file COPYING); if not, see http://www.gnu.org/licenses/,
or contact Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,

                  [Press Space for next page; Return to end.]
```

use` screen -s Session_Name` to start a named session.now lets run a command inside screen:

```
root@ubuntu16-1:~# sleep 1111

```

> Inorder to create a new screen inside the current screen (nested screen) use  just press **Ctrl-a** +**c**

#### Detach the screen

One of the advantages of screen that is you can detach it. Then, you can restore it without losing anything you have done on the screen. use  **Ctrl-a + d **to detach**:**

```
root@ubuntu16-1:~# sleep 1111

```

```
root@ubuntu16-1:~# screen
[detached from 56798.pts-4.ubuntu16-1]
root@ubuntu16-1:~# 
```

 **-d** is** also **used to detach a screen session so that it can be reattached in future.

**List screens**

 **screen  -ls** is used to display the currently opened screens including those running in the background:

```
root@ubuntu16-1:~# screen -list
There is a screen on:
	56798.pts-4.ubuntu16-1	(10/14/2019 04:15:00 AM)	(Detached)
1 Socket in /var/run/screen/S-root.
```

**Reattach to a screen**

 **-r ** It is used to reattach a screen session which was detached in past:

```
root@ubuntu16-1:~# screen -r 56798
```

```
root@ubuntu16-1:~# sleep 1111
root@ubuntu16-1:~# 

```

> We usually use `screen -dr <Screen-ID>` command.This means detach the specified screen first and then reattach it. 

#### Switching between screens

When we do nested screen, you can switch between screen using command **Ctrl-a +n**. It will be move to the next screen. When  need to go to the previous screen, just press **Ctrl-a** +**p**.

#### Terminate screen session

Use  “**Ctrl-A**” and “**K**” to kill the screen.



### Monitor active processes

#### What is process?

A program is a series of instructions that tell the computer what to do. When we run a program, those instructions are copied into memory and space is allocated for variables and other stuff required to manage its execution. This running instance of a program is called a process and it's processes which we manage

Each process got a **PID**. PID stands for  **process identifier** and it is is a unique number that identifies each of the running processes in an operating system

processes can further be categorized into:

* **Parent processes** – these are processes that create other processes during run-time.
* **Child processes** – these processes are created by other processes during run-time.

therefore **PPID** stands for **Parent Process ID**. notes:

* note1:Used up pid’s can be used in again for a newer process since all the possible combinations are used.
* note2:At any point of time, no two processes with the same pid exist in the system because it is the pid that Unix uses to track each process.

> If we use the `jobs` command with the `-l` option, it will also show process ID.  

### ps

ps (Process status) can be used to see/list all the running processes and their PIDs along with some other information depends on different options.

```
ps [options]
```

 ps reads the process information from the virtual files in **/proc** file-system.  In it's simplest form, when used without any option, `ps` will print four columns of information for minimum two processes running in the current shell, the shell itself, and the processes that run in the shell when the command was invoked.

```
root@ubuntu16-1:~# ps
   PID TTY          TIME CMD
 57301 pts/18   00:00:00 bash
 59076 pts/18   00:00:00 ps
```

 Where,\
 **PID –** the unique process ID\
 **TTY –** terminal type that the user is logged into\
 **TIME –** amount of CPU in minutes and seconds that the process has been running\
 **CMD –** name of the command that launched the process.

>  **Note –** Sometimes when we execute **ps** command, it shows TIME as 00:00:00. It is nothing but the total accumulated CPU utilization time for any process and 00:00:00 indicates no CPU time has been given by the kernel till now. In above example we found that, for bash no CPU time has been given. This is because bash is just a parent process for different processes which needs bash for their execution and bash itself is not utilizing any CPU time till now.

Usually when we use the command ps we add parameters like `-a`, `-u` and` -x`. While 

* `a` = show processes for all users
* `u` = display the process’s user/owner
* `x` = also show processes not attached to a terminal

```
root@ubuntu16-1:~# ps -aux | head -10
USER        PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root          1  0.0  0.3 185244  3856 ?        Ss   Oct11   0:07 /sbin/init auto noprompt
root          2  0.0  0.0      0     0 ?        S    Oct11   0:00 [kthreadd]
root          4  0.0  0.0      0     0 ?        I<   Oct11   0:00 [kworker/0:0H]
root          6  0.0  0.0      0     0 ?        I<   Oct11   0:00 [mm_percpu_wq]
root          7  0.0  0.0      0     0 ?        S    Oct11   0:12 [ksoftirqd/0]
root          8  0.0  0.0      0     0 ?        I    Oct11   0:19 [rcu_sched]
root          9  0.0  0.0      0     0 ?        I    Oct11   0:00 [rcu_bh]
root         10  0.0  0.0      0     0 ?        S    Oct11   0:00 [migration/0]
root         11  0.0  0.0      0     0 ?        S    Oct11   0:01 [watchdog/0]
```

where column are :

*   **USER –** Specifies the user who executed the program.

     **PID:** Process ID, shows the process identification number.

    **CPU%**: The processor % used by the process.

    **MEME%**: The memory % used by the process.

    **VSZ:** The virtual size in kbytes.

    **RSS:** In contrast with the  virtual size, this shows the real memory used by the process.

    **TTY:** Identifies the terminal from which the process was executed.

    **STATE:** Shows information on the process’ state just as it’s priority, by running “man ps” you can see codes meaning.

    **START:** Show when the process has started.

    **TIME:** Shows the processor’s time occupied by the program.

    **C0MMAND:** Shows the command used to launch the process.

> We can also use ps -ef instead of ps aux . There are no **differences** in the output because the meanings are the same. The **difference between ps** -**ef and ps aux** is due to historical divergences **between** POSIX and BSD systems. At the beginning, POSIX accepted the -**ef** while the BSD accepted only the **aux** form. Both list all processes of all users. In that aspect `-e` and `ax` are completely equivalent.

| Options for ps command | Description                                   |
| ---------------------- | --------------------------------------------- |
| ps -T                  | View Processes  associated with a terminal    |
| ps -x                  | View all processes owned by you               |
| ps -o  column_name     | view process according to user-defined format |

It is also possible to use --sort option to sort output based on different fields (+ for ascending & - for descending). `ps -eo  pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -10` . With`-o` or `–format` options, ps allows us to build user-defined output formats.

|  **Process selection commands**   | Description                             |
| --------------------------------- | --------------------------------------- |
| ps -C command_name                | Select the process by the command name. |
| ps p process_id                   | View process by process ID.             |
| ps -u user_name/ID                | Select by user name or ID               |
| ps -g group_name , ps -G group_id | Select by group name or ID              |
| ps -t pst/0                       | Display Processes by TTY                |

We already know about the grep command in Linux, which searches for a pattern, and then prints the matching text in the output. What if the requirement is to apply this kind of processing to fetch select information about processes currently running in the system?

### pgrep

the `pgrep` command searches for processes currently running on the system, **based on a complete** or** partial process name**, or other specified attributes.

```
pgrep [options] pattern
```

```
root@ubuntu16-1:~# sleep 1000 &
[1] 60647
root@ubuntu16-1:~# sleep 2000 &
[2] 60648
root@ubuntu16-1:~# pgrep sleep
60647
60648
```

> Always use ps -ef command to make sure about process_name. There is different between process_name and the running program(like bash). compare pgrep -a and pgrep -af.

pgrep options:

```
-d, --delimiter <string>  specify output delimiter
 -l, --list-name           list PID and process name
 -a, --list-full           list PID and full command line
 -v, --inverse             negates the matching
 -w, --lightweight         list all TID
 -c, --count               count of matching processes
 -f, --full                use full process name to match
 -g, --pgroup <PGID,...>   match listed process group IDs
 -G, --group <GID,...>     match real group IDs
 -n, --newest              select most recently started
 -o, --oldest              select least recently started
 -P, --parent <PPID,...>   match only child processes of the given parent
 -s, --session <SID,...>   match session IDs
 -t, --terminal <tty,...>  match by controlling terminal
 -u, --euid <ID,...>       match by effective IDs
 -U, --uid <ID,...>        match by real IDs
 -x, --exact               match exactly with the command name
 -F, --pidfile <file>      read PIDs from file
 -L, --logpidfile          fail if PID file is not locked
 --ns <PID>                match the processes that belong to the same
                           namespace as <pid>
 --nslist <ns,...>         list which namespaces will be considered for
                           the --ns option.
                           Available namespaces: ipc, mnt, net, pid, user, uts

 -h, --help     display this help and exit
 -V, --version  output version information and exit
```

> **Real Time process monitoring ?**
>
> Be creative and use combination of  other commands like 'watch'. We can use 'watch' in conjunction with ps  command to perform Real-time Process Monitoring :
>
> `watch -n 1 'ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'`

But there is another tool for that, top.

###  top

 **top** command is used to show the Linux processes. It provides a dynamic real-time view of the running system. Usually, this command shows the summary information of the system and the list of processes or threads which are currently managed by the Linux Kernel.

```
root@ubuntu16-1:~# top
```

```
Tasks: 237 total,   1 running, 174 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.8 us,  0.4 sy,  0.0 ni, 98.7 id,  0.1 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :   985080 total,   167700 free,   501856 used,   315524 buff/cache
KiB Swap:  1045500 total,   448216 free,   597284 used.   256968 avail Mem 

   PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND    
 59562 root      20   0   41952   3604   2920 R 12.5  0.4   0:00.02 top        
     1 root      20   0  185244   3856   2244 S  0.0  0.4   0:07.76 systemd    
     2 root      20   0       0      0      0 S  0.0  0.0   0:00.01 kthreadd   
     4 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 kworker/0:+
     6 root       0 -20       0      0      0 I  0.0  0.0   0:00.00 mm_percpu_+
     7 root      20   0       0      0      0 S  0.0  0.0   0:12.88 ksoftirqd/0
     8 root      20   0       0      0      0 I  0.0  0.0   0:19.92 rcu_sched  
     9 root      20   0       0      0      0 I  0.0  0.0   0:00.00 rcu_bh     
    10 root      rt   0       0      0      0 S  0.0  0.0   0:00.00 migration/0
```

Top output keep refreshing until you press ‘q‘.

Where,

* **PID:** Shows task’s unique process id
* **USER:** User name of owner of task.
* **PR:** Stands for priority of the task.
* **NI:** Represents a Nice Value of task. A Negative nice value implies higher priority, and positive Nice value means lower priority.
* **VIRT:** Total virtual memory used by the task.
* **RES:**It is the Resident size, the non-swapped physical memory a task has used.
* **SHR:** Represents the amount of shared memory used by a task.
* **%CPU:** Represents the CPU usage.
* **%MEM:** Shows the Memory usage of task.
* **TIME+:** CPU Time, the same as ‘TIME’, but reflecting more granularity through hundredths of a second.
* **COMMAND:**Shows the command used to launch the process.

| top command option    | description                                |
| --------------------- | ------------------------------------------ |
| top -n 10             | Exit Top Command After Specific repetition |
| top -u user1          |  Display Specific User Process             |
| Top -d seconds.tenths | It tells delay time between screen updates |
| top -h                |  Shows top command syntax                  |

| Running top command hot keys | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
|  pressing ‘d‘                | change screen refresh interval (default 3.0 sec)             |
| Pressing ‘z‘                 | display running process in color                             |
| Pressing ‘c‘                 | display absolute path of running program                     |
| pressing ‘k‘                 | kill a process after finding PID of process(without exiting) |
| Pressing 'M'                 | sort based on memory usage                                   |
| Shift+P                      |  Sort by CPU Utilisation                                     |
|  Press ‘h‘                   | Getting top command help                                     |

### Manage processes

To manage processes in a linux machine  we can send signals signals to the process.Many Signals are defined in the linux kernels. (try `man 7 signal`)

| Signal Name | Signal Number | Description                                                                                         |
| ----------- | ------------- | --------------------------------------------------------------------------------------------------- |
| SIGHUP      | 1             | Hang up detected on controlling terminal or death of controlling process                            |
| SIGINT      | 2             | Issued if the user sends an interrupt signal (Ctrl + C)                                             |
| SIGQUIT     | 3             | Issued if the user sends a quit signal (Ctrl + D)                                                   |
| SIGKILL     | 9             | If a process gets this signal it must quit immediately and will not perform any clean-up operations |
| SIGTERM     | 15            | Software termination signal (sent by kill by default)                                               |
| SIGCOUNT    | 18            | Continue the process stopped with STOP                                                              |
| STOP        | 19            | Stop process                                                                                        |

to send signals to processes there are some commands:

### kill

 `kill` command in Linux (located in /bin/kill), is a built-in command which is used to terminate processes manually . _kill_ command sends a signal to a process which terminates the process.

```
kill {-signal | -s signal} pid 
```

please notice that:

* A user can kill all his process.
* A user can not kill another user’s process.
* A user can not kill processes System is using.
* A root user can kill System-level-process and the process of any user.

note: If the user doesn’t specify any signal which is to be sent along with kill command then **default TERM signal** is sent that terminates the process.

```
root@ubuntu16-1:~# sleep 1000 &
[1] 61080
root@ubuntu16-1:~# sleep 2000 &
[2] 61081
root@ubuntu16-1:~# jobs -l
[1]- 61080 Running                 sleep 1000 &
[2]+ 61081 Running                 sleep 2000 &
root@ubuntu16-1:~# ps -ef | grep sleep
root      61080  57301  0 02:55 pts/18   00:00:00 sleep 1000
root      61081  57301  0 02:55 pts/18   00:00:00 sleep 2000
root      61085  57301  0 02:56 pts/18   00:00:00 grep --color=auto sleep
root@ubuntu16-1:~# kill 61080
root@ubuntu16-1:~# ps -ef | grep sleep
root      61081  57301  0 02:55 pts/18   00:00:00 sleep 2000
root      61089  57301  0 02:56 pts/18   00:00:00 grep --color=auto sleep
[1]-  Terminated              sleep 1000
root@ubuntu16-1:~# ps -ef | grep sleep
root      61081   1722  0 02:55 ?        00:00:00 sleep 2000
root      61096  55644  0 02:58 pts/17   00:00:00 grep --color=auto sleep
root@ubuntu16-1:~# kill -9 61081
root@ubuntu16-1:~# ps -ef | grep sleep
root      61100  55644  0 02:58 pts/17   00:00:00 grep --color=auto sleep
```

  use `kill -l` to see all signals you can send using kill.

{% hint style="danger" %}
There are two commands used to kill a process:

* kill – Kill a process by ID
* killall,pkill – Kill a process by name

killing a proccess by name could be realy dangerous, Before sending signal,  verify which process is matching the criteria using “pgrep -l”.
{% endhint %}

### killall

 `killall` is a tool for terminating running processes on your system **based on name**. _In contrast, `kill` terminates processes based on Process ID number (PID)_. Like `kill` , `killall` can also send specific system signals to processes.

```
kill {-signal | -s signal} process_name 
```

note1:the whole process_name should be defined ( ex : sleep not sle or slee).

note2: If no signal name is specified, SIGTERM is sent.

```
root@ubuntu16-1:~# sleep 1000 &
[1] 61836
root@ubuntu16-1:~# sleep 2000 &
[2] 61837
root@ubuntu16-1:~# ps -ef | grep sleep | grep -v grep
root      61836  55644  0 03:46 pts/17   00:00:00 sleep 1000
root      61837  55644  0 03:46 pts/17   00:00:00 sleep 2000
root@ubuntu16-1:~# pkill sleep
[1]-  Terminated              sleep 1000
[2]+  Terminated              sleep 2000
root@ubuntu16-1:~# ps -ef | grep sleep | grep -v grep
```

| killall command example    | Description                                                            |
| -------------------------- | ---------------------------------------------------------------------- |
| killall -l                 | all signals the killall command can send                               |
| killall -q process_name    | prevent killall from complaining if specified process doesn't exist    |
| killall -u \[user-name]    | kill all processes owned by a user                                     |
| killall -o 5h              | kill all processes that have now been running for more than _5_ hour   |
| killall -y 4h              | kill all precesses  that less than 4 hours old                         |
| killall -w \[process-name] |  causes `killall` to wait until the process terminates before exiting. |

### pkill

The PKill command allows you to kill a program simply **by specifying the name.**

```
pkill [options] pattern
```

note: We don't have to define whole process_name. So it could be really dangerous!

example:

```
root@ubuntu16-1:~# pgrep firefox
62256
root@ubuntu16-1:~# pkill firefox
```

| pkill command example     | Description                                      |
| ------------------------- | ------------------------------------------------ |
| pkill -c \[process_name]  | return a count of the number of processes killed |
| pkill -U \[real_user_ID]  | kill all the processes for a particular user     |
| pkill -G \[real_group_ID] | kill all the programs in a particular group      |

### free

 **`free`** command  displays the total amount of **free space** available along with the amount of **memory used** and **swap** memory in the system, and also the** buffers** used by the kernel.

```
free [options]
```

As free displays the details of the memory related to the system , its syntax doesn’t need any arguments to be passed but it has some options!

```
root@ubuntu16-1:~# free
              total        used        free      shared  buff/cache   available
Mem:         985080      432716      135464       16724      416900      339484
Swap:       1045500      671864      373636
```

free command with no options produces the columnar output as shown above where column:

1. **total **: displays the total installed memory _(MemTotal and SwapTotal i.e present in /proc/meminfo)._
2. **used :** displays the used memory.
3. **free :** displays the unused memory.
4. **shared :** displays the memory used by tmpfs_(Shmen i.epresent in /proc/meminfo and displays zero in case not available)._
5. **buffers :** displays the memory used by kernel buffers.
6. **cached :** displays the memory used by the page cache and slabs_(Cached and Slab available in /proc/meminfo)._
7. **buffers/cache :** displays the sum of buffers and cache.

 By default the display is in kilobytes, but you can override this using `-b` for bytes, `-k` for kilobytes, `-m` for megabytes, or `-g` for gigabytes.

```
root@ubuntu16-1:~# free -h
              total        used        free      shared  buff/cache   available
Mem:           961M        423M        128M         16M        410M        330M
Swap:          1.0G        655M        365M
```

 `-t`   displays an additional line containing the total of the total, used and free columns:

```
root@ubuntu16-1:~# free -t -h
              total        used        free      shared  buff/cache   available
Mem:           961M        424M        127M         16M        410M        329M
Swap:          1.0G        655M        365M
Total:         1.9G        1.1G        492M
```

Other free command options:

```
-h, --human         show human-readable output
     --si            use powers of 1000 not 1024
 -l, --lohi          show detailed low and high memory statistics
 -t, --total         show total for RAM + swap
 -s N, --seconds N   repeat printing every N seconds
 -c N, --count N     repeat printing N times, then exit
 -w, --wide          wide output

     --help     display this help and exit
 -V, --version  output version information and exit
```

### uptime

 The `uptime` command shows you a one-line display that includes the current time, how long the system has been running, how many users are currently logged on, and the **system load averages** for the past 1, 5, and 15 minutes.

```
uptime [-options]
```

```
root@ubuntu16-1:~# uptime 
 03:37:00 up 3 days, 19:07,  1 user,  load average: 0.00, 0.00, 0.00
```

Lets try` uptime -h` to see all of `uptime` availbale options:

```
Usage:
 uptime [options]

Options:
 -p, --pretty   show uptime in pretty format
 -h, --help     display this help and exit
 -s, --since    system up since
 -V, --version  output version information and exit

For more details see uptime(1).
```

examples:

```
root@ubuntu16-1:~# uptime -p
up 3 days, 19 hours, 16 minutes
root@ubuntu16-1:~# uptime -s
2019-10-17 08:29:08
root@ubuntu16-1:~# uptime -V
uptime from procps-ng 3.3.10
```

.

.

.

{% hint style="info" %}
Processes deep dive ( Beyond the scope of LPIC1)

 **Types of Processes**

1. **Parent and Child process :** The 2nd and 3rd column of the ps –f command shows process id and parent’s process id number. For each user process there’s a parent process in the system, with most of the commands having shell as their parent.
2. **Zombie and Orphan process :** After completing its execution a child process is terminated or killed and SIGCHLD updates the parent process about the termination and thus can continue the task assigned to it. But at times when the parent process is killed before the termination of the child process, the child processes becomes orphan processes, with the parent of all processes “init” process, becomes their new ppid.\
    A process which is killed but still shows its entry in the process status or the process table is called a zombie process, they are dead and are not used.
3. **Daemon process :** They are system-related background processes that often run with the permissions of root and services requests from other processes, they most of the time run in the background and wait for processes it can work along with for ex print daemon.\
    When ps –ef is executed, the process with ? in the tty field are daemon processes

**States of a Process in Linux**

* **Running** – here it’s either running (it is the current process in the system) or it’s ready to run (it’s waiting to be assigned to one of the CPUs). use ps -r command.
* **Waiting** – in this state, a process is waiting for an event to occur or for a system resource. Additionally, the kernel also differentiates between two types of waiting processes; interruptible waiting processes – can be interrupted by signals and uninterruptible waiting processes – are waiting directly on hardware conditions and cannot be interrupted by any event/signal.
* **Stopped** – in this state, a process has been stopped, usually by receiving a signal. For instance, a process that is being debugged.
* **Zombie** – here, a process is dead, it has been halted but it’s still has an entry in the process table.

**Processes state codes in ps aux or ps -ef  command:**

* `R` running or runnable (on run queue)
* `D` uninterruptible sleep (usually IO)
* `S` interruptible sleep (waiting for an event to complete)
* `Z` defunct/zombie, terminated but not reaped by its parent
* `T` stopped, either by a job control signal or because it is being traced

Some extra modifiers:

* `<` high-priority (not nice to other users)
* `N` low-priority (nice to other users)
* `L` has pages locked into memory (for real-time and custom IO)
* `s` is a session leader
* `l` is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
* `+` is in the foreground process group
{% endhint %}

install ```strees-ng```

```bash
apt install stress-ng
apt install sysstat
apt install iotop
apt install nload iftop iperf net-tools iptraf-ng -y 
```

```bash
vmstat - Report virtual memory statistics

```
```
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0 1162320  27124 535700    0    0    24    60   28   38  0  0 100  0  0
```

```bash
free - Display amount of free and used memory in the system

free -m
free -h

```
```
top - display Linux processes

1 for show cpu core

shift + < or > sort top based on different culoms
shift + p # sort based CPU usage
shift + m # sort based memory usage
press c   # shows absolute patch of process
press z   # will running process in color
press d + number # delay number. default 3 sec
press k + PID   # Kill the process by using PID
press r + PID   # to renice a process
press q     # exit

```
```
us:% CPU time spent in user space #####Linux has two Spaces from OS point of view, User space and Kernel space
sy:% CPU time spent in kernel space####
ni:% CPU time spent on low priority processes
id:% CPU time spent idle
wa:io wait cpu time (or) % CPU time spent in wait (on disk)#######  IO WAIT ######
hi: % CPU time spent servicing/handling hardware interrupts
si:% CPU time spent servicing/handling software interrupts
st:% CPU time in involuntary wait by virtual cpu while hypervisor is servicing another processor
```

```
stress-ng -c 1 # for overload on 1 core
stress-ng -m 10 # for overload on memory

```

###### Uptime

```bash
uptime
12:10:01 up 45 min,  2 users,  load average: 0.08, 0.07, 0.12
```
0.08 load average of last 1 minute
0.07 load average of last 5 minute
0.12 load average of last 15 minute

Load avarage based on cpu and io

For example if you use 1 cpu:

load avrage 0.5 means => half used :)

load avrage 1.0 means => fully used :|

load avrage 1.5 means => overused :(

##### Disk i/o

```bash
strees-ng --hdd 3
```
Use `iotop` for check i/o

You can use `iostat` for check i/o but it's not a real time. Also you can use `sar 1 10` (every 1 second and repet 10) 

```
sar 1 10


Linux 5.4.0-107-generic (ubuntu-srv) 	08/12/2022 	_x86_64_	(4 CPU)

12:31:41 PM     CPU     %user     %nice   %system   %iowait    %steal     %idle
12:31:42 PM     all      0.00      0.00      0.00      0.00      0.00    100.00
12:31:43 PM     all      0.00      0.00      0.00      0.00      0.00    100.00
12:31:44 PM     all      0.00      0.00      0.25      0.00      0.00     99.75
12:31:45 PM     all      0.00      0.00      0.00      0.00      0.00    100.00
12:31:46 PM     all      0.00      0.00      0.00      0.00      0.00    100.00
12:31:47 PM     all      0.00      0.00      0.00      0.00      0.00    100.00
12:31:48 PM     all      0.00      0.00     16.67     36.72      0.00     46.61
12:31:49 PM     all      0.00      0.00      3.38     75.32      0.00     21.30
12:31:50 PM     all      0.00      0.00      2.84     76.23      0.00     20.93
12:31:51 PM     all      0.00      0.00      5.48     68.41      0.00     26.11
Average:        all      0.00      0.00      2.79     25.09      0.00     72.12
```

### Network Monitoring

Install `iftop & nload & net-tools` 

Use `ifconfig` command to see TX and RX

```bash 
ifconfig 
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.137.128  netmask 255.255.255.0  broadcast 192.168.137.255
        inet6 fe80::20c:29ff:fefc:9072  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:fc:90:72  txqueuelen 1000  (Ethernet)
        RX packets 286858  bytes 398213903 (398.2 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 104170  bytes 7084606 (7.0 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

If you dont have `ifconfig` commadn you can use `netstat -ie` to see your interface status and information.

```bash
 netstat -ie 
Kernel Interface table
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.137.128  netmask 255.255.255.0  broadcast 192.168.137.255
        inet6 fe80::20c:29ff:fefc:9072  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:fc:90:72  txqueuelen 1000  (Ethernet)
        RX packets 286919  bytes 398219397 (398.2 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 104220  bytes 7090426 (7.0 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

Use `netstat -s` for details of send and recive packet per interface.

```bash
 netstat -s 
Ip:
    Forwarding: 2
    205098 total packets received
    7 with invalid addresses
    0 forwarded
    0 incoming packets discarded
    205091 incoming packets delivered
    104654 requests sent out
    20 outgoing packets dropped
    4 dropped because of missing route
Icmp:
    45 ICMP messages received
    0 input ICMP message failed
    ICMP input histogram:
        destination unreachable: 42
        echo requests: 1
        echo replies: 2
    47 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        destination unreachable: 42
        echo requests: 4
        echo replies: 1
IcmpMsg:
        InType0: 2
        InType3: 42
        InType8: 1
        OutType0: 1
        OutType3: 42
        OutType8: 4
Tcp:
    152 active connection openings
    2 passive connection openings
    0 failed connection attempts
    3 connection resets received
    2 connections established
    204082 segments received
    103923 segments sent out
    0 segments retransmitted
    0 bad segments received
    112 resets sent
Udp:
    731 packets received
    42 packets to unknown port received
    0 packet receive errors
    775 packets sent
    0 receive buffer errors
    0 send buffer errors
    IgnoredMulti: 189
UdpLite:
TcpExt:
    30 TCP sockets finished time wait in fast timer
    83 delayed acks sent
    194271 packet headers predicted
    1781 acknowledgments not containing data payload received
    2235 predicted acknowledgments
    TCPBacklogCoalesce: 3928
    2 connections reset due to early user close
    TCPRcvCoalesce: 82761
    TCPAutoCorking: 110
    TCPOrigDataSent: 5666
    TCPDelivered: 5719
IpExt:
    InBcastPkts: 189
    InOctets: 390976800
    OutOctets: 5106653
    InBcastOctets: 35622
    InNoECTPkts: 287468
```
Check number of packet with `ifconfig`, after than `ping 8.8.8.8` and recheck `ifconfig` output. You can see the value of ifconfig changed.

##### Live network monitoring

###### iftop

Use `iftop` to check live monitoring

###### nload
Use `nload` to check interface send and recive network traffic.

###### Speedtest

Firest of all install `iperf` on linux system.

For this test you should have tow linux system and install `iperf` on both of them.

Download `speedtest` on bellow link.

```bash
wget https://github.com/sivel/speedtest-cli/raw/master/speedtest.py
```

Edit script and replace `python3` on first line.

```bash 
chmod +x speedtest.py
./speedtest.py --simple

Ping: 138.215 ms
Download: 19.20 Mbit/s
Upload: 3.27 Mbit/s
```
To check list servers

```bash
./speedtest.py --list

37703) Abramad (Tehran, Iran) [6.53 km]
32500) PISHGAMAN (Tehran, Iran) [8.94 km]
37820) Sindad (Tehran, Iran) [8.94 km]
45095) GreenWeb (Pardis, Iran) [40.40 km]
37535) MTNIrancell (Mazandaran, Iran) [121.28 km]
 7667) ATINET (Hamedan, Iran) [275.73 km]
 9795) MTNIrancell (Isfahan, Iran) [340.98 km]
22243) MCI (Hamrahe Avval) (Tabriz, Iran) [519.78 km]
 9890) MTNIrancell (Tabriz, Iran) [519.78 km]
 9888) Maxnet (Tabriz, Iran) [519.78 km]
```
Every server has an uniq id and you can use id for test with specific server.

```bash 
./speedtest.py --server 37703
```
Use `--share` option for generate link to see graphical modeles

###### iperf

`iperf` is a clinet server tools for checking speed test between tow linux system.

On server side run 

```bash
iperf -s
```

On client side run:

```bash
iperf -c SERVER_IP
```
```bash
iperf -c 192.168.137.128
------------------------------------------------------------
Client connecting to 192.168.137.128, TCP port 5001
TCP window size: 2.50 MByte (default)
------------------------------------------------------------
[  3] local 192.168.137.128 port 48418 connected with 192.168.137.128 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  31.7 GBytes  27.3 Gbits/sec
```
###### iptraf

install `iptraf-ng`

```bash
iptraf-ng
iptraf-ng -i ens33
```
### Monitoring tools

prtg
cacti
zabbix
netdata
collectd




source:


https://www.tecmint.com/install-collectd-and-collectd-web-to-monitor-server-resources-in-linux/

https://zoomadmin.com/HowToInstall/UbuntuPackage/libcgi-pm-perl

https://www.linux.com/training-tutorials/installation-guide-collectd-and-collectd-web-monitor-server-resources-linux/

https://www.linuxsysadmins.com/install-collectd-monitoring-on-linux/

https://www.redhat.com/sysadmin/introduction-tmux-linux
[https://www.thegeekdiary.com/understanding-the-job-control-commands-in-linux-bg-fg-and-ctrlz/](https://www.thegeekdiary.com/understanding-the-job-control-commands-in-linux-bg-fg-and-ctrlz/)

[https://superuser.com/questions/662431/what-exactly-determines-if-a-backgrounded-job-is-killed-when-the-shell-is-exited](https://superuser.com/questions/662431/what-exactly-determines-if-a-backgrounded-job-is-killed-when-the-shell-is-exited)

[https://linuxhint.com/nohup_command_linux/](https://linuxhint.com/nohup_command_linux/)

[https://www.tecmint.com/run-linux-command-process-in-background-detach-process/](https://www.tecmint.com/run-linux-command-process-in-background-detach-process/)

[https://www.geeksforgeeks.org/screen-command-in-linux-with-examples/](https://www.geeksforgeeks.org/screen-command-in-linux-with-examples/)

[https://www.tecmint.com/screen-command-examples-to-manage-linux-terminals/](https://www.tecmint.com/screen-command-examples-to-manage-linux-terminals/)

[https://linoxide.com/linux-command/15-examples-screen-command-linux-terminal/](https://linoxide.com/linux-command/15-examples-screen-command-linux-terminal/)

[https://ryanstutorials.net/linuxtutorial/processes.php](https://ryanstutorials.net/linuxtutorial/processes.php)

[https://www.cyberciti.biz/faq/unix-linux-disown-command-examples-usage-syntax/](https://www.cyberciti.biz/faq/unix-linux-disown-command-examples-usage-syntax/)

[https://linuxize.com/post/ps-command-in-linux/](https://linuxize.com/post/ps-command-in-linux/)

[https://www.computerhope.com/jargon/p/pid.htm](https://www.computerhope.com/jargon/p/pid.htm)

[https://www.tecmint.com/linux-process-management/](https://www.tecmint.com/linux-process-management/)

[https://www.geeksforgeeks.org/processes-in-linuxunix/](https://www.geeksforgeeks.org/processes-in-linuxunix/)

[https://www.geeksforgeeks.org/ps-command-in-linux-with-examples/](https://www.geeksforgeeks.org/ps-command-in-linux-with-examples/)

****[https://linuxhint.com/ps_command_linux-2/](https://linuxhint.com/ps_command_linux-2/)

[https://www.quora.com/What-is-the-difference-between-ps-elf-and-ps-aux-in-Linux](https://www.quora.com/What-is-the-difference-between-ps-elf-and-ps-aux-in-Linux)

[https://www.geeksforgeeks.org/top-command-in-linux-with-examples/](https://www.geeksforgeeks.org/top-command-in-linux-with-examples/)

[https://www.tecmint.com/12-top-command-examples-in-linux/](https://www.tecmint.com/12-top-command-examples-in-linux/)

[https://www.tutorialspoint.com/unix/unix-signals-traps.htm](https://www.tutorialspoint.com/unix/unix-signals-traps.htm)

[https://www.geeksforgeeks.org/kill-command-in-linux-with-examples/](https://www.geeksforgeeks.org/kill-command-in-linux-with-examples/)

[https://www.linux.com/tutorials/how-kill-process-command-line/](https://www.linux.com/tutorials/how-kill-process-command-line/)

[https://www.linode.com/docs/tools-reference/tools/use-killall-and-kill-to-stop-processes-on-linux/](https://www.linode.com/docs/tools-reference/tools/use-killall-and-kill-to-stop-processes-on-linux/)

[https://www.geeksforgeeks.org/free-command-linux-examples/](https://www.geeksforgeeks.org/free-command-linux-examples/)

[https://www.geeksforgeeks.org/linux-uptime-command-with-examples/](https://www.geeksforgeeks.org/linux-uptime-command-with-examples/)

[https://linuxhint.com/load_average_linux/](https://linuxhint.com/load_average_linux/)

.
