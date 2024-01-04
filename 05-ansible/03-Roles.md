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








For fun:

https://github.com/haidaraM/ansible-playbook-grapher