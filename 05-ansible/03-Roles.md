![roles](../assets/63-roles.png)

## Ansible Roles

Ansible roles are sets of related Ansible tasks, variables, files, and other resources organized in a predefined directory structure, allowing for the reusability and modularization of automation tasks. Roles simplify playbook management by breaking down complex playbooks into smaller, reusable components that can be easily shared and maintained.

In Ansible, a role is a way of organizing tasks and related content so that they can be easily shared. A role has a defined directory structure, each with a specific purpose and functionality. Here's a breakdown of the standard directory structure within an Ansible role:

1. **`roles/` (Top-Level Directory)**:
   - This is the main directory where all roles are stored. Each role has its own directory within this folder.

2. **`rolename/` (Role Directory)**:
   - Each role has its own directory within the `roles/` directory, named after the role (e.g., `rolename`).

Within each `rolename/` directory, the structure typically includes the following subdirectories:

3. **`tasks/`**:
   - Contains the main list of tasks to be executed by the role, usually defined in a file named `main.yml`.

4. **`handlers/`**:
   - Contains handlers, which are tasks that only run when notified by other tasks. The handlers are defined in a `main.yml` file within this directory.

5. **`defaults/`**:
   - Contains default variables for the role. Variables in `defaults/main.yml` have the lowest precedence and can be easily overridden by other variables.

6. **`vars/`**:
   - Contains other variables for the role, typically with higher precedence than those in `defaults/`. These are defined in `vars/main.yml`.

7. **`files/`**:
   - Contains files that can be deployed via this role. These might include scripts, configuration files, etc.

8. **`templates/`**:
   - Contains templates which can use Ansible’s templating system to generate dynamic content. They often use the Jinja2 templating language.

9. **`meta/`**:
   - Contains metadata for the role, like author information, license, and dependencies on other roles. This is defined in `meta/main.yml`.

10. **`library/`** (Optional):
    - If the role has custom modules, they are placed here.

11. **`module_utils/`** (Optional):
    - Contains code that can be used by custom modules in the `library/`.

12. **`lookup_plugins/`** (Optional):
    - Custom lookup plugins can be placed here.

13. **`filter_plugins/`** (Optional):
    - Contains custom filter plugins for processing data within templates.

This directory structure is a convention that Ansible uses to automatically load certain types of files from certain folders. The role's structure makes it easier to reuse code and share roles between different projects or users. Roles can be created manually by creating these directories and files, or they can be created using the `ansible-galaxy` command, which sets up the basic structure for you.

## Host_vars

In Ansible, `host_vars` are variables that are specific to individual hosts (managed nodes). These variables are used to tailor configuration and behavior for each host. The `host_vars` directory allows you to define variables at the host level, overriding other variable sources such as group variables or defaults.

### Key Points About `host_vars`:

1. **Location and Structure**:
   - `host_vars` is a directory typically located at the same level as your inventory file or playbook.
   - Inside this directory, you create files named after each host as defined in your inventory. For example, for a host named `webserver1.example.com`, you would create a file `host_vars/webserver1.example.com.yml` or `host_vars/webserver1.example.com`.

2. **Variable Definition**:
   - In these files, you define variables in YAML format. These variables are then applied only to the respective host.
   - For instance, you might set specific network configurations, application settings, or any other parameters that are unique to a host.

3. **Usage**:
   - During playbook execution, Ansible automatically loads variables from these files for the corresponding hosts. 
   - This feature is particularly useful for setting host-specific configurations without cluttering the main playbook or inventory file.

4. **Precedence**:
   - Variables defined in `host_vars` have a higher precedence than most other variable sources, such as group variables or variables defined in playbooks. This means they can be used to override other variables.

### Example:

Suppose you have an inventory file with a host named `webserver1.example.com`. To define specific variables for this host, you would:

1. Create a file named `webserver1.example.com.yml` (or `.json`) inside the `host_vars` directory.
2. Define variables in this file:

   ```yaml
   # host_vars/webserver1.example.com.yml
   http_port: 8080
   max_clients: 200
   ```

When running playbooks, Ansible will automatically apply these variables to tasks running on `webserver1.example.com`.

### Best Practices:

- Use `host_vars` for settings that are unique to individual hosts.
- Keep variable names descriptive and consistent across host and group variables for clarity.
- Manage `host_vars` files in source control to track changes and maintain consistency across environments.

In summary, `host_vars` in Ansible provide a convenient and powerful way to manage host-specific configuration, contributing to the flexibility and scalability of Ansible for infrastructure automation.

## group_vars

In Ansible, `group_vars` are variables that are specific to groups of hosts (managed nodes), and they allow you to set configuration parameters and values for these groups collectively. These variables are particularly useful for configuring settings that are common across a group of hosts, thereby reducing repetition and enhancing the organization of your Ansible playbooks.

### Key Points About `group_vars`:

1. **Location and Structure**:
   - The `group_vars` directory is usually located at the same level as your inventory file or playbook.
   - Inside this directory, you create files named after each group as defined in your inventory. For example, for a group named `webservers`, you would create a file `group_vars/webservers.yml` or `group_vars/webservers`.

2. **Variable Definition**:
   - In these files, you define variables in YAML format. These variables are then applied to all hosts within the respective group.
   - This can include configurations like server settings, application parameters, environment-specific variables, etc.

3. **Usage**:
   - During playbook execution, Ansible automatically loads variables from these files for the corresponding groups. 
   - This allows for a streamlined approach to managing configurations across multiple hosts that share common characteristics.

4. **Precedence**:
   - Variables defined in `group_vars` have a higher precedence than global variables (like those set in the inventory or playbook), but lower than `host_vars`. They can be used to override global defaults but can be overridden by host-specific variables.

### Example:

Suppose you have an inventory file with a group named `dbservers`. To define specific variables for this group, you would:

1. Create a file named `dbservers.yml` inside the `group_vars` directory.
2. Define variables in this file:

   ```yaml
   # group_vars/dbservers.yml
   db_port: 5432
   db_user: "dbadmin"
   ```

When running playbooks, Ansible will automatically apply these variables to tasks running on hosts in the `dbservers` group.

### Best Practices:

- Use `group_vars` for settings that are common to a group of hosts.
- Keep your inventory organized into meaningful groups and leverage `group_vars` for efficient configuration management.
- Manage `group_vars` files in source control to maintain consistency and track changes.

In summary, `group_vars` in Ansible are a vital feature for managing configurations across groups of hosts, simplifying playbook complexity and enhancing scalability and maintainability in your automation tasks.

## files directory in ansible role

In the context of Ansible roles, the `files` directory is a special subdirectory used for storing static files which can be deployed to managed nodes (hosts) via the role. These files are usually referenced in tasks within the role and are copied as-is to the target hosts.

### Purpose and Use:

1. **Static Files Storage**: The `files` directory is intended for files that do not need modification before being transferred to the target hosts. This contrasts with the `templates` directory, which is intended for files that should be processed through Ansible’s templating system (usually Jinja2) before deployment.

2. **Referencing in Tasks**: Files in this directory are typically referenced in tasks using modules like `copy` or `unarchive`. For example, if you have a script or a binary file that needs to be copied to a host, you would place it in the `files` directory of the role and then reference it in a task.

### Directory Structure Example:

In an Ansible role, the directory structure might look like this:

```
roles/
  my_role/
    files/
      example_script.sh
      sample_binary
    tasks/
      main.yml
    ...
```

### Example Task Using Files Directory:

Here's an example of how you might use a file from the `files` directory in a task within a role:

```yaml
# roles/my_role/tasks/main.yml
- name: Copy a script to the target host
  ansible.builtin.copy:
    src: example_script.sh
    dest: /usr/local/bin/example_script.sh
    mode: '0755'
```

In this example, `example_script.sh` is stored in `roles/my_role/files/` and is copied to `/usr/local/bin/` on the target host with the specified mode (permissions).

### Best Practices:

- Use the `files` directory for any static content that needs to be transferred to the hosts.
- Keep the files organized and named clearly to indicate their purpose.
- For files that require dynamic content (like configuration files with variables), use the `templates` directory instead.

The `files` directory in Ansible roles is a simple yet powerful way to manage static files that need to be part of your automation tasks.


## templates directory in ansible role

In Ansible roles, the `templates` directory is a designated subdirectory used for storing template files. These templates are typically processed through Ansible’s templating engine (usually Jinja2) to generate files dynamically based on variables and conditions. This feature allows for the creation of customized configuration files for each managed node (host).

### Key Characteristics of the `templates` Directory:

1. **Dynamic File Generation**:
   - Templates are used to create files that vary from host to host. This variation is achieved by embedding Ansible variables or Jinja2 expressions in the template files.

2. **Jinja2 Templating Language**:
   - Ansible uses Jinja2, a powerful templating language. Jinja2 allows for the inclusion of variables, loops, conditional statements, and filters within templates, enabling dynamic content generation.

3. **Usage in Playbooks and Roles**:
   - In a role, templates are referenced in tasks using modules like `template`. These tasks specify both the source template (in the `templates` directory) and the destination path on the target host.

### Directory Structure Example:

In an Ansible role, the directory structure might include a `templates` subdirectory like this:

```
roles/
  my_role/
    templates/
      my_config_file.conf.j2
      another_config.xml.j2
    tasks/
      main.yml
    ...
```

### Example Task Using `templates` Directory:

Here's an example of how a template might be used in a role:

```yaml
# roles/my_role/tasks/main.yml
- name: Configure application
  ansible.builtin.template:
    src: my_config_file.conf.j2
    dest: /etc/myapp/my_config_file.conf
```

In this example, `my_config_file.conf.j2` is a Jinja2 template stored in `roles/my_role/templates/`. When the task is run, Ansible processes this template, fills in the variables, and creates `my_config_file.conf` on the target host at `/etc/myapp/`.

### Best Practices:

- Use the `templates` directory for configuration files or scripts that need to be dynamically generated from a template.
- Keep your templates organized and clearly named.
- Utilize Jinja2 features such as variables, loops, and filters to create flexible and dynamic content.

The `templates` directory in Ansible roles is essential for managing dynamic content that needs to be tailored for individual hosts or groups, thus enabling more flexible and scalable automation solutions.

#### example of template files

Sure, I'll provide you with a sample Jinja2 template for a configuration file, which might be named `my_config_file.conf.j2`. This template will demonstrate the use of variables, loops, and conditional statements, common features in Jinja2 templates used in Ansible.

### Sample `my_config_file.conf.j2` Template

```jinja
# Sample Configuration File Generated by Ansible
# my_config_file.conf.j2

# Basic variable substitution
server_name: {{ server_name_variable }}

# Conditional statement
{% if enable_feature %}
enable_feature: true
{% else %}
enable_feature: false
{% endif %}

# Loop through a list of items
{% for item in item_list %}
item_name: {{ item.name }}
item_value: {{ item.value }}
{% endfor %}

# Default filter usage
database_host: {{ database_host_variable | default('localhost') }}

# Complex conditional
{% if users and users|length > 0 %}
# User configurations
{% for user in users %}
user_name: {{ user.name }}
user_role: {{ user.role }}
{% endfor %}
{% else %}
# No user configurations available
{% endif %}
```

### Explanation of the Template:

- **Variable Substitution**: `{{ server_name_variable }}` is a placeholder for a variable that Ansible will replace with its actual value when the template is processed.

- **Conditional Statement**: The `{% if %}`...`{% else %}`...`{% endif %}` blocks are used to conditionally include parts of the file based on the value of `enable_feature`.

- **Loops**: The `{% for item in item_list %}` loop iterates over a list of items, allowing you to create repeated sections of the file for each item in the list.

- **Default Filter**: The `{{ database_host_variable | default('localhost') }}` uses the `default` Jinja2 filter to provide a default value if `database_host_variable` is not defined.

- **Complex Conditional with Loop**: The final section demonstrates a more complex conditional statement combined with a loop. If the `users` list is present and non-empty, it iterates over each user, otherwise, it notes the absence of user configurations.

When Ansible processes this template, it will replace the variables and evaluate the loops and conditionals based on the context provided in your playbook, resulting in a customized configuration file tailored to each managed node.


## handler in ansible role

In Ansible, "handlers" are special kinds of tasks that run at the end of a play if they are notified by another task. Handlers are used for tasks that need to be triggered by changes in the state of a system, such as restarting a service after a configuration change. They help to optimize playbook runs by performing actions only when necessary.

### Key Characteristics of Handlers:

1. **Triggered by a Notification**: 
   - Handlers are executed when they are notified by a regular task. A task notifies a handler using the `notify` directive, and the name of the handler to be notified.

2. **Idempotence**: 
   - Like regular tasks, handlers are idempotent. This means they will only take action if needed. For instance, a handler to restart a service will only do so if the service's configuration has changed.

3. **Run Once**: 
   - If multiple tasks notify the same handler, the handler will run only once at the end of the play. This is useful for scenarios where multiple changes require the same service to be restarted, but you want to avoid restarting multiple times.

4. **Defining Handlers**: 
   - Handlers are defined similarly to tasks, typically in a `handlers` section in a playbook or inside a role.

### Example Usage:

Here's an example to illustrate how handlers are used in Ansible:

```yaml
---
- name: Example playbook
  hosts: webservers
  tasks:
    - name: Install apache2
      apt:
        name: apache2
        state: present
      notify: restart apache2

    - name: Deploy configuration file
      template:
        src: templates/apache2.conf.j2
        dest: /etc/apache2/apache2.conf
      notify: restart apache2

  handlers:
    - name: restart apache2
      service:
        name: apache2
        state: restarted
```

In this example:
- The playbook defines two tasks: one to install Apache and another to deploy a configuration file.
- Each task has a `notify` directive that points to a handler named `restart apache2`.
- The handler `restart apache2` is defined at the end of the playbook. If any of the tasks notify this handler, it will restart the Apache service.
- If both tasks notify the handler, Apache will still only be restarted once at the end of the play.

Handlers are a powerful feature in Ansible, enabling efficient and effective automation by performing actions only when necessary and avoiding redundant operations.




For fun:

https://github.com/haidaraM/ansible-playbook-grapher