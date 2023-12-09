![24](../../assets/24-shell.png)

# Work on the command line

**What is The "bash"?**

On most Linux systems a program called **bash acts as the shell** program. bash stands for **Bourne Again SHell**, an enhanced version of the original Unix shell program, sh, written by Steve Bourne

Besides, There are other shell programs that can be installed in a Linux system. These include: ksh, tcsh and zsh.

**Standard Input, Standard Output and Standard Error**

In general, a command (a program):

* Gets data to process from standard input or **stdin **(default: keyboard).
* Returns processed data to standard output or **stdout **(default: screen).
* If program execution causes errors, error messages are sent to standard error or **stderr **(default: screen).

### echo

The syntax for echo is: `echo [option(s)] [string(s)]`


```
[root@centos7-1 ~]# echo lpic1
lpic1
```

```
[root@centos7-1 ~]# echo -n lpic1
lpic1[root@centos7-1 ~]#
```
#### Special Characters or Meta Characters

What makes a character special? If it has a meaning beyond its literal meaning, a meta-meaning, then we refer to it as a special character or metacharacters  like : **``| & ; ( ) < > [ ] { } * ! ? ` ' " $ \ / # ``**

**pound sign (#)**

Everything written after a pound sign (#) is ignored by the shell.

```
[root@centos7-1 temp]# ls # ls /etc
```


**end of line backslash \\**

Lines ending in a backslash are continued on the next line.

**escaping special characters  **

The backslash  character enables the use of control characters, but without the shell interpreting it, this is called **escaping characters**.

```
[root@centos7-1 ~]# echo hello | by
bash: by: command not found...
[root@centos7-1 ~]# echo hello \| by
hello | by
[root@centos7-1 ~]# echo hello ; by
hello
bash: by: command not found...
[root@centos7-1 ~]# echo hello \; by
hello ; by
```
Use the`-e`option to enable certain backslash **escaped characters** to have special meaning.

Escape sequence	Function                                               

\a		Alert (bell)                                          
\b		Backspace                                             
\c		Suppress trailing newline (same function as -n option) 
\f		Form feed (clear the screen on a video display)        
\n		New line                                               
\r		Carriage return                                        
\t		Horizontal tab                                         
\v		vertical tab                                           

Some examples:

```
[root@centos7-1 ~]# echo -e "Lets \vstart \vlearning \vLinux"
Lets 
     start 
           learning 
                    Linux
[root@centos7-1 ~]# echo -e "Lets \tstart \tlearning \tLinux"
Lets     start     learning     Linux
```

**Semi-Colon** (**;**) : The succeeding commands will execute regardless of the exit status of the command that precedes it.

```
[root@centos7-1 ~]# ls /root/ ; ls /home/
```
**Logical AND** (**&&**) : This command that follows this operator will execute only if the preceding command executes successfully.

```
[root@centos7-1 ~]# true && ls /home/
```
**Logical OR** (**||**) : The command that follows will execute only if the preceding command fails.

```
[root@centos7-1 ~]# false || ls /home/
```

### env

By default, "env" command lists all the current environment variables.

```
[root@centos7-1 ~]# env
XDG_VTNR=1
XDG_SESSION_ID=1
HOSTNAME=centos7-1
SHELL=/bin/bash
.
.
.
```
**PWD**: The current working directory.

> We use pwd command to see that:
>
> ```
> [root@centos7-1 ~]# pwd
> /root
> [root@centos7-1 ~]# cd /etc/
> [root@centos7-1 etc]# pwd
> /etc
> ```

**Child vs Parent process**
Any process created will normally have a parent process from which it was created and will be considered as a child of this parent process.\
`echo $$` print a PID for a current shell

```
[root@centos7-1 ~]# echo $$
24370
[root@centos7-1 ~]# bash
[root@centos7-1 ~]# echo $$
24652
[root@centos7-1 ~]# exit
exit
[root@centos7-1 ~]# echo $$
24370
```

### export

export command is one of the bash shell builtin commands, marks an environment variable to be exported to child-processes, so that the child inherits them.

```
[root@centos7-1 ~]# VAR2="Linux is Fun"
[root@centos7-1 ~]# echo $VAR2
Linux is Fun
[root@centos7-1 ~]# export VAR2
[root@centos7-1 ~]# echo $$
24328
[root@centos7-1 ~]# bash
[root@centos7-1 ~]# echo $$
24722
[root@centos7-1 ~]# echo $VAR2
Linux is Fun
```
### unset

unset command is used to unset any local environment variable temporarily:

```
[root@centos7-1 ~]# VAR5="Linux Linux Linux"
[root@centos7-1 ~]# echo $VAR5
Linux Linux Linux
[root@centos7-1 ~]# unset VAR5
[root@centos7-1 ~]# echo $VAR5
bash: VAR5: unbound variable
[root@centos7-1 ~]# unset PATH
[root@centos7-1 ~]# ls
bash: ls: No such file or directory
```
### history

history shows the current content of Bash's history list in memory for the current session.

**Repeat previous command quickly(3 methods)**

1. Use the **up arrow** to view the previous command and press enter to execute it.
2. **Type !! and press enter **from the command line.(or** !!number** )
3. **Press Control+P** will display the previous command, press enter to execute it

**Search the history(3 methods)**

1. **Control+R: **Press Control+R and type the keyword.
2. **!string** Refers to the most recent command starting with string.
3. **!?string?** Refers to the most recent command containing string (the ending ? is optional).

**Clear all the previous history : **Use history -c option.

### **\~/.bash_history**

When user closes shell , Bash will save its history list to the disk by appending the contained entries to his/her **\~/.bash_history** hidden file.

### uname

uname command without any switch will print system information :

```
[root@centos7-1 ~]# uname
Linux
```
If -a (--all) is specified, the information is printed in the following order of individual options:

```
-s, --kernel-name    Print the kernel name.
-n, --nodename    Print the network node hostname.
-r, --kernel-release    Print the kernel release.
-v, --kernel-version    Print the kernel version.
-m, --machine    Print the machine hardware name.
-p, --processor    Print the processor type, or "unknown".
-i, --hardware-platform    Print the hardware platform, or "unknown".
-o, --operating-system    Print the operating system.
--help    Display a help message, and exit.
--version    Display version information, and exit.
```

### man

In Unix-like operating systems, a man page (in full manual page) is a documentation for a terminal-based program/tool/utility (commonly known as a command). It contains:

* ** the name of the command**
* **syntax for using it**
* **a description**
* **options available**
* **author**
* **copyright**
* **related commands and ... .**

To read a manual page for a Unix command, a user can type:

```
man <command_name>
```
**Most useful man command options:**

`-f, --whatis`Display a short description from the manual page

```
[root@centos7-1 ~]# man -f ls
ls (1)               - list directory contents
ls (1p)              - list directory contents
```

`-w, --where, --location` Don't actually display the manual pages, but do print of the source off files

```
[root@centos7-1 ~]# man -w ls
/usr/share/man/man1/ls.1.gz
```

`-k, --apropos` Equivalent to apropos. Search the short manual page descriptions for keywords and display any matches.

```
[root@centos7-1 ~]# man -k echo
echo (1)             - display a line of text
echo (1p)            - write arguments to standard output
fcping (8)           - Fibre Channel Ping (ELS ECHO) tool
l2ping (1)           - Send L2CAP echo request and receive answer
lessecho (1)         - expand metacharacters
pam_echo (8)         - PAM module for printing text messages
ping (8)             - send ICMP ECHO_REQUEST to network hosts
ping6 (8)            - send ICMP ECHO_REQUEST to network hosts
```
### apropos

apropos command is used to search and display a short man page description of a command/program as follows.

```
[root@centos7-1 ~]# apropos echo
```
sources:

[http://linuxcommand.org/lc3\_lts0010.php](http://linuxcommand.org/lc3\_lts0010.php)

[https://stackoverflow.com/questions/6697753/difference-between-single-and-double-quotes-in-bash](https://stackoverflow.com/questions/6697753/difference-between-single-and-double-quotes-in-bash)

[https://www.w3resource.com/linux-system-administration/control-operators.php](https://www.w3resource.com/linux-system-administration/control-operators.php)

[https://www.tecmint.com/set-unset-environment-variables-in-linux/](https://www.tecmint.com/set-unset-environment-variables-in-linux/)

[https://unix.stackexchange.com/questions/291729/why-is-the-default-symbol-for-a-user-shell-and-the-default-symbol-for-a-root](https://unix.stackexchange.com/questions/291729/why-is-the-default-symbol-for-a-user-shell-and-the-default-symbol-for-a-root)

[http://labor-liber.org/en/gnu-linux/introduction/index.php?diapo=input_output](http://labor-liber.org/en/gnu-linux/introduction/index.php?diapo=input_output)

[http://www.lostsaloon.com/technology/how-to-chain-commands-in-linux-command-line-with-examples/](http://www.lostsaloon.com/technology/how-to-chain-commands-in-linux-command-line-with-examples/)

[https://www.tecmint.com/chaining-operators-in-linux-with-practical-examples/](https://www.tecmint.com/chaining-operators-in-linux-with-practical-examples/)

[https://www.tecmint.com/echo-command-in-linux/](https://www.tecmint.com/echo-command-in-linux/)

[https://developer.ibm.com/tutorials/l-lpic1-103-1/](https://legacy.gitbook.com/book/borosan/lpic1-exam-guide/edit#)

[https://ss64.com/bash/syntax-quoting.html](https://ss64.com/bash/syntax-quoting.html)

[https://linuxconfig.org/learning-linux-commands-export](https://linuxconfig.org/learning-linux-commands-export)

[https://www.digitalocean.com/community/tutorials/how-to-read-and-set-environmental-and-shell-variables-on-a-linux-vps](https://www.digitalocean.com/community/tutorials/how-to-read-and-set-environmental-and-shell-variables-on-a-linux-vps)

[http://www.symkat.com/understanding-bash-history](http://www.symkat.com/understanding-bash-history)

[https://www.tecmint.com/history-command-examples/](https://www.tecmint.com/history-command-examples/)

[https://www.thegeekstuff.com/2008/08/15-examples-to-master-linux-command-line-history](https://www.thegeekstuff.com/2008/08/15-examples-to-master-linux-command-line-history)

[https://www.computerhope.com/unix/uuname.htm](https://www.computerhope.com/unix/uuname.htm)

[https://en.wikipedia.org/wiki/Man_page](https://en.wikipedia.org/wiki/Man_page)

[https://www.tecmint.com/view-colored-man-pages-in-linux/](https://www.tecmint.com/view-colored-man-pages-in-linux/)

[https://www.techonthenet.com/linux/commands/man.php](https://www.techonthenet.com/linux/commands/man.php)

[http://man7.org/linux/man-pages/man8/mandb.8.html](http://man7.org/linux/man-pages/man8/mandb.8.html)

[https://bash.cyberciti.biz/guide/Shopt](https://bash.cyberciti.biz/guide/Shopt)

