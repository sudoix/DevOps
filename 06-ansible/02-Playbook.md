![playbook](../assets/62-playbook.png)

### ansible-playbook

```An Ansible playbook is a YAML file that defines automation, configuration, and orchestration tasks to be performed on specified hosts.```

An Ansible playbook is a blueprint of automation tasks – it is a file where you define what actions you want Ansible to perform. Playbooks are the core components of Ansible for configuration management, application deployment, intra-service orchestration, and practically any IT task. They are written in YAML (Yet Another Markup Language), which is easy to read, write, and understand.

### Key Features of an Ansible Playbook:

1. **Structure**: A playbook is composed of one or more 'plays'. A play is a set of tasks that will be run on a group of managed nodes (hosts).

2. **Tasks**: Each task in a playbook calls an Ansible module. A module is a piece of code for doing a specific job, like installing a package, copying files, executing a command, etc.

3. **Hosts and Groups**: Playbooks start with a definition of which hosts or groups of hosts the playbook should be applied to. This is defined in the inventory file Ansible uses.

4. **Variables**: You can define variables in a playbook to use dynamic values. Variables can be defined in multiple places, including directly in the playbook, in included files, or in the inventory.

5. **Handlers**: These are special tasks that only run when notified by another task. For example, a handler could be used to restart a service when its configuration file changes.

6. **Templates**: Ansible can use Jinja2 templates to create customized files on the managed nodes. This is useful for setting up configuration files that vary between hosts.

7. **Roles**: Complex playbooks can be broken down into 'roles', reusable units of organization that allow you to segment your playbook into easily reusable portions.

8. **Idempotence**: A key property of playbooks is that they are idempotent, meaning running them multiple times in a sequence on the same set of hosts will produce the same outcome without unintended side effects.

### Example of a Simple Playbook

Here is a basic example of an Ansible playbook:

vim file.yaml

```yaml
---
- name: Install nginx on web servers
  hosts: web
  become: yes
  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Ensure nginx is at the latest version
      apt:
        name: nginx
        state: latest

    - name: Write the nginx config file
      copy:
        src: /srv/nginx/nginx.conf
        dest: /etc/nginx/nginx1.conf

    - name: Ensure nginx is running (and enable it at boot)
      service:
        name: nginx
        state: started
        enabled: yes
```

```bash
ansible-playbook file.yaml -i ansible/inventory/hosts.ini
```

In this example:
- The playbook is targeting hosts in the 'webservers' group.
- It contains three tasks: updating Apache to the latest version, writing a configuration file using a template, and ensuring that the Apache service is running.

Playbooks are the foundation of Ansible’s configuration management and multi-machine deployment system, enabling the execution of complex tasks and workflows with simple, human-readable syntax.

Another example

vim file2.yaml 

```bash
---
- name: Copy example.txt to remote hosts
  hosts: all
  tasks:
    - name: Copy file to /tmp directory on remote hosts
      ansible.builtin.copy:
        src: /path/to/local/example.txt
        dest: /tmp/example.txt
        owner: root
        group: root
        mode: '0644'
```

try with `--become` and without `--become` :)

```bash
ansible-playbook file2.yaml -i ansible/inventory/hosts.ini --become
```

**all ansible main module are in https://github.com/ansible/ansible/tree/devel/lib/ansible/modules**


#### use debug modules

vim file5.yaml

```shell
- name: Display a simple debug message
  hosts: web
  tasks:
    - name: Print a message
      debug:
        msg: "Hello, Ansible!"
```

Let's print some variable

```
ansible all -m setup  -i ansible/inventory/hosts.ini
```

The output is:

```
server2 | SUCCESS => {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "10.0.2.15",
            "172.16.0.11"
        ],
        "ansible_all_ipv6_addresses": [
            "fe80::a00:27ff:feed:e087",
            "fe80::a00:27ff:fe26:914c"
        ],
        "ansible_apparmor": {
            "status": "enabled"
.
.
.
.
```

Now let's create new file and use this variable:

vim file5.yaml 

```shell
- name: Display a simple debug message
  hosts: web
  tasks:
    - name: Print a message
      debug:
        var: "ansible_all_ipv4_addresses" 
    - name: Print a message
      debug:
        var: "ansible_cmdline.BOOT_IMAGE"

```

## Register in ansible 

In Ansible, the `register` keyword is used to capture and store the output of a task. This allows you to save the results of a task's execution, including any returned data, into a variable that you can use later in the playbook. The registered variable can then be used for conditionals, loops, debugging, or displaying its content with the `debug` module.

Registering variables becomes incredibly useful when you need to make decisions based on the outcome of a task, manipulate data returned by a module, or simply display information about the execution for logging or debugging purposes.

Here's a basic example to illustrate how `register` works in an Ansible playbook:

```yaml
---
- name: Register Example Playbook
  hosts: web
  gather_facts: no

  tasks:
    - name: Execute a shell command
      shell: echo "Hello, Ansible!"
      register: shell_output

    - name: Display the registered variable
      debug:
        msg: "The command output was: {{ shell_output.stdout }}"
```

```shell
ansible-playbook file4.yaml -i ansible/inventory/hosts.ini -b
```
In this example, the playbook does the following:
- Executes a shell command (`echo "Hello, Ansible!"`) on `localhost`.
- Registers the output of the shell command into the variable `shell_output`.
- Uses the `debug` module to display the standard output (`stdout`) of the shell command, accessed through the registered variable `shell_output.stdout`.

The `register` keyword is a powerful feature in Ansible that enhances the flexibility and decision-making capabilities of your playbooks by allowing you to use the results of tasks dynamically.


More example

```shell

---
- name: Conditional Execution Example
  hosts: web
  gather_facts: no

  tasks:
    - name: Check if a file exists
      command: ls /tmp/file
      register: file_check
      ignore_errors: yes

    - name: Print file exists message
      debug:
        msg: "File exists."
      when: file_check.rc == 0

    - name: Print file does not exist message
      debug:
        msg: "File does not exist."
      when: file_check.rc != 0
```

```
ansible-playbook file4.yaml -i ansible/inventory/hosts.ini -b
```

Getting server time

```shell
---
- name: Setting Facts from Registered Variables Example
  hosts: web
  gather_facts: no

  tasks:
    - name: Get current date
      command: date "+%Y-%m-%d"
      register: current_date

    - name: Set a fact with the current date
      set_fact:
        today: "{{ current_date.stdout }}"

    - name: Display the date
      debug:
        msg: "Today's date is: {{ today }}"

```

```bash
ansible-playbook file4.yaml -i ansible/inventory/hosts.ini -b
```

## condition

```bash
---
- name: Conditional Example Playbook
  hosts: web
  become: yes
  tasks:
    - name: Check if a specific file exists
      stat:
        path: /etc/sample.conf
      register: file_status

    - name: Print message if file exists
      debug:
        msg: "The file /etc/sample.conf exists."
      when: file_status.stat.exists

    - name: Print message if file does not exist
      debug:
        msg: "The file /etc/sample.conf does not exist."
      when: not file_status.stat.exists
```

```
ansible-playbook file4.yaml -i ansible/inventory/hosts.ini -b
```

```bash
---
- name: Conditional Execution Based on Ansible Facts
  hosts: all
  tasks:
    - name: Install package on Debian-based systems
      apt:
        name: vim
        state: present
      when: ansible_facts['os_family'] == "Debian"

    - name: Install package on Red Hat-based systems
      yum:
        name: vim
        state: present
      when: ansible_facts['os_family'] == "RedHat"
```

```
ansible-playbook file4.yaml -i ansible/inventory/hosts.ini -b
```

Check `user` exist

```bash
---
- name: Conditional User Creation
  hosts: all
  become: yes
  tasks:
    - name: Check if user exists
      command: id milad
      register: user_check
      ignore_errors: true

    - name: Create user if not exists
      user:
        name: username
        state: present
      when: user_check.rc != 0
```

```sh
ansible-playbook file4.yaml -i ansible/inventory/hosts.ini -b
```




## Import playbook 

In Ansible, the `import_playbook` directive is used to include or incorporate one playbook within another. This feature allows you to organize your automation into separate, reusable components, which can enhance readability, maintainability, and scalability of your Ansible projects.

### Key Aspects of `import_playbook`:

1. **Modularity and Reusability**: By separating tasks into different playbooks, you can reuse these playbooks in multiple scenarios. This modularity helps in managing complex sets of tasks and reduces repetition.

2. **Organizing Workflows**: `import_playbook` is useful for structuring complex workflows. For example, you might have separate playbooks for setting up a database, configuring a web server, and deploying an application, and you can import all these playbooks into a master playbook to create a full-stack setup.

3. **Syntax**: The `import_playbook` directive is used in a playbook to include another playbook. It is typically used at the top level, not inside a play.

### Example Usage:

Here’s a simple example of how `import_playbook` might be used:

```yaml
# main.yml
- import_playbook: setup.yml
- import_playbook: deploy.yml
- import_playbook: cleanup.yml
```

In this example, `main.yml` is a master playbook that imports three other playbooks: `setup.yml`, `deploy.yml`, and `cleanup.yml`. Each of these playbooks can contain its own set of plays, tasks, and roles relevant to their specific part of the overall process.

### Points to Note:

- **Difference from `include_playbook`**: Ansible also has an `include_playbook` directive. The key difference is that `import_playbook` is static and processed at playbook parsing time, while `include_playbook` is dynamic and processed at runtime. This means `import_playbook` does not support conditional execution based on the runtime state.

- **Static Importing**: Since `import_playbook` is static, the imported playbooks are always imported, and their tasks are subject to the conditions and variables of the importing playbook at parse time.

- **No Looping or Conditional Imports**: You cannot use loops or conditionals on `import_playbook`. For dynamic inclusion, you would use `include_playbook`.

Using `import_playbook` is particularly advantageous in large projects where breaking down complex processes into smaller chunks makes the overall automation easier to understand and manage.

