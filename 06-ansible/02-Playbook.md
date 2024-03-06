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

```yaml
---
- name: Update web servers
  hosts: webservers
  become: yes
  tasks:
    - name: Ensure Apache is at the latest version
      apt:
        name: apache2
        state: latest

    - name: Write the Apache config file
      template:
        src: /srv/httpd.j2
        dest: /etc/apache2/apache2.conf

    - name: Ensure Apache is running (and enable it at boot)
      service:
        name: apache2
        state: started
        enabled: yes
```

In this example:
- The playbook is targeting hosts in the 'webservers' group.
- It contains three tasks: updating Apache to the latest version, writing a configuration file using a template, and ensuring that the Apache service is running.

Playbooks are the foundation of Ansible’s configuration management and multi-machine deployment system, enabling the execution of complex tasks and workflows with simple, human-readable syntax.

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

