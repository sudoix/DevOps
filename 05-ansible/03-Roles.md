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






For fun:

https://github.com/haidaraM/ansible-playbook-grapher