# Ansible Ad-Hoc Commands

An Ansible ad-hoc command is a single-line command that performs a task on one or more managed nodes/targets. It is useful for tasks that you might not repeatedly do, so you don't necessarily need to write a full playbook for them. Ad-hoc commands are great for tasks like quickly rebooting servers, copying files to multiple hosts, or just gathering facts about your hosts without having to write a full playbook. 

The general syntax for an Ansible ad-hoc command is:

```
ansible [pattern] -m [module] -a "[module options]"
```

- `[pattern]` specifies the hosts or group of hosts from your inventory on which you want the command to run.
- `-m [module]` specifies the module to use. Ansible modules are reusable scripts that Ansible runs on your behalf. If you don't specify a module, Ansible uses the `command` module by default.
- `-a "[module options]"` specifies the arguments to pass to the module. The arguments depend on the module.

For example, to ping all hosts in your inventory, you could use:

```
ansible all -m ping -i /etc/ansible/hosts
```

This command uses the `ping` module, which is a special module that checks the connection and responsiveness of the managed hosts.

Another example, to copy a file to several hosts in a group named 'webservers', you might use:

```
ansible all -m copy -a "src=/home/milad/file2 dest=/home/milad/ansible_file" -i ansible/inventory/hosts.ini 
```

The output is:

```
server2 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "checksum": "da39a3ee5e6b4b0d3255bfef95601890afd80709",
    "dest": "/home/milad/ansible_file",
    "gid": 1000,
    "group": "milad",
    "md5sum": "d41d8cd98f00b204e9800998ecf8427e",
    "mode": "0664",
    "owner": "milad",
    "size": 0,
    "src": "/home/milad/.ansible/tmp/ansible-tmp-1711013491.4965808-2684-73927509146836/source",
    "state": "file",
    "uid": 1000
}
```


This uses the `copy` module to copy files from the local machine to the remote hosts specified in the 'webservers' group.


### Method ans become an ad-hoc command

```ansible
ansible -m command -a "uptime" -i /etc/ansible/hosts all --become --become-user root --become-method sudo
```

# Other modules

### Command modules

The `command` module in Ansible is used to execute commands on a remote node or group of nodes. It's one of the simplest modules available in Ansible, and it does not require the command to be fully qualified with its path (though it can be), nor does it require any arguments. However, it does not support shell variables since it is not processed through the shell, so for operations that require a shell (like using shell variables or redirections), you should use the `shell` module instead.

Here's a basic example of using the `command` module:

```shell
ansible all -m command -a "/usr/bin/uptime"
```

In this example:
- `all` specifies that the command should run on all hosts in your inventory.
- `-m command` tells Ansible to use the `command` module.
- `-a "/usr/bin/uptime"` specifies the command line to run. The `uptime` command displays how long the system has been running, along with the load averages.

The output will look something like this, assuming you have two hosts, `host1` and `host2`, in your inventory:

```plaintext
host1 | CHANGED | rc=0 >>
 12:05:17 up 5 days,  2:42,  1 user,  load average: 0.00, 0.01, 0.05

host2 | CHANGED | rc=0 >>
 12:05:20 up 12 days,  8:37,  2 users,  load average: 0.03, 0.10, 0.07
```

Each host's response includes the status (e.g., `CHANGED`), return code (`rc=0` indicating success), and the output of the `uptime` command.

The `command` module is straightforward but powerful, allowing you to run virtually any command on a remote server without the need for a full playbook. However, keep in mind that since it doesn't process commands through a shell, it won't interpret shell-specific syntax like variable expansion, redirection (`>`, `>>`), or piping (`|`). For such tasks, the `shell` module would be more appropriate.


Certainly! Here are more examples of using Ansible ad-hoc commands with the `command` module for various tasks across your managed nodes. Remember, the `command` module executes a command on a remote node without using the shell, which means shell-specific features are not available. For shell-specific features, use the `shell` module instead.

### Checking Disk Usage

To check the disk usage of the root filesystem on all your managed hosts:

```shell
ansible all -m command -a "df -h /" -i ansible/inventory/hosts.ini
```

### Listing Directory Contents

To list the contents of the `/var/log` directory on a group of hosts named 'servers':

```shell
ansible all -m command -a "ls -lah /var/log" -i ansible/inventory/hosts.ini
```

### Checking System Memory Usage

To display the memory usage on a specific host (`host123`):

```shell
ansible all -m command -a "free -m" -i ansible/inventory/hosts.ini
```

### Restarting a Service

To restart the nginx service on a group of web server hosts named 'webservers'. Note that for service management, it's better to use the `service` module, but this serves as a demonstration of the `command` module:

```shell
ansible all -m command -a "systemctl restart nginx" -i ansible/inventory/hosts.ini
```

The output is:

```
server2 | FAILED | rc=1 >>
Failed to restart nginx.service: Connection timed out
See system logs and 'systemctl status nginx.service' for details.non-zero return code
```

you should use sudo in your command :))

```
ansible all -m command -a "sudo systemctl restart nginx" -i ansible/inventory/hosts.ini
[WARNING]: Consider using 'become', 'become_method', and 'become_user' rather
than running sudo
server2 | CHANGED | rc=0 >>
```

### Checking Python Version

To check the Python version on all hosts:

```shell
ansible all -m command -a "python3 --version"
```

### Running a Script on Remote Nodes

If you have a script on the remote nodes that you'd like to execute, you can do so with the `command` module. Assuming the script is located at `/home/user/scripts/check_status.sh` on the remote hosts:

```shell
ansible all -m command -a "/home/user/scripts/check_status.sh" -i ansible/inventory/hosts.ini
```

### Copying Files Between Directories on Remote Hosts

To copy a file from one directory to another on remote hosts (assuming user permissions allow this operation):

```shell
ansible all -m command -a "cp /path/to/source/file.txt /path/to/destination/file.txt"
```

```shell
ansible all -b -m command -a "sed -i 's|http://nl.archive.ubuntu.com/ubuntu|http://archive.ubuntu.com/ubuntu|g' /etc/apt/sources.list" -i ansible/inventory/hosts.ini
```

Each of these examples illustrates the versatility of the `command` module for performing a wide variety of tasks across your managed infrastructure. However, for tasks that involve more complex interactions with the system or environment (like handling shell variables, redirections, or conditions), consider using the `shell` module or writing a playbook for more readability and maintainability.


## apt module

The `apt` module in Ansible is used for managing packages on Debian, Ubuntu, and other Debian-based systems. This module allows you to install, upgrade, and remove packages using the APT package management system.

Here's a simple example of using the `apt` module to ensure a package is installed on all your Debian or Ubuntu hosts in your inventory. In this case, let's install `nginx`.

```shell
ansible all -m apt -a "name=nginx state=present" --become -i ansible/inventory/hosts.ini
```

Breaking down the command:
- `all` targets all hosts in your inventory.
- `-m apt` specifies the use of the `apt` module.
- `-a "name=nginx state=present"` defines the arguments for the module. `name=nginx` specifies the package to manage, and `state=present` ensures that the package is installed.
- `--become` is used to indicate that the command should be executed with privilege escalation (sudo by default), which is typically required for installing packages.

This command will check if `nginx` is installed on all targeted hosts, and if it's not, Ansible will install it.

### Additional Examples with the `apt` Module

#### Updating All Packages

To update all packages to their latest versions:

```shell
ansible all -m apt -a "upgrade=yes update_cache=yes" --become -i ansible/inventory/hosts.ini
```

This command first updates the package cache (`update_cache=yes`) and then upgrades all installed packages to the latest versions (`upgrade=yes`).

#### Installing a Specific Version of a Package

If you need to install a specific version of a package, you can specify the version like so:

```shell
ansible all -m apt -a "name=nginx=1.14.2-1+ubuntu18.04.1+deb.sury.org+1 state=present" --become
```

Replace `1.14.2-1+ubuntu18.04.1+deb.sury.org+1` with the actual version you want to install.

#### Removing a Package

To remove a package without purging its configuration files:

```shell
ansible all -m apt -a "name=nginx state=absent" --become -i ansible/inventory/hosts.ini
```

And if you want to completely purge a package along with its configuration files:

```shell
ansible all -m apt -a "name=nginx state=absent purge=yes" --become -i ansible/inventory/hosts.ini
```

These examples demonstrate the flexibility of the `apt` module for package management on Debian-based systems using Ansible. It's a powerful way to ensure your systems are configured with the exact packages and versions you require.

### shell modules

The `shell` module in Ansible is used to execute shell commands on remote hosts. It's more powerful than the `command` module because it processes the commands through a shell (`/bin/sh` by default), allowing you to use shell features like variables, redirection, pipes, and conditionals. Here's a simple example of using the `shell` module to create a backup of a directory by copying it to a new location on all hosts in the 'servers' group.

### Example: Creating a Directory Backup

The task below uses the `shell` module to create a timestamped backup of the `/etc/nginx` directory on remote servers. The backup directory's name includes the current date and time to ensure uniqueness.

```yaml
ansible servers -m shell -a "cp -r /etc/nginx /backup/nginx-$(date +'%Y%m%d-%H%M%S')" --become
```

Breaking down the command:

- `servers`: Specifies the group of hosts the command should run on.
- `-m shell`: Tells Ansible to use the `shell` module.
- `-a`: Accompanies the arguments passed to the module. Here, `"cp -r /etc/nginx /backup/nginx-$(date +'%Y%m%d-%H%M%S')"` is the shell command to execute. It copies the `/etc/nginx` directory recursively (`-r`) to a new directory under `/backup`. The destination directory name is `nginx-` followed by a timestamp, generated by `$(date +'%Y%m%d-%H%M%S')`, which includes the year, month, day, hour, minute, and second of the command's execution.
- `--become`: This option is used to indicate that the command should be executed with privilege escalation (sudo), which is often necessary for writing to directories like `/backup` or modifying anything under `/etc`.

### Example 1: Checking Used Disk Space and Logging It

This command checks the used disk space on the root partition and appends the information to a log file. It's useful for keeping track of disk usage over time.

```yaml
ansible all -m shell -a "df -h / | awk 'NR==2{print $5}' >> /var/log/disk_usage.log" --become
```

- This command appends the percentage of disk space used on the root partition (`/`) to `/var/log/disk_usage.log`.
- It uses `awk 'NR==2{print $5}'` to extract the percentage used from the `df -h /` command output.

### Example 2: Creating a Compressed Archive of a Directory

This example creates a gzipped tar archive of the `/var/log` directory, demonstrating the use of shell redirection and pipelines.

```yaml
ansible all -m shell -a "tar czf /tmp/log_backup_$(date +'%Y%m%d').tar.gz /var/log" --become
```

- The command dynamically names the backup file with the current date to avoid overwriting previous backups.
- It uses the `date +'%Y%m%d'` command to generate the date string.

### Example 3: Finding and Deleting Files Older Than 30 Days

This command finds files in the `/tmp` directory older than 30 days and deletes them. It's a common maintenance task to prevent the `/tmp` directory from filling up.

```yaml
ansible all -m shell -a "find /tmp -type f -mtime +30 -delete" --become
```

- `find /tmp -type f -mtime +30 -delete` searches for and directly deletes files older than 30 days in `/tmp`.

### Example 4: Checking if a Service is Running and Restarting if Not

This command checks if the nginx service is running and restarts it if it's not. This is an example of using conditional logic in a shell command.

```yaml
ansible web -m shell -a "systemctl is-active --quiet nginx || systemctl restart nginx" --become
```

- `systemctl is-active --quiet nginx || systemctl restart nginx` uses conditional logic to restart nginx only if it's not already active.

### Example 5: Exporting Database to a File

This command dumps a MySQL database to a file, showing how to handle commands that involve sensitive information, like database passwords. (In production, use Ansible vault to encrypt sensitive data.)

```yaml
ansible db -m shell -a "mysqldump -u user -p'password' mydatabase > /tmp/mydatabase.sql" --become
```

- `mysqldump -u user -p'password' mydatabase > /tmp/mydatabase.sql` exports the `mydatabase` database to a file. Replace `user`, `password`, and `mydatabase` with your actual database username, password, and database name.

These examples showcase the flexibility and power of the `shell` module in Ansible for performing complex tasks on remote hosts that require shell processing. Always ensure to handle sensitive data securely and be aware of the security implications of the commands you're running with elevated privileges.


## raw module

The `raw` module in Ansible is used to execute commands directly on remote hosts without requiring Python on the remote system. This module is particularly useful in scenarios where Python is not installed on the target machine, or you're dealing with a very minimal installation that might not even have a python interpreter. Since the `raw` module does not require Python, it's a powerful tool for initial bootstrapping or for managing devices that have limited capabilities.

### Basic Usage

The syntax for using the `raw` module is similar to other modules but doesn't get processed through any shell or command interpreter on the target system. Here's a simple example:

```shell
ansible all -m raw -a "uptime"
```

This command would connect to all hosts in your inventory and execute the `uptime` command, returning the system uptime information for each.

### Example 1: Checking the OS Version on a Fresh System

```shell
ansible new_servers -m raw -a "cat /etc/os-release"
```

In this example, `new_servers` is a group in your Ansible inventory that refers to newly provisioned servers where Python might not be installed yet. The `raw` module sends the `cat /etc/os-release` command to each server to check the OS version.

### Example 2: Installing Python on a Debian/Ubuntu System

```shell
ansible new_servers -m raw -a "apt-get update && apt-get install -y python-simplejson"
```

This command uses `apt-get` to update the package lists and install `python-simplejson`, which is a minimal dependency required for Ansible to work on older Debian or Ubuntu systems. Modern systems should instead install `python` or `python3`.

### Example 3: Rebooting a Server

```shell
ansible all -m raw -a "reboot now"
```

This command sends a simple `reboot now` command to all hosts, causing them to reboot immediately. Since it uses the `raw` module, it does not wait for a command response or require Python on the remote end.

### Example 4: Setting a Static IP Address

```shell
ansible network_device -m raw -a "ifconfig eth0 192.168.1.100 netmask 255.255.255.0 up"
```

This example configures a network device's `eth0` interface with a static IP address. It's especially useful for initial network configuration on devices or systems with limited capabilities.

### Note

The `raw` module is powerful but should be used sparingly and cautiously since it bypasses many of the safeguards and conveniences provided by other Ansible modules. It doesn't support idempotency, error checking, or complex arguments as structured modules do. Once Python is installed, or if you're managing a device that supports it, switching to more specific Ansible modules is recommended for most tasks.


The `command`, `shell`, and `raw` modules in Ansible each serve the purpose of executing commands on remote hosts, but they do so in different ways and have different use cases. Understanding the differences between them can help you choose the right tool for the job when writing your Ansible tasks.

### command Module

- **Use Case:** Executes a command on a remote node without using a shell for interpretation. This is suitable for commands that do not require shell-specific features (like redirection, pipelines, or variable expansion).
- **Features:** 
  - Does not process commands through a shell; therefore, it does not support shell-specific syntax.
  - It is safer and more secure than the `shell` module because it is not affected by the shell's environment.
- **Example:** Running `ls` to list directory contents directly, without shell processing.

### shell Module

- **Use Case:** Executes shell commands on remote nodes. This is the module to use when you need to leverage shell capabilities like pipelines, redirection, conditionals, and variable expansion.
- **Features:** 
  - Processes commands through a shell (`/bin/sh` by default), allowing the use of shell features.
  - More flexible but potentially less secure than the `command` module due to the shell's involvement, which could lead to shell injection vulnerabilities if input is not properly sanitized.
- **Example:** Using `grep` to filter results or using shell redirection to write command output to a file on the remote host.

### raw Module

- **Use Case:** Primarily used to run commands on remote systems without Python installed, making it ideal for initial bootstrapping of Python on new machines or managing devices with very minimal environments.
- **Features:** 
  - Does not require Python on the remote host.
  - Sends commands directly over SSH without requiring a shell, but the commands themselves may be executed in a shell environment by the SSH daemon on the remote host.
  - Lacks many features of other modules, such as error handling, and does not support Ansible's conditional execution, loops, or other advanced features.
- **Example:** Installing Python on a fresh system where it's not already present.

### Key Differences

- **Python Dependency:** `command` and `shell` require Python on the remote host, while `raw` does not.
- **Shell Processing:** `command` does not involve shell processing, `shell` does, and `raw` is essentially agnostic, sending commands directly but possibly being executed in a shell context by the remote SSH service.
- **Use Cases:** Use `command` for straightforward command execution without the need for shell features, `shell` when shell capabilities are necessary, and `raw` mainly for bootstrapping or dealing with systems where Python is not available.

In summary, your choice among `command`, `shell`, and `raw` depends on the specific requirements of the task at hand, such as the need for shell features, the environment of the remote host, and security considerations.

#### Let's take a look at some examples of using these modules:

run it and see the output

```shell
ansible all -m command -a "echo hello >> /home/milad/hello.txt" -i ansible/inventory/hosts.ini

ansible all -m command -a "ls" -i ansible/inventory/hosts.ini 

```

`>`, `>>`, `&`, `env variable`, `;` and `|` not working in command module

Let's run with `shell` module

```bash
ansible all -m shell -a "echo hello >> /home/milad/hello.txt" -i ansible/inventory/hosts.ini
ansible all -m shell -a "ls" -i ansible/inventory/hosts.ini 
```

and row modules --> no need python

```bash
ansible all -m raw -a "ls"
```

### Setup module

The `setup` module in Ansible is used to gather facts about remote hosts. This module is automatically called by playbooks to populate variables about remote systems, but it can also be used directly in ad-hoc commands to fetch system information. This information can include operating system, network interfaces, disk usage, and much more, depending on the system's environment.

Using the `setup` module, you can tailor tasks in your playbooks based on specific facts about a host. For instance, you might execute certain tasks only on machines with a particular operating system version or with a certain amount of memory.

### Ad-hoc Command Example with the `setup` Module

To gather all facts from all your hosts in the inventory, you would use:

```shell
ansible all -m setup -i ansible/inventory/hosts.ini
```

This command tells Ansible to target all hosts (`all`) and use the `setup` module (`-m setup`) without any additional options, which results in gathering all available facts about each host.


### Gathering Custom Facts

Ansible can also gather "custom facts" placed in `/etc/ansible/facts.d` on the managed hosts. These facts can be in INI, JSON, or executable format that outputs JSON. If you want to include these custom facts in your fact gathering, just running the setup module without specifying a filter will include them:

```shell
ansible all -m setup
```

Custom facts can be useful for capturing domain-specific information that Ansible does not gather by default.

### Example: Checking a Specific Fact

If you're interested in a specific piece of information, such as the distribution of the operating system, you could filter for it explicitly:

```shell
ansible all -m setup -a 'filter=ansible_distribution' -i ansible/inventory/hosts.ini
```

This command will return the `ansible_distribution` fact for each host, which tells you the operating system distribution name (e.g., Ubuntu, CentOS).

```shell
ansible all -m setup -a 'filter=ansible_memory*' -i ansible/inventory/hosts.ini
```

```shell
ansible all -m setup -a 'filter=ansible_processor*' -i ansible/inventory/hosts.ini
```

```shell
ansible all -m setup -a 'filter=ansible_mounts' -i ansible/inventory/hosts.ini
```





The `setup` module is a powerful tool for conditional execution in playbooks, ensuring your tasks are only run on hosts that meet specific criteria based on their gathered facts.



## ansible-doc

`ansible-doc` is a command-line utility provided by Ansible that allows users to see documentation on Ansible modules, plugins, and their usage directly from the command line. This tool is incredibly useful for understanding the options, functionalities, and requirements of the various modules and plugins available in Ansible without having to look up the information in online documentation.

By using `ansible-doc`, you can quickly access:
- A description of what the module or plugin does.
- The parameters that the module or plugin accepts, including details about required parameters, default values, and parameter types.
- Examples of how to use the module or plugin in your Ansible playbooks or ad-hoc commands.
- Notes about the module, which might include version compatibility, dependencies, or other important information.

### Basic Usage

The basic syntax of the `ansible-doc` command is:

```sh
ansible-doc [options] <module/plugin_name>
```

### Examples

**View Documentation for a Module**

To view the documentation for a specific module, such as the `copy` module, you would run:

```sh
ansible-doc copy
```

This command will display information about the `copy` module, including how to use it, the parameters it accepts, and example tasks.

**List All Modules**

To list all available modules, you can use the `-l` option:

```sh
ansible-doc -l
```

**View Documentation for a Plugin**

You can also view documentation for other types of plugins, for example, a lookup plugin like `file`:

```sh
ansible-doc -t lookup file
```

In this example, `-t lookup` specifies the type of the plugin (`lookup`), and `file` is the name of the plugin.

**Search for Modules or Plugins**

To search for modules or plugins containing a specific keyword in their documentation, you can use the `-s` option. For example, to search for all modules related to `file` operations:

```sh
ansible-doc -s file
```

**Viewing Examples**

Some `ansible-doc` versions allow viewing examples directly via a command-line option (check your version's documentation as this feature might vary).

### Note

- The availability and behavior of `ansible-doc` might vary slightly depending on the Ansible version you are using.
- The tool is part of the standard Ansible installation, so there's no need for additional software to use it.

`ansible-doc` is an essential tool for Ansible users, from beginners getting to know available modules to advanced users looking up specific details or refreshing their memory on module usage.

Ad-hoc commands are a powerful part of Ansible for quick operations across your infrastructure, but for more complex or repeated tasks, writing playbooks is recommended.