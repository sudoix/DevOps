An Ansible template is a feature that lets you generate host files dynamically using templates. It's powered by the Jinja2 templating engine, which allows for the use of variables and expressions to create output text files. This feature is especially useful for creating configuration files that vary between hosts or environments but share a common structure.

Templates in Ansible are used in conjunction with the `ansible.builtin.template` module. This module processes a `.j2` file, which contains the template, and generates a file on the managed node's filesystem based on this template. The `.j2` extension is a convention indicating that the file is a Jinja2 template, though it's not strictly required by Ansible.

### Key Features of Ansible Templates:
- **Dynamic Content Generation:** You can use variables from inventory, facts, playbook variables, and magic variables. This allows for highly customizable outputs.
- **Conditional Statements:** Jinja2 conditionals can be used to include or exclude parts of the template based on specific conditions.
- **Loops:** You can iterate over data structures to generate repetitive sections of your configuration files dynamically.
- **Filters:** Jinja2 filters allow you to manipulate variables' values within the template, such as formatting dates, converting data types, and more.
- **Default Values:** You can provide default values for variables that might not be defined in certain contexts, ensuring that your templates always render correctly.

### Example Usage:
Suppose you have a configuration file for an application that needs to be customized for each deployment environment (e.g., development, staging, production). You can use an Ansible template to dynamically adjust settings like database URLs, server ports, and debug options.


Let's explore three simple yet practical examples of using Ansible templates. These examples will illustrate how to generate configuration files for different scenarios, showcasing the versatility of Ansible templates in infrastructure automation.

### Template: db_backup_cron.j2

```cron
# Ansible managed: Database backup cron job
{{ minute }} {{ hour }} * * * {{ backup_script_path }} > /dev/null 2>&1
```

In this Jinja2 template, you specify variables for the minute and hour at which the backup should run, as well as the path to the backup script. These variables allow you to customize the cron job timing and the script used for each server.

### Ansible Task:

```yaml
- name: Configure database backup cron job
  hosts: all
  vars:
    minute: "0"
    hour: "2"
    backup_script_path: "/usr/local/bin/db_backup.sh"
  tasks:
    - name: copy file
      ansible.builtin.template:
        src: db_backup_cron.j2
        dest: "/etc/cron.d/db_backup"
```

```shell
ansible-playbook file4.yaml  -i ansible/inventory/hosts.ini -b
```


In this playbook task, the `db_backup_cron.j2` template is used to generate a file in `/etc/cron.d/db_backup`, configuring a cron job that runs daily at 2:00 AM. The job executes a script located at `/usr/local/bin/db_backup.sh`.

This simple example illustrates how Ansible templates can be used to manage system cron jobs in a dynamic and flexible way, catering to the specific needs of each server in your infrastructure.


### Dynamic Hosts File

Imagine you want to create a hosts file that maps hostnames to IP addresses for an application environment.

#### Template: hosts.j2

```jinja
# This is an auto-generated hosts file
127.0.0.1 localhost
{% for host in hosts %}
{{ host.ip }} {{ host.name }}
{% endfor %}
```

#### Ansible Task:

```yaml
- name: Configure database backup cron job
  hosts: all
  vars:
    hosts:
      - { name: 'db-server', ip: '10.1.2.3' }
      - { name: 'web-server', ip: '10.1.2.4' }
  tasks:
    - name: Generate hosts file
      ansible.builtin.template:
        src: hosts.j2
        dest: "/etc/hosts"

```
```
ansible-playbook file4.yaml  -i ansible/inventory/hosts.ini -b
```

This setup dynamically generates `/etc/hosts` with IP addresses and hostnames specified in the `hosts` variable.

In Jinja, the templating engine used by Ansible, you can write if statements using the following syntax:

```
{% if condition %}
  # code to execute if condition is true
{% endif %}
```

Here's an example:

```
{% if my_variable == 'foo' %}
  The variable is foo
{% endif %}
```

You can also use the `elif` and `else` statements:

```
{% if my_variable == 'foo' %}
  The variable is foo
{% elif my_variable == 'bar' %}
  The variable is bar
{% else %}
  The variable is not foo or bar
{% endif %}
```

You can use the following operators in if statements:

* `==` (equals)
* `!=` (not equals)
* `>` (greater than)
* `<` (less than)
* `>=` (greater than or equal to)
* `<=` (less than or equal to)
* `in` (contains)
* `not in` (does not contain)
* `is` (identity)
* `is not` (non-identity)

Here are some examples:

```
{% if my_variable > 10 %}
  The variable is greater than 10
{% endif %}

{% if 'foo' in my_variable %}
  The variable contains foo
{% endif %}

{% if my_variable is defined %}
  The variable is defined
{% endif %}
```

You can also use the `and` and `or` operators to combine conditions:

```
{% if my_variable > 10 and my_variable < 20 %}
  The variable is between 10 and 20
{% endif %}

{% if my_variable == 'foo' or my_variable == 'bar' %}
  The variable is foo or bar
{% endif %}
```

In Ansible, you can also use the `when` clause to execute a task only if a certain condition is met:

```
- name: Execute task only if condition is met
  debug:
    msg: "Condition is met"
  when: my_variable == 'foo'
```

This is equivalent to the following Jinja code:

```
{% if my_variable == 'foo' %}
  {{ "Condition is met" }}
{% endif %}
```
