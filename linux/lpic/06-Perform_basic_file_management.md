![24](../../assets/24-shell.png)

# 103.3. Perform basic file management

### ls

ls **lists files and directories**
```
ls [options] [file|dir]
```
```
user1@ubuntu16-1:~$ ls -1
Desktop
Documents
Downloads
examples.desktop
Music
Pictures
Public
Templates
Videos
```
```
user1@ubuntu16-1:~$ ls -l
total 44
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Desktop
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Documents
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Downloads
-rw-r--r-- 1 user1 user1 8980 Apr 20  2016 examples.desktop
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Music
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Pictures
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Public
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Templates
drwxr-xr-x 2 user1 user1 4096 Nov  4  2018 Videos
```

The first character represents the file type: "-" for a regular file, "d" for a directory, "l" for a symbolic link(we will see them).

When the long listing format is used the ls command will display the following file information:

1. The file type
2. The file permissions
3. Number of hard links to the file
4. File owner
5. File group
6. File size
7. Date and Time
8. File name

**Show Hidden Files**
```
user1@ubuntu16-1:~$ ls -a
.              .config           .gconf         Pictures   .Xauthority
..             Desktop           .gnupg         .profile   .xsession-errors
.bash_history  .dmrc             .ICEauthority  Public     .xsession-errors.old
.bash_logout   Documents         .local         .ssh
.bashrc        Downloads         .mozilla       Templates
.cache         examples.desktop  Music          Videos
```

Some other usefull options:

| ls command options | description                                              |
| ------------------ | -------------------------------------------------------- |
| -l                 | list with long format - show permissions                 |
| -r                 | list in reverse order                                    |
| -t                 | sort by time & date                                      |
| -lh                | List Files with Human Readable Format                    |
| -F                 | List Files and Directories with ‘/’ Character at the end |
| -R                 | Recursively list Sub-Directories                         |
| -a                 | list all files including hidden file starting with '.'   |

## Copying, Moving & Deleting
#### Linux Files Timestamps

In Linux every single file is associated with timestamps, and every file stores the information of **last access time**, **last modification time** and **last change time**. So, whenever we create new file, access or modify an existing file, the timestamps of that file automatically updated.

A file in Linux has three timestamps:

* **atime** (access time) - The last time the file was accessed/opened by some command or application such as cat, vim or grep.
* **mtime** (modify time) - The last time the file’s content was modified.
* **ctime** (change time) - The last time the file’s attribute or content was changed. The attribute includes file permissions, file ownership or file location.

To display the file status including the timestamps you can use the `stat` command.(we use ubuntu 16.04 here)

```
root@ubuntu16-1:~# stat /etc/hosts
  File: '/etc/hosts'
  Size: 247           Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d    Inode: 1200795     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2019-09-08 02:34:44.962514623 -0700
Modify: 2018-07-01 23:15:30.140815060 -0700
Change: 2018-07-01 23:15:30.144817112 -0700
 Birth: -
```
### touch

The touch command is a standard command used in UNIX/Linux operating system which is used to create, change and modify timestamps of a file.

* touch command (with no option) create an empty file if file does not exist.
* if file exists touch command would change its time stamps .

**creating an empty file:**

touch command is used to create a file without any content. The file created using touch command is empty. This command can be used when the user doesn’t have data to store at the time of file creation.

```
touch file_name
```
**creating multiple empty files:**

```
touch File1_name File2_name File3_name
```
#### touch command timestamp options:

* `-a`: change the **access time** only
* `-d`: update the **access and modification times**
* `-m`: change the **modification time only**
* `-r`: **use the access and modification times of other file as reference.**
* `-t`: **creates a file using a specified time**

Lets do some timestamp modifications.

Create a file using a specified time:`touch -t YYMMDDHHMM fileName`

### mkdir

mkdir command in Linux allows the user to create directories (also referred to as folders in some operating systems )

```
mkdir [options...] [directories ...]
```
Lets try some of the most useful switches, `-p`enables the command to create parent directories as necessary.

```
root@ubuntu16-1:~/test-space# mkdir -p dir1/floor1/floor2
root@ubuntu16-1:~/test-space# tree
.
└── dir1
    └── floor1
        └── floor2

3 directories, 0 files
```
We can create a directory and set the permissions(will be discussed later) for that directory at the same time using -m option:

```
root@ubuntu16-1:~/test-space# mkdir -m777 dir2 
root@ubuntu16-1:~/test-space# ls -l
total 8
drwxr-xr-x 3 root root 4096 Sep  8 03:57 dir1
drwxrwxrwx 2 root root 4096 Sep  8 04:09 dir2
```

The syntax of the mode is the same as the chmod command (will be discussed later).

```
root@ubuntu16-1:~/test-space# mkdir -v -m o=--- dir3
mkdir: created directory 'dir3'
root@ubuntu16-1:~/test-space# ls -l
total 12
drwxr-xr-x 3 root root 4096 Sep  8 03:57 dir1
drwxrwxrwx 2 root root 4096 Sep  8 04:09 dir2
drwxr-x--- 2 root root 4096 Sep  8 04:14 dir3
```

with `-v`option, it prints a message for each created directory.

### cp

The `cp` command is a command-line utility for copying files and directories.  \[Copies of files are independent of the original file( unlike the `mv` command)  ].The basic syntax of the cp command is:

```
cp [options….] source(s) destination
```

> cp can take 1 or more sources(s) but just one destination.

**copy a file:**

```
root@ubuntu16-1:~/test-space# cp file1 file2
root@ubuntu16-1:~/test-space# ls
dir1  dir2  dir3  file1  file2
```

**take a backup when copying a file**

If a copy operation will overwrite a file the `-b` flag may be used to create a back up of the file. This copies the file into place and writes a backup file.

```
root@ubuntu16-1:~/test-space# ls
dir1  dir2  dir3   file1  file2  
root@ubuntu16-1:~/test-space# echo "this is file2 content" > file2
root@ubuntu16-1:~/test-space# echo "ehis is file1 content" > file1
root@ubuntu16-1:~/test-space# cp -b file1 file2
root@ubuntu16-1:~/test-space# ls
dir1  dir2  dir3   file1  file2  file2~ 
root@ubuntu16-1:~/test-space# cat file2
ehis is file1 content
root@ubuntu16-1:~/test-space# cat file2~
this is file2 content
```
**copy multiple files (into a directory)**

```
root@ubuntu16-1:~/test-space# cp file1 file2 dir2/
```
**Copying files recursively**

We can use cp to copy entire directory structures from one place to another using the `-R `option to perform a recursive copy.

`cp -R ~/test-space ~/files-backup`

**copy a directory**

By default the cp command will not copy directories. Attempting to copy a directory results in an error.

```
root@ubuntu16-1:~/test-space# cp dir2 dir4
cp: omitting directory 'dir2'
```

To copy a directory pass the `-R` flag. This will recursively copy a folder and create a copy.

```
root@ubuntu16-1:~/test-space# cp -R dir1 NewDirectoryA
```
**copy multiple directories**

To copy multiple directories pass the path of the directories to be copied followed by the destination directory.

```
root@ubuntu16-1:~/test-space# cp -R dir1 dir2 NewDirectoryB
cp: target 'NewDirectoryB' is not a directory
root@ubuntu16-1:~/test-space# mkdir NewDirectoryB
root@ubuntu16-1:~/test-space# cp -R dir1 dir2 NewDirectoryB
```
### mv

`mv` is used to **move or rename one or more files or directories**. In general, the names we can use follow the same rules as for copying with cp; \[If you are moving a file on the same file system, the inode wont change]. 

* Rename a file( or directory) name source to destination:

```
mv [options]  source destination
```
**Renaming a File or a directory:**

```
root@ubuntu16-1:~/test-space# mv file1 NewFile1
```
**Moving Files into a directory:**

```
root@ubuntu16-1:~/test-space# mv NewFile1 file2 dir3
mv: target 'dir3' is not a directory
root@ubuntu16-1:~/test-space# mkdir dir3
root@ubuntu16-1:~/test-space# mv NewFile1 file2 dir3
```
**Moving a directory into another :**

```
root@ubuntu16-1:~/test-space# mv dir3 dirA
```
usefull mv command options:

| mv command options | description                                               |
| ------------------ | --------------------------------------------------------- |
| -v                 | verbose - print source and destination files              |
| -i                 | interactive prompt before overwrite                       |
| -u                 | update - move when source is newer than destination       |
| -f                 | force move by overwriting destination file without prompt |

> #### cp vs mv :
>
> Normally, the cp command will copy a file over an existing copy, if the existing file is writable. On the other hand, the mv will not move or rename a file if the target exists. We can overcome this using the`-f`switch.

### rm

`rm` stands for **remove** here. `rm` removes files or directories.

```
rm [OPTION]... FILE...
```

**Removing Files**

```
root@ubuntu16-1:~/test-space# rm file1
```
some other options of rm command:

| mv options | description                                                  |
| ---------- | ------------------------------------------------------------ |
| -v         | Verbose mode; explain at all times what is being done.       |
| -i         | prompt before every removal                                  |
| -f,--force | Ignore none existant files,and never prompt before removing. |
| -d,--dir   | Remove empty directories.                                    |

#### Removing directories

```
root@ubuntu16-1:~/test-space# rm dir1
rm: cannot remove 'dir1': Is a directory
```

By default, `rm` does not remove directories.

If the specified directory is empty, it may be removed with the -d/--dir option, instead.

```
root@ubuntu16-1:~/test-space# rm -d dir1
```

What if desired directory contains some files? If the **-r/-R/--recursive** option is specified, we can remove that directory however rm will remove any matching directories and their contents!

```
root@ubuntu16-1:~/test-space# rm -rf dir2
```
### rmdir

Removing directories using the rmdir command is the opposite of creating them. We can remove a directory with `rmdir` only if it is **empty** as there is** no option to force removal**.

```
rmdir [options] directory ...
```
**Recursive copy**

We can use the -r (or -R or --recursive) option to cause the cp command to descend into source directories and copy the contents recursively. To prevent an infinite recursion, we cannot copy the source directory itself!

```
root@ubuntu16-1:~# cp -R test-space NewCopy
```
## Wildcards and Globbing

**File globbing is a feature provided by the UNIX/Linux shell to represent multiple filenames by using special characters called wildcards with a single file name.**
* `?` **is used to match any single character. **We can use ‘?’ for multiple times for matching multiple characters.

```
root@ubuntu16-1:~/test-space# ls ???.txt
aaa.txt
```
* `*`** is used to match zero or more characters.** If we have less information to search any file or information then we can use ‘\*’ in globbing pattern.

```
root@ubuntu16-1:~/test-space# ls *.txt
aaa.txt  ababa.txt  bbbb.txt
```
* `[ ]`**is used to match the character from the range. Some of the mostly used range declarations are mentioned below:**

`[A-Z]` : All uppercase alphabets

`[a-z]` : All lowercase alphabets

`[a-zA-Z0-9]` : All uppercase alphabets, lowercase alphabet and digits

> The`-`character between two others represents a range that includes the two other characters and all characters between them in the collating sequence.

```
root@ubuntu16-1:~/test-space# ls [e-z]*
file1  file2
```
* **The**`!`** character means NOT so  it matches any character except the remaining characters**.

```
root@ubuntu16-1:~/test-space# ls [!e-z]*
aaa.txt  ababa.txt  bbbb.txt
```

* `{ }`**can be used to match filenames with more than one globbing patterns. Each pattern is separated by ‘,’ in curly bracket without any space.**

```
root@ubuntu16-1:~/test-space# ls {???.txt,????.txt}
aaa.txt  bbbb.txt
```

`rm {*.doc,*.docx}` : delete all files whose extensions are ‘doc’ or ‘docx’.

### Finding Files

 The find command is used to find files in one or more directory trees, based on criteria such as name, time stamp, or size.

### find

The find command searches for files or directories using all or part of the name, or by other search criteria, such as size, type, file owner, creation date, or last access date.

```
find starting/path options  expression
```
```
root@ubuntu16-1:~/test-space# find /etc/ -iname "[y-z]*"
/etc/xdg/autostart/zeitgeist-datahub.desktop
/etc/zsh_command_not_found
/etc/vmware-tools/messages/zh_TW
/etc/vmware-tools/messages/zh_CN
/etc/dhcp/dhclient-exit-hooks.d/zzz_avahi-autoipd
/etc/kernel/postrm.d/zz-update-grub
/etc/kernel/postinst.d/zz-update-grub
/etc/brltty/Contraction/zu.ctb
/etc/brltty/Contraction/zh-tw-ucb.ctb
/etc/brltty/Contraction/zh-tw.ctb
```

`-name` option used for searching for files based on their name. `-i`makes it case insensitive. In the first example above, we found both files and a directory (/etc). 

**Finding files by type**

We can specify the type of files you want to find with the “-type” parameter. It works like this:

```
find -type type_descriptor query
```

* `-type f`will search for a regular file
* `-type d` will search for a directory
* `-type l` will search for a symbolic link

```
root@ubuntu16-1:~/test-space# find /etc/ -type f -iname "[y-z]*"
/etc/xdg/autostart/zeitgeist-datahub.desktop
/etc/zsh_command_not_found
/etc/dhcp/dhclient-exit-hooks.d/zzz_avahi-autoipd
/etc/kernel/postrm.d/zz-update-grub
/etc/kernel/postinst.d/zz-update-grub
/etc/brltty/Contraction/zu.ctb
/etc/brltty/Contraction/zh-tw-ucb.ctb
/etc/brltty/Contraction/zh-tw.ctb
```

**Finding files by size**
* `-size  +/- [b] [c] [w] [k] [M} [G]`

```
b     for 512-byte blocks (this is the default if no suffix is used)
c     for bytes
w     for two-byte words
k     for Kilobytes (units of 1024 bytes)
M     for Megabytes (units of 1048576 bytes)
G     for Gigabytes (units of 1073741824 bytes)
```

as an example lets find files smaller than 1 kilobytes:

```
root@ubuntu16-1:~/test-space# find /etc/ -type f -size -1k
/etc/dictionaries-common/ispell-default
/etc/cups/printers.conf
/etc/vmware-caf/pme/config/_previous_/cafenv.config
/etc/.pwd.lock
/etc/apt/trusted.gpg.d/peek-developers_ubuntu_stable.gpg~
/etc/security/opasswd
/etc/gconf/gconf.xml.defaults/%gconf-tree.xml
/etc/gconf/gconf.xml.mandatory/%gconf-tree.xml
/etc/sensors.d/.placeholder
/etc/newt/palette.original
```
We can find all empty files using `find . -size 0b` or `find . -empty` .

**Finding files based on their time:**

Linux stores time data about access times, modification times, and change times.

* **Access Time**: Last time a file was read or written to.
* **Modification Time**: Last time the contents of the file were modified.
* **Change Time**: Last time the file’s inode meta-data was changed.

We can use the time stamps described with the touch command to locate files having particular time stamps.

```
-amin n: The file was last accessed n minutes ago
-anewer: The file was last accessed more recently than it was modified
-atime n: The file was last accessed more n days ago
-cmin n: The file was last changed n minutes ago
-cnewer: The file was last changed more recently than the file was modified
-ctime n: The file was last changed more than n days ago
-mmin n: File's data was last modified n minutes ago
-mtime n: File's data was last modified n days ago
```

again (+/-) signs can be used to give it a range.

Find Changed Files in Last 2 Hours:

```
root@ubuntu16-1:~/test-space# find /home -cmin -120
```
#### Executing and Combining Find Commands (-exec)

We can execute an arbitrary helper command on everything that find matches by using the “-exec” parameter. This is called like this:

```
find find_parameters -exec command_and_params {} \;
```

The `{}` is used as a placeholder for the files that find matches. The “\\;” is used so that find knows where the command ends.

As an instance this will remove all empty files:

```
find . -empty -exec rm {} \;
```

We could remove all empty files in this directory and its subdirectories:

```
find . -empty -exec rm '{}' \;
```
### file

The file command tells us something about the type of data in one or more files.

```
file [option] [filename]
```
### Archiving and Compressing files

Archiving and compressing are two different things

* tar just archive files and does not do any compression by default.
* zip does both archiving and compresion.
* gzip and bzip2 are used just for compression.

### zip

`Zip` is one of the most popular archive file format out there. With zip, you can compress multiple files into one file. This not only saves disk space, it also saves network bandwidth. This is why you’ll encounter zip files almost all the time.

```
zip options archive inpath inpath ...
```

```
root@ubuntu16-1:~/test-space/myfiles# zip myconf.zip myconf.txt 
  adding: myconf.txt (deflated 60%)
```
use the `-r` option with the zip command and it will recursively zips the files in a directory. This option helps you to zip all the files present in the specified directory:

```
root@ubuntu16-1:~/test-space/myfiles# cd ..
root@ubuntu16-1:~/test-space# zip -r myfiles.zip myfiles/
  adding: myfiles/ (stored 0%)
  adding: myfiles/dir1/ (stored 0%)
  adding: myfiles/dir1/myvideo.mp4 (deflated 71%)
  adding: myfiles/etc/ (stored 0%)
  adding: myfiles/dir2/ (stored 0%)
  adding: myfiles/dir2/zabbix-cli-rpm-2.1.1-1.tar.gz (deflated 0%)
  adding: myfiles/dir2/zabbix-cli-manual-1.7.0.pdf (deflated 88%)
  adding: myfiles/mylog.txt (deflated 89%)
  adding: myfiles/myconf.txt (deflated 60%)
  adding: myfiles/myconf.zip (stored 0%)
```

### uzip

A separate companion program, unzip, unpacks and uncompresses zip archives.

```
root@ubuntu16-1:~/test-space# rm -rf myfiles
root@ubuntu16-1:~/test-space# unzip myfiles.zip 
Archive:  myfiles.zip
   creating: myfiles/
   creating: myfiles/dir1/
  inflating: myfiles/dir1/myvideo.mp4  
   creating: myfiles/etc/
   creating: myfiles/dir2/
  inflating: myfiles/dir2/zabbix-cli-rpm-2.1.1-1.tar.gz  
  inflating: myfiles/dir2/zabbix-cli-manual-1.7.0.pdf  
  inflating: myfiles/mylog.txt       
  inflating: myfiles/myconf.txt      
 extracting: myfiles/myconf.zip   
```

| zip command example                     | Description                                     |
| --------------------------------------- | ----------------------------------------------- |
| zip –v filename.zip file1.txt           |  Verbose mode or print diagnostic version info. |
| zip –d filename.zip file.txt            |  Removes the file from the zip archive.         |
| zip –u filename.zip file.txt            | Updates the file in the zip archive.            |
| zip –m filename.zip file.txt            | Deletes the original files after zipping.       |
| zip –x filename.zip file_to_be_excluded | Exclude the files in creating the zip.          |

### Compressing files

### gzip

Gzip (GNU zip) is a compressing tool, which is used to truncate the file size. 

```
gzip [OPTION]... [FILE]...
```

**By default** original file will be replaced by the compressed file ending with extension (.gz) and gzip removes the original files after creating the compressed file. gzip keeps the original file mode, ownership, and timestamp.

```
root@ubuntu16-1:~/test-space/myfiles# gzip mylog.txt 
```
### gunzip

To decompress a file we can use gunzip command and your original file will be back.

```
root@ubuntu16-1:~/test-space/myfiles# gunzip mylog.txt.gz 
```
### bzip2

Like gzip, bzip2  command in Linux is used to compress and decompress the files. It uses different compression algorithm so it compress files better than gzip, but  It has a slower decompression time and higher memory use.

```
bzip2 [OPTIONS] filenames ...
```
```
root@ubuntu16-1:~/test-space/myfiles# bzip2 mylog.txt 
```
### bunzip2

bunzip2 is used for decompression bzip2 files:

```
root@ubuntu16-1:~/test-space/myfiles# bunzip2 mylog.txt.bz2 
```
also  **-d ** option is used for decompression of compressed files.

| bzip2 command example | Description                                                    |
| --------------------- | -------------------------------------------------------------- |
| bzip2 -k input.txt    | does compression but does not deletes the original file        |
| bzip2 -z input.txt    | forces compression. It is an opposite command of decompression |
| bzip2 -v input.txt    | show the compression ratio for each file processed             |
| bzip2 -L filename.gz  | -V , -L used to display the software version, license terms    |
| bzip2 -q input.txt    |  It will suppress non-essential warning messages.              |

bzip2 doesn't any options for compressing a directory, so use tar with that. How? read tar section.

### xz

xz is a new general-purpose, command line data compression utility, similar to gzip and bzip2. It can be used to compress or decompress a file according to the selected operation mode. It supports various formats to compress or decompress files.

Selecting a compression utility to use will depend mainly on two factors, the compression speed and rate of a given tool. Unlike its counterparts, xz is not commonly used but offers the best compression.

```
root@ubuntu16-1:~/test-space/myfiles# ls
dir1  dir2  myconf.txt  mylog.txt
root@ubuntu16-1:~/test-space/myfiles# xz mylog.txt 
```

or we could use xz `-x` file to compress that. `-d` is used for decompression:

```
root@ubuntu16-1:~/test-space/myfiles# xz -d mylog.txt.xz 
root@ubuntu16-1:~/test-space/myfiles# ls -l
total 1144
drwxr-xr-x 2 root root    4096 Sep 30 05:42 dir1
drwxr-xr-x 2 root root    4096 Oct  5 05:25 dir2
-rw-r--r-- 1 root root    2084 Sep 30 05:44 myconf.txt
-rw-r----- 1 root root 1156369 Sep 30 05:41 mylog.txt
```

| xz command example | Description                                                                                                       |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| xz -k file.txt     | prevent deleting of the input file(s)                                                                             |
| xz -f file.txt.xz  | use the -f option to force the process(ex: compressed file already exist)                                         |
| xz -9 file.txt     | different compression preset levels (0 to 9, with default being 6) --fast equals  -0 and --best is the same as -9 |
| xz -q file.txt     | run it in quiet mode or enable verbose mode with the -v                                                           |

### Archiving files

An Archive file is a file that is composed of one or more files along with metadata. Archive files are used to collect multiple data files together into a single file for easier portability and storage, or simply to compress files to use less storage space.

### tar

The Linux ‘tar’ stands for tape archive, is used to create Archive and extract the Archive files. tar command in Linux is one of the important command which provides archiving functionality in Linux.

Here a few common use cases of the tar command:

* Backup of Servers and Desktops.
* Document archiving.
* Software Distribution.

**Create tar Archive File**

```
root@ubuntu16-1:~/test-space# tar -cvf myarch.tar myfiles
myfiles/
myfiles/dir1/
myfiles/dir1/myvideo.mp4
myfiles/dir2/
myfiles/dir2/zabbix-cli-rpm-2.1.1-1.tar.gz
myfiles/dir2/zabbix-cli-manual-1.7.0.pdf
myfiles/mylog.txt
myfiles/myconf.txt

root@ubuntu16-1:~/test-space# ls
myarch.tar  myfiles
```
**Untar tar Archive File**

```
root@ubuntu16-1:~/test-space# tar -xvf myarch.tar 
myfiles/
myfiles/dir1/
myfiles/dir1/myvideo.mp4
myfiles/dir2/
myfiles/dir2/zabbix-cli-rpm-2.1.1-1.tar.gz
myfiles/dir2/zabbix-cli-manual-1.7.0.pdf
myfiles/mylog.txt
myfiles/myconf.txt
```
```
root@ubuntu16-1:~/test-space# tar -cvzf myfiles.tar.gz myfiles/
myfiles/
myfiles/dir1/
myfiles/dir1/myvideo.mp4
myfiles/dir2/
myfiles/dir2/zabbix-cli-rpm-2.1.1-1.tar.gz
myfiles/dir2/zabbix-cli-manual-1.7.0.pdf
myfiles/mylog.txt
myfiles/myconf.txt

root@ubuntu16-1:~/test-space# tar -cvjf myfiles.tar.bz2 myfiles/
myfiles/
myfiles/dir1/
myfiles/dir1/myvideo.mp4
myfiles/dir2/
myfiles/dir2/zabbix-cli-rpm-2.1.1-1.tar.gz
myfiles/dir2/zabbix-cli-manual-1.7.0.pdf
myfiles/mylog.txt
myfiles/myconf.txt

root@ubuntu16-1:~/test-space# ls -lh
total 6.4M
drwxr-xr-x 4 root root 4.0K Oct  5 23:51 myfiles
-rw-r--r-- 1 root root 3.2M Oct  6 01:59 myfiles.tar.bz2
-rw-r--r-- 1 root root 3.3M Oct  6 01:58 myfiles.tar.gz
```

for decompressing tar.gzip use  ` tar -xzvf file.tar.gz`  and `tar -xjvf file.tar.bz2` for bzip2 files.

```
tar command Options:
-c : Creates Archive
-x : Extract the archive
-f : creates archive with given filename
-v : Displays Verbose Information
-t : displays or lists files in archived file
-u : archives and adds to an existing archive file
-A : Concatenates the archive files
-z : zip, tells tar command that create tar file using gzip
-j : filter archive tar file using tbzip
-W : Verify a archive file
-r : update or add file or directory in already existed .tar file
wildcards – Specify patterns in unix tar command
```

note: `-r` option can not append any files to a **compressed file**.  

we usually use mixture of tar options to gain what we want:

| tar command example                   | Description                                                |
| ------------------------------------- | ---------------------------------------------------------- |
| tar tf file.tar                       | list the contents and specify the tarfile                  |
| tar tvf file.tar                      | Viewing the Archive                                        |
| tar tvf file.tar filename             | We can pass a file name as an argument to search a tarfile |
| tar tvf file.tar --wildcards '\*.png' | Using wildcards with tar                                   |
| tar -tvfW file.tar                    | Verify tar  Archive File                                   |
| tar -rvf file.tar newfile.txt         | Add a file to .tar File                                    |
| tar -uvf file.tar newdir              | Add a directory to an existing .tar file                   |

### dd

dd stands for Convert & Copy but why it is not cc? because the name cc is already used by c compiler.  Many people call it  Disk Destroyer because dd doesn't care at all about file system and strickly works with Block Devices!

```
dd [OPERAND]...
dd OPTION
```
dd takes an input file line (ex:/dev/sda) and it writes it to the out put file (ex:/dev/sdb) we specify, bs is block size, how big we want to write blocks and it is not neseccary and can be omitted.

 Backup the entire harddisk:

```
dd if = /dev/sda of = /dev/sdb
```

| dd comand examples                                 | Description                                            |
| -------------------------------------------------- | ------------------------------------------------------ |
| dd if = /dev/sda of = /dev/sdb                     | backup entire Disk                                     |
| dd if=/dev/hda1 of=\~/partition.img                | backup a partition                                     |
| dd if = /dev/hda of = \~/hdadisk.img               | create an image of a Hard Disk                         |
| dd if = hdadisk.img of = /dev/hdb                  | restore using  Hard Disk image                         |
| dd if = /dev/cdrom of = tgsservice.iso bs = 2048   | create CD-Rom backup                                   |
| dd if=/path/to/ubuntu.iso of=/dev/sdb bs=1M        | create bootable usb drive from  image                  |
| dd if=textfile.ebcdic of=textfile.ascii conv=ascii | Convert the data format of a file from EBCDIC to ASCII |

conv can do many thing such as Converting a file to uppercase or visa versa.

### cpio

`cpio` stands for “**C**o**p**y **i**n, copy **o**ut“. It is used for processing the archive files like _.cpio or _.tar. This command can copy files to and from archives.

* **Copy-out Mode:** Copy files named in name-list to the archive` command | cpio -o  > archive`
* **Copy-in Mode:** Extract files from the archive` cpio -i < archive`
* **Copy-pass Mode:** Copy files named in name-list to destination-directory` cpio -p destination-directory < name-list`

```
Policy options:
    -i, –extract: Extract files from an archive and it runs only in copy-in mode.
    -o, –create: Create the archive and it runs only in copy-out mode.
    -p, –pass-through: Run in copy-pass mode.
    -t, –list: Print a table of contents of all the inputs present.
```

| cpio command example           | Description                           |
| ------------------------------ | ------------------------------------- |
| ls /etc \| cpio -ov file.cpio  | create a cpio file                    |
| cpio -iv <  file.cpio          | extract a cpio file                   |
| ls \| cpio -ov -H tar file.tar | create a tar file using cpio          |
| cpio -iv -F file.tar           | extract a tar file using cpio         |
| cpio -it -F < file.tar         | only view tar archive file using cpio |


[https://www.computerhope.com/unix/uls.htm](https://www.computerhope.com/unix/uls.htm)

[https://linuxize.com/post/how-to-list-files-in-linux-using-the-ls-command/](https://linuxize.com/post/how-to-list-files-in-linux-using-the-ls-command/)

[https://www.rapidtables.com/code/linux/ls.html](https://www.rapidtables.com/code/linux/ls.html)

[https://www.tecmint.com/8-pratical-examples-of-linux-touch-command/](https://www.tecmint.com/8-pratical-examples-of-linux-touch-command/)

[https://www.geeksforgeeks.org/touch-command-in-linux-with-examples/](https://www.geeksforgeeks.org/touch-command-in-linux-with-examples/)

[https://linuxize.com/post/linux-touch-command/](https://linuxize.com/post/linux-touch-command/)

[https://www.geeksforgeeks.org/mkdir-command-in-linux-with-examples/](https://www.geeksforgeeks.org/mkdir-command-in-linux-with-examples/)

[https://www.lifewire.com/create-directories-linux-mkdir-command-3991847](https://www.lifewire.com/create-directories-linux-mkdir-command-3991847)

[https://developer.ibm.com/tutorials/l-lpic1-103-3/](https://developer.ibm.com/tutorials/l-lpic1-103-3/)

[https://shapeshed.com/unix-cp/](https://shapeshed.com/unix-cp/)

[https://www.rapidtables.com/code/linux/cp.html](https://www.rapidtables.com/code/linux/cp.html)

[https://www.computerhope.com/unix/ucp.htm](https://www.computerhope.com/unix/ucp.htm)

[https://www.rapidtables.com/code/linux/mv.html](https://www.rapidtables.com/code/linux/mv.html)

[https://www.computerhope.com/unix/umv.htm](https://www.computerhope.com/unix/umv.htm)

[https://www.computerhope.com/unix/urm.htm](https://www.computerhope.com/unix/urm.htm)

[https://www.computerhope.com/unix/urmdir.htm](https://www.computerhope.com/unix/urmdir.htm)

[https://www.linuxnix.com/10-file-globbing-examples-linux-unix/](https://www.linuxnix.com/10-file-globbing-examples-linux-unix/)

[https://linuxhint.com/bash_globbing_tutorial/](https://linuxhint.com/bash_globbing_tutorial/)

[https://www.linode.com/docs/tools-reference/tools/find-files-in-linux-using-the-command-line/](https://www.linode.com/docs/tools-reference/tools/find-files-in-linux-using-the-command-line/)

[https://www.lifewire.com/uses-of-linux-command-find-2201100](https://www.lifewire.com/uses-of-linux-command-find-2201100)

[https://www.digitalocean.com/community/tutorials/how-to-use-find-and-locate-to-search-for-files-on-a-linux-vps](https://www.digitalocean.com/community/tutorials/how-to-use-find-and-locate-to-search-for-files-on-a-linux-vps)

[https://www.geeksforgeeks.org/tar-command-linux-examples/](https://www.geeksforgeeks.org/tar-command-linux-examples/)

[https://itsfoss.com/linux-zip-folder/](https://itsfoss.com/linux-zip-folder/)

[https://www.geeksforgeeks.org/zip-command-in-linux-with-examples/](https://www.geeksforgeeks.org/zip-command-in-linux-with-examples/)

[https://www.geeksforgeeks.org/gzip-command-linux/](https://www.geeksforgeeks.org/gzip-command-linux/)

[https://www.geeksforgeeks.org/bzip2-command-in-linux-with-examples/](https://www.geeksforgeeks.org/bzip2-command-in-linux-with-examples/)

[https://www.tecmint.com/xz-command-examples-in-linux/](https://www.tecmint.com/xz-command-examples-in-linux/)

[https://www.debian.org/releases/wheezy/amd64/apds01.html.en](https://www.debian.org/releases/wheezy/amd64/apds01.html.en)

[https://linuxjourney.com/lesson/device-types](https://linuxjourney.com/lesson/device-types)

[https://www.geeksforgeeks.org/dd-command-linux/](https://www.geeksforgeeks.org/dd-command-linux/)

[https://linoxide.com/linux-command/linux-dd-command-create-1gb-file/](https://linoxide.com/linux-command/linux-dd-command-create-1gb-file/)

[https://www.geeksforgeeks.org/cpio-command-in-linux-with-examples/](https://www.geeksforgeeks.org/cpio-command-in-linux-with-examples/)
