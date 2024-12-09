![24](../../.gitbook/assets/24-shell.png)

# Process text streams using filters

### streams

A stream is nothing more than a sequence of bytes that is passed from one file, device, or program to another.


These streams are:

* **standard input stream (stdin)**, which provides input to commands.
* **standard output stream (stdout)**, which displays output from commands.
* **standard error stream (stderr)**, which displays error output from commands.

The streams are also numbered: **stdin (0)** ,**stdout (1)**, **stderr (2)**.

### piping with |

Piping is a mechanism for sending data from one program to another.


```
command1 | command2 | command3 | command 4 | ...
```
```
[root@centos7-1 ~]# dmesg | less
```
### Redirection

Linux includes redirection commands for each stream.We can use `>` in order to redirect output stream (mostly to a file).

```
[root@centos7-1 temp]# ls -1 > list.txt
```
> "|" vs ">"
>
> The difference between > (redirection operator) and | (pipeline operator) is that while the >  connects a command with a file, the | connects the output of a command with another command.

### Text filtering

## cat

The **cat **(short for “**concatenate**“) command is one of the most frequently used command in Linux/Unix like operating systems

```
cat [OPTION] [FILE]...
```


```
[root@centos7-1 ~]# cat file1
This is 1st line of file1.

This is 3rd line of file1.
```

```
[root@centos7-1 ~]# cat file1 file2
```
create a new file with cat:

```
[root@centos7-1 ~]# cat > newfile2
This is my second new file with input redirection
Ctrl+d
[root@centos7-1 ~]# cat newfile2
This is my second new file with input redirection
```
> "-" A hyphen (used alone) generally signifies that input will be taken from stdin as opposed to a named file:
>
> ```
> [root@centos7-1 ~]# cat file1 - file2
> This is 1st line of file1.
>
> This is 3rd line of file1.
> THIS IS MY INPUT
> Ctrl+d
> This is 1st line of file2.
> This is 2nd line of file2.
>
> This is 4th line of file2.
> ```


```
  -A, --show-all           equivalent to -vET
  -b, --number-nonblank    number nonempty output lines, overrides -n
  -e                       equivalent to -vE
  -E, --show-ends          display $ at end of each line
  -n, --number             number all output lines
  -s, --squeeze-blank      suppress repeated empty output lines
  -t                       equivalent to -vT
  -T, --show-tabs          display TAB characters as ^I
  -u                       (ignored)
  -v, --show-nonprinting   use
```

Now what’s the opposite of cat? Yeah it’s ‘tac‘. `tac` is a command under Linux, try it for yourself.


## od

od (Octal dump) command in Linux is used to output the contents of a file in different formats with the octal format.

```
od [OPTION]... [FILE]...
```

as and example:

```
[root@centos7-1 ~]# cat testod.txt
1
2
3
4
5
[root@centos7-1 ~]# od testod.txt
0000000 005061 005062 005063 005064 005065
0000012
```

With `-t` option we can select output format and display it. (Traditional format specifications may be intermixed):

```
-a same as -t a, select named characters, ignoring high-order bit
-b same as -t o1, select octal bytes
-c same as -t c, select printable characters or backslash escapes
-d same as -t u2, select unsigned decimal 2-byte units
-f same as -t fF, select floats
-i same as -t dI, select decimal ints
-l same as -t dL, select decimal longs
-o same as -t o2, select octal 2-byte units
-s same as -t d2, select decimal 2-byte units
-x same as -t x2, select hexadecimal 2-byte units
```

example:

```
[root@centos7-1 ~]# od -ta testod.txt
0000000   1  nl   2  nl   3  nl   4  nl   5  nl
0000012
[root@centos7-1 ~]# od -tc testod.txt
0000000   1  \n   2  \n   3  \n   4  \n   5  \n
0000012
```

`-A` Option displays the contents of input in different format by concatenation some special character (offsets).

* **Hexadecimal (using -x along with -A)**
* **Octal (using -o along with -A)**
* **Decimal (using -d along with -A)**

```
[root@centos7-1 ~]# od -Ax -c testod.txt
000000   1  \n   2  \n   3  \n   4  \n   5  \n
00000a
[root@centos7-1 ~]# od -Ao -c testod.txt
0000000   1  \n   2  \n   3  \n   4  \n   5  \n
0000012
[root@centos7-1 ~]# od -Ad -c testod.txt
0000000   1  \n   2  \n   3  \n   4  \n   5  \n
0000010
```

`-An` Option displays the contents of input in character format but with no offset information:

```
[root@centos7-1 ~]# od -An -c testod.txt
   1  \n   2  \n   3  \n   4  \n   5  \n
```

## expand and unexpand

The **expand **command is used to convert tabs in files to spaces.

```
 expand [OPTION]... [FILE]...
```

lets try it :

```
[root@centos7-1 ~]# cat test.txt
this    is    my    test    file.
[root@centos7-1 ~]# od -tc -An test.txt
   t   h   i   s  \t   i   s  \t   m   y  \t   t   e   s   t  \t
   f   i   l   e   .  \n
[root@centos7-1 ~]# expand test.txt > expanded.txt
[root@centos7-1 ~]# od -tc -An expanded.txt
   t   h   i   s                   i   s
   m   y                           t   e   s   t
   f   i   l   e   .  \n
```

By default, expand converts tabs into the corresponding number of spaces. But it is possible to tweak the number of spaces using the -t (– – tabs=N) command line option. This option requires us to enter the new number of spaces(N) we want the tabs to get converted.

```
[root@centos7-1 ~]# expand -t1 test.txt > expanded2.txt
[root@centos7-1 ~]# od -tc -An expanded2.txt
   t   h   i   s       i   s       m   y       t   e   s   t
   f   i   l   e   .  \n
```

expand command options:

```
  -i, --initial       do not convert tabs after non blanks
  -t, --tabs=NUMBER   have tabs NUMBER characters apart, not 8
  -t, --tabs=LIST     use comma separated list of explicit tab positions
      --help     display this help and exit
      --version  output version information and exit
```
The **unexpand **command is used to convert space characters (blanks) into tabs in each file(unexpand needs at least two spaces).

```
unexpand [OPTION]... [FILE]...
```

Lets do reverse:

```
[root@centos7-1 ~]# unexpand expanded.txt > unexpanded.txt
[root@centos7-1 ~]# od -tc -An unexpanded.txt
   t   h   i   s                   i   s
   m   y                           t   e   s   t
   f   i   l   e   .  \n
```

## tr command

tr stands for** translate**. 

```
tr [option] set1 [set2]
```
```
[root@centos7-1 ~]# echo "this is  for   test 123" | tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ
THIS IS  FOR   TEST 123
```
```
[root@centos7-1 ~]# echo "this is  for   test 123" | tr [:lower:] [:upper:]
THIS IS  FOR   TEST 123
```
Translate white-space to tabs:

```
[root@centos7-1 ~]# echo "this is  for   test 123" | tr [:space:] '\t'
this    is        for            test    123
```

`-d `option can be used to delete specified characters :

```
[root@centos7-1 ~]# echo "this is  for   test 123" | tr -d 't'
his is  for   es 123
[root@centos7-1 ~]# echo "this is  for   test 123" | tr -d [:digit:]
this is  for   test
```
We complement the sets using `-c `option For example, to remove all characters except digits, you can use the following.:

```
[root@centos7-1 ~]# echo "this is  for   test 123" | tr -dc [:digit:]
123
```
## pr

The pr command is used to format files for printing.

```
[root@centos7-1 ~]# cat note.txt
hi
this is my note file.
linux is an operating system.
learn linux.

[root@centos7-1 ~]# pr note.txt


2018-12-19 11:25                     note.txt                     Page 1


hi
this is my note file.
linux is an operating system.
learn linux.
```
## nl

nl is a linux command to number lines of the files, it copies its files to standard output, prepending line numbers.

```
nl [OPTION]... [FILE]...
```

```
[root@centos7-1 ~]# nl note.txt 
     1    hi 
     2    this is my note file.
     3    linux is an operating system.
```
`-n Format`Uses the value of the Format variable as the line numbering format. Recognized formats are:

* ln :Left-justified, leading zeros suppressed
* rn :Right-justified, leading zeros suppressed (default)
* rz: Right-justified, leading zeros kept

```
[root@centos7-1 ~]# nl -nln note.txt
1         hi
2         this is my note file.
3         linux is an operating system.

[root@centos7-1 ~]# nl -nrn note.txt       #default
     1    hi
     2    this is my note file.
     3    linux is an operating system.

[root@centos7-1 ~]# nl -nrz note.txt
000001    hi
000002    this is my note file.
000003    linux is an operating system.
```
> By default nl skip over blank lines and does not give a number to them, use -ba switch to assign them numbers.

other ln options:

```
  -b, --body-numbering=STYLE      use STYLE for numbering body lines
  -d, --section-delimiter=CC      use CC for separating logical pages
  -f, --footer-numbering=STYLE    use STYLE for numbering footer lines
  -h, --header-numbering=STYLE    use STYLE for numbering header lines
  -i, --line-increment=NUMBER     line number increment at each line
  -l, --join-blank-lines=NUMBER   group of NUMBER empty lines counted as one
  -n, --number-format=FORMAT      insert line numbers according to FORMAT
  -p, --no-renumber               do not reset line numbers at logical pages
  -s, --number-separator=STRING   add STRING after (possible) line number
  -v, --starting-line-number=NUMBER  first line number on each logical page
  -w, --number-width=NUMBER       use NUMBER columns for line numbers
      --help     display this help and exit
      --version  output version information and exit
```

`cat -n filename` does the same thing that`  nl  `command do.


## fmt

fmt simple optimal text formatter.

```
fmt [-WIDTH] [OPTION]... [FILE]...
```

```
[root@centos7-1 ~]# cat note.txt
hi
this is my note file.
linux is an operating system.
learn linux.

[root@centos7-1 ~]# fmt note.txt
hi this is my note file.  linux is an operating system.  learn linux.
```

By default fmt sets the column width at 75. This can be changed with the -w , --width=WIDTHoption.

```
[root@centos7-1 ~]# fmt -w 12  note.txt
hi this
is my
note file.
linux is an
operating
system.
learn
linux.
```

fmt command options:

```
  -c, --crown-margin        preserve indentation of first two lines
  -p, --prefix=STRING       reformat only lines beginning with STRING,
                              reattaching the prefix to reformatted lines
  -s, --split-only          split long lines, but do not refill
  -t, --tagged-paragraph    indentation of first line different from second
  -u, --uniform-spacing     one space between words, two after sentences
  -w, --width=WIDTH         maximum line width (default of 75 columns)
  -g, --goal=WIDTH          goal width (default of 93% of width)
      --help     display this help and exit
      --version  output version information and exit
```

## sort and uniq

**Sort **is a Linux program used for printing lines of input text files and concatenation of all files in sorted order.


```
sort [OPTION]... [FILE]...
```

```
[root@centos7-1 ~]# cat 1.txt
D 1
d 1
c 2
C 2
A 3
B 4
f 14
[root@centos7-1 ~]# sort 1.txt
A 3
B 4
c 2
C 2
d 1
D 1
f 14
```

If a file has words/lines beginning with both upper case and lower case characters, then sort displays those with upper case at top. However, we can change this behavior using the -f command line option:

```
[root@centos7-1 ~]# sort -f 1.txt
A 3
B 4
C 2
c 2
D 1
d 1
f 14
```

The`  -n  `option sort the contents numerically. Also we can sort a file base on "`n"`**th** column with `-k`n option:

```
[root@centos7-1 ~]# sort  -n -k2 1.txt
d 1
D 1
c 2
C 2
A 3
B 4
f 14
```

user `-r `to reverse the result of comparisons. Other options of sort command:

```
  -b, --ignore-leading-blanks  ignore leading blanks
  -d, --dictionary-order      consider only blanks and alphanumeric characters
  -f, --ignore-case           fold lower case to upper case characters
  -g, --general-numeric-sort  compare according to general numerical value
  -i, --ignore-nonprinting    consider only printable characters
  -M, --month-sort            compare (unknown) < 'JAN' < ... < 'DEC'
  -h, --human-numeric-sort    compare human readable numbers (e.g., 2K 1G)
  -n, --numeric-sort          compare according to string numerical value
  -R, --random-sort           sort by random hash of keys
      --random-source=FILE    get random bytes from FILE
  -r, --reverse               reverse the result of comparisons
      --sort=WORD             sort according to WORD:
                                general-numeric -g, human-numeric -h, month -M,
                                numeric -n, random -R, version -V
  -V, --version-sort          natural sort of (version) numbers within text
```

**uniq **command is used to report or omit repeated lines


```
[root@centos7-1 ~]# cat .gitbook/assets.txt
motherboard
motherboard
cpu
cpu
ram
ram
ram
ram
monitor
monitor
hdd
ssd
mouse
keyboard
keyboard
[root@centos7-1 ~]# uniq .gitbook/assets.txt
motherboard
cpu
ram
monitor
hdd
ssd
mouse
keyboard
```

use -c to display number of repetitions for each line:

```
[root@centos7-1 ~]# uniq -c .gitbook/assets.txt
      2 motherboard
      2 cpu
      4 ram
      2 monitor
      1 hdd
      1 ssd
      1 mouse
      2 keyboard
```

\-d displays only the repeated lines and visa versa -u just shows uniq ones:

```
[root@centos7-1 ~]# uniq -d .gitbook/assets.txt
motherboard
cpu
ram
monitor
keyboard
[root@centos7-1 ~]# uniq -u .gitbook/assets.txt
hdd
ssd
mouse
```

try `-D` to see all duplicated lines. other options from uniq --help :

```
  -c, --count           prefix lines by the number of occurrences
  -d, --repeated        only print duplicate lines, one for each group
  -D, --all-repeated[=METHOD]  print all duplicate lines
                          groups can be delimited with an empty line
                          METHOD={none(default),prepend,separate}
  -f, --skip-fields=N   avoid comparing the first N fields
      --group[=METHOD]  show all items, separating groups with an empty line
                          METHOD={separate(default),prepend,append,both}
  -i, --ignore-case     ignore differences in case when comparing
  -s, --skip-chars=N    avoid comparing the first N characters
  -u, --unique          only print unique lines
  -z, --zero-terminated  end lines with 0 byte, not newline
  -w, --check-chars=N   compare no more than N characters in lines
      --help     display this help and exit
      --version  output version information and exit
```

## split

split command is used to split or break a file into the pieces.

```
 split [options] filename prefix
```

```
[root@centos7-1 split]# split -l 2 my7lines.txt

[root@centos7-1 split]# ls
my7lines.txt  xaa  xab  xac  xad
```
```
[root@centos7-1 split2]# split -b 10MB dsl-4.11.rc2.iso
[root@centos7-1 split2]# ls
dsl-4.11.rc2.iso  xaa  xab  xac  xad  xae  xaf
[root@centos7-1 split2]# du -ah
51M    ./dsl-4.11.rc2.iso
9.6M    ./xaa
9.6M    ./xab
9.6M    ./xac
9.6M    ./xad
9.6M    ./xae
2.7M    ./xaf
101M    .
```
Some other options are:

```
  -a, --suffix-length=N   generate suffixes of length N (default 2)
      --additional-suffix=SUFFIX  append an additional SUFFIX to file names
  -b, --bytes=SIZE        put SIZE bytes per output file
  -C, --line-bytes=SIZE   put at most SIZE bytes of lines per output file
  -d, --numeric-suffixes[=FROM]  use numeric suffixes instead of alphabetic;
                                   FROM changes the start value (default 0)
  -e, --elide-empty-files  do not generate empty output files with '-n'
      --filter=COMMAND    write to shell COMMAND; file name is $FILE
  -l, --lines=NUMBER      put NUMBER lines per output file
  -n, --number=CHUNKS     generate CHUNKS output files; see explanation below
  -u, --unbuffered        immediately copy input to output with '-n r/...'
      --verbose           print a diagnostic just before each
                            output file is opened
      --help     display this help and exit
      --version  output version information and exit

SIZE is an integer and optional unit (example: 10M is 10*1024*1024).  Units
are K, M, G, T, P, E, Z, Y (powers of 1024) or KB, MB, ... (powers of 1000).
```

For joining the splitted files use `cat x* > orginalfile` .

## wc

The wc (word count) command is used to find out number of newline count, word count, byte and characters count in a file.

```
wc [options] filenames
```

A Basic Example of WC Command

```
[root@centos7-1 ~]# wc /etc/inittab
 17  80 511 /etc/inittab
```
Three numbers shown below are **17** (number of **lines**), **80** (number of **words**_\[by default space delimited]_) and **511**(number of **bytes**) of the file.

options:

```
  -c, --bytes            print the byte counts
  -m, --chars            print the character counts
  -l, --lines            print the newline counts
      --files0-from=F    read input from the files specified by
                           NUL-terminated names in file F;
                           If F is - then read names from standard input
  -L, --max-line-length  print the length of the longest line
  -w, --words            print the word counts
      --help     display this help and exit
      --version  output version information and exit
```
## head

The head command reads the first ten lines of a any given file name.

```
head [options] [file(s)]
```

For example lets take a look at /var/log/yum.log file:

```
[root@centos7-1 ~]# head /var/log/yum.log
Aug 26 04:48:25 Updated: openldap-2.4.44-15.el7_5.x86_64
Aug 26 04:48:25 Installed: openldap-clients-2.4.44-15.el7_5.x86_64
Aug 26 04:48:27 Installed: openldap-servers-2.4.44-15.el7_5.x86_64
Oct 13 03:38:41 Installed: perl-Data-Dumper-2.145-3.el7.x86_64
Oct 13 03:38:41 Installed: perl-Net-Daemon-0.48-5.el7.noarch
Oct 13 03:38:41 Installed: perl-Digest-1.17-245.el7.noarch
Oct 13 03:38:41 Installed: perl-Digest-MD5-2.52-3.el7.x86_64
Oct 13 03:38:41 Installed: 7:squid-migration-script-3.5.20-12.el7.x86_64
Oct 13 03:38:41 Installed: 1:perl-Compress-Raw-Zlib-2.061-4.el7.x86_64
Oct 13 03:38:42 Installed: libecap-1.0.0-1.el7.x86_64
```

For retrieving desired number of lines use -n\<number> or simple -\<number> options:

```
[root@centos7-1 ~]# head -n 2 /var/log/yum.log
Aug 26 04:48:25 Updated: openldap-2.4.44-15.el7_5.x86_64
Aug 26 04:48:25 Installed: openldap-clients-2.4.44-15.el7_5.x86_64
[root@centos7-1 ~]# head -2 /var/log/yum.log
Aug 26 04:48:25 Updated: openldap-2.4.44-15.el7_5.x86_64
Aug 26 04:48:25 Installed: openldap-clients-2.4.44-15.el7_5.x86_64
```
Options from`head --help` :

```
  -c, --bytes=[-]K         print the first K bytes of each file;
                             with the leading '-', print all but the last
                             K bytes of each file
  -n, --lines=[-]K         print the first K lines instead of the first 10;
                             with the leading '-', print all but the last
                             K lines of each file
  -q, --quiet, --silent    never print headers giving file names
  -v, --verbose            always print headers giving file names
      --help     display this help and exit
      --version  output version information and exit

K may have a multiplier suffix:
b 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024,
GB 1000*1000*1000, G 1024*1024*1024, and so on for T, P, E, Z, Y.
```
## tail

tail command displays last ten lines of any text file.

```
tail [options] [filenames]
```

Similar to the head command above, tail command also support options -n number of lines and n number of characters.

```
[root@centos7-1 ~]# tail -n 5 /var/log/yum.log
Dec 05 10:02:37 Updated: firefox-60.3.0-1.el7.centos.x86_64
Dec 05 10:02:37 Updated: nss-tools-3.36.0-7.el7_5.x86_64
Dec 05 10:02:37 Updated: 1:dbus-x11-1.10.24-7.el7.x86_64
Dec 08 11:54:14 Installed: zip-3.0-11.el7.x86_64
Dec 08 13:10:52 Installed: vsftpd-3.0.2-22.el7.x86_64
```

\-f option will cause tail will loop forever, checking for new data at the end of the file(s). When new data appears, it will be printed. It works great with log files and lets us see what is going on:

```
[root@centos7-1 ~]# tail -f /var/log/dmesg
[   19.126805] AES CTR mode by8 optimization enabled
[   19.129902] ppdev: user-space parallel port driver


```
options:

```
  -c, --bytes=K            output the last K bytes; or use -c +K to output
                             bytes starting with the Kth of each file
  -f, --follow[={name|descriptor}]
                           output appended data as the file grows;
                             an absent option argument means 'descriptor'
  -F                       same as --follow=name --retry
  -n, --lines=K            output the last K lines, instead of the last 10;
                             or use -n +K to output starting with the Kth
      --max-unchanged-stats=N
                           with --follow=name, reopen a FILE which has not
                             changed size after N (default 5) iterations
                             to see if it has been unlinked or renamed
                             (this is the usual case of rotated log files);
                             with inotify, this option is rarely useful
      --pid=PID            with -f, terminate after process ID, PID dies
  -q, --quiet, --silent    never output headers giving file names
      --retry              keep trying to open a file if it is inaccessible
  -s, --sleep-interval=N   with -f, sleep for approximately N seconds
                             (default 1.0) between iterations;
                             with inotify and --pid=P, check process P at
                             least once every N seconds
  -v, --verbose            always output headers giving file names
      --help     display this help and exit
      --version  output version information and exit
```
## less

less command allows you to view the contents of a file and navigate through file.

```
[root@centos7-1 ~]# dmesg |less
```

```
[    0.000000] BIOS-e820: [mem 0x00000000bfeff000-0x00000000bfefffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bff00000-0x00000000bfffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffe0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable
:
```
> **less vs more**
>
> less command is similar to more, he main difference between more and less is that less command is faster because it does not load the entire file at once and allows navigation though file using page up/down keys.
>
> Whether you decide to use more or less, which is a personal choice, remember that less is more with more features.

## cut

The cut command in UNIX is a command line utility for cutting sections from each line of files and writing the result to standard output. It can be used to cut parts of a line by byte **position**, **character **and **delimiter**.

```
cut OPTION... [FILE]...
```

**cut by byte position:**

```
[root@centos7-1 ~]# echo "linux" | cut -b 1
l
[root@centos7-1 ~]# echo "linux" | cut -b 1,5
lx
[root@centos7-1 ~]# echo "linux" | cut -b 1-4
linu
```
**cut by character:**

```
[root@centos7-1 ~]# echo '♣foobar' | cut -c 1,7
♣r
[root@centos7-1 ~]# echo '♣foobar' | cut -c 5-7
bar
```

**cut based on a delimiter:**

```
cat 1.txt
1:a,w
2:b,x
3:c,y
4:d,z
```

```
[root@centos7-1 ~]# cut 1.txt -d: -f1
1
2
3
4
[root@centos7-1 ~]# cut 1.txt -d: -f2
a,w
b,x
c,y
d,z
[root@centos7-1 ~]# cut 1.txt -d, -f1
1:a
2:b
3:c
4:d
[root@centos7-1 ~]# cut 1.txt -d, -f2
w
x
y
z
```
cut has lots of options:

```
  -b, --bytes=LIST        select only these bytes
  -c, --characters=LIST   select only these characters
  -d, --delimiter=DELIM   use DELIM instead of TAB for field delimiter
  -f, --fields=LIST       select only these fields;  also print any line
                            that contains no delimiter character, unless
                            the -s option is specified
  -n                      with -b: don't split multibyte characters
      --complement        complement the set of selected bytes, characters
                            or fields
  -s, --only-delimited    do not print lines not containing delimiters
      --output-delimiter=STRING  use STRING as the output delimiter
                            the default is to use the input delimiter
      --help     display this help and exit
      --version  output version information and exit
```

## paste

The paste command displays the corresponding lines of multiple files side-by-side.

```
paste [OPTION]... [FILE]...
```
```
cat 1.txt 
a
b
c
d


cat 2.txt
e
f
g
h
```
```
[root@centos7-1 ~]# paste 1.txt 2.txt
a    e
b    f
c    g
d    h
```
paste writes lines consisting of the sequentially corresponding lines from each FILE, separated by tabs.To apply a colon (:) as a delimiting character instead of tabs, use -d option:

```
[root@centos7-1 ~]# paste -d: 1.txt 2.txt
a:e
b:f
c:g
d:h
```
paste command options:

```
  -d, --delimiters=LIST   reuse characters from LIST instead of TABs
  -s, --serial            paste one file at a time instead of in parallel
      --help     display this help and exit
      --version  output version information and exit
```

## join

Joins the lines of two files which share a common field of data.

>  When **using `join`**, the **input files must be sorted **_**by the join field ONLY**_, otherwise you may see the warning

```
join [OPTION]... FILE1 FILE2
```

```
cat 1.txt
1 a
2 b
4 d
5 e

cat 2.txt
1 w
3 y
4 z
5 q
```
```
[root@centos7-1 ~]# join 1.txt 2.txt
1 a w
4 d z
5 e q
```
```
  -a FILENUM        also print unpairable lines from file FILENUM, where
                      FILENUM is 1 or 2, corresponding to FILE1 or FILE2
  -e EMPTY          replace missing input fields with EMPTY
  -i, --ignore-case  ignore differences in case when comparing fields
  -j FIELD          equivalent to '-1 FIELD -2 FIELD'
  -o FORMAT         obey FORMAT while constructing output line
  -t CHAR           use CHAR as input and output field separator
  -v FILENUM        like -a FILENUM, but suppress joined output lines
  -1 FIELD          join on this FIELD of file 1
  -2 FIELD          join on this FIELD of file 2
  --check-order     check that the input is correctly sorted, even
                      if all input lines are pairable
  --nocheck-order   do not check that the input is correctly sorted
  --header          treat the first line in each file as field headers,
                      print them without trying to pair them
  -z, --zero-terminated     end lines with 0 byte, not newline
      --help     display this help and exit
      --version  output version information and exit
```

## sed

The name **Sed **is short for **\_s_tream \_ed_itor**.\
**S** stream editor is used to perform basic text transformations on an input stream (a file or input from a pipeline).

```
[root@centos7-1 ~]# cat sample.txt
there are different operating systems in our planet.
one of them is linux.
almost six hundred linux distributions exist.

[root@centos7-1 ~]# sed 's/l/L/' sample.txt
there are different operating systems in our pLanet.
one of them is Linux.
aLmost six hundred linux distributions exist.
```

```
[root@centos7-1 ~]# sed 's/l/L/g' sample.txt
there are different operating systems in our pLanet.
one of them is Linux.
aLmost six hundred Linux distributions exist.
```

Additionally, we can gi instead of g in order to ignore character case:

```
[root@centos7-1 ~]# sed 's/linux/LINUX/gi' sample.txt
there are different operating systems in our planet.
one of them is LINUX.
almost six hundred LINUX distributions exist.
```

Another example is replacing blank spaces with tab :

```
[root@centos7-1 ~]# cat sample.txt
there are different operating systems in our planet.
one of them is linux.
almost six hundred linux distributions exist.

[root@centos7-1 ~]# sed 's/ /\t/g' sample.txt  | cat
there    are    different    operating    systems    in    our    planet.
one    of    them    is    linux.
almost    six    hundred    linux    distributions    exist.
```

sed is extremely powerful, and the tasks it can accomplish are limited only by your imagination.

.

.

.

sources:

[https://developer.ibm.com/tutorials/l-lpic1-103-2/](https://developer.ibm.com/tutorials/l-lpic1-103-2/)

[https://ryanstutorials.net/linuxtutorial/piping.php#piping](https://ryanstutorials.net/linuxtutorial/piping.php#piping)

[https://www.tecmint.com/linux-io-input-output-redirection-operators/](https://www.tecmint.com/linux-io-input-output-redirection-operators/)

[https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-i-o-redirection](https://www.digitalocean.com/community/tutorials/an-introduction-to-linux-i-o-redirection)

[https://www.tecmint.com/13-basic-cat-command-examples-in-linux/](https://www.tecmint.com/13-basic-cat-command-examples-in-linux/)

[https://kb.iu.edu/d/afar](https://kb.iu.edu/d/afar)

[https://www.tecmint.com/wc-command-examples/](https://www.tecmint.com/wc-command-examples/)

[https://www.tecmint.com/view-contents-of-file-in-linux/](https://www.tecmint.com/view-contents-of-file-in-linux/)

[http://landoflinux.com/linux_expand_unexpand_command.html](http://landoflinux.com/linux_expand_unexpand_command.html)

[https://www.geeksforgeeks.org/expand-command-in-linux-with-examples/](https://www.geeksforgeeks.org/expand-command-in-linux-with-examples/)

[https://www.thegeekstuff.com/2012/12/linux-tr-command](https://www.thegeekstuff.com/2012/12/linux-tr-command)

[https://www.howtoforge.com/linux-uniq-command/](https://www.howtoforge.com/linux-uniq-command/)

[https://www.tecmint.com/linux-file-operations-commands/](https://www.tecmint.com/linux-file-operations-commands/)

[https://www.tecmint.com/20-advanced-commands-for-linux-experts/](https://www.tecmint.com/20-advanced-commands-for-linux-experts/)

[https://www.ibm.com/support/knowledgecenter/en/ssw_aix\_72/com.ibm.aix.cmds4/nl.htm](https://www.ibm.com/support/knowledgecenter/en/ssw_aix\_72/com.ibm.aix.cmds4/nl.htm)

[https://shapeshed.com/unix-fmt/](https://shapeshed.com/unix-fmt/)

[https://www.tecmint.com/linux-more-command-and-less-command-examples/](https://www.tecmint.com/linux-more-command-and-less-command-examples/)

[https://www.tecmint.com/linux-file-operations-commands/](https://www.tecmint.com/linux-file-operations-commands/)

[https://shapeshed.com/unix-cut/](https://shapeshed.com/unix-cut/)

[https://www.computerhope.com/unix/upaste.htm](https://www.computerhope.com/unix/upaste.htm)

[https://www.howtoforge.com/tutorial/linux-join-command/](https://www.howtoforge.com/tutorial/linux-join-command/)

[https://www.tecmint.com/sed-command-to-create-edit-and-manipulate-files-in-linux/](https://www.tecmint.com/sed-command-to-create-edit-and-manipulate-files-in-linux/)

[https://www.tecmint.com/linux-sed-command-tips-tricks/](https://www.tecmint.com/linux-sed-command-tips-tricks/)

.






