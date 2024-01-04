![inventory_files](../assets/61-inventory.png)

## Inventory Files

An inventory file in Ansible is a crucial component used to define the hosts and groups of hosts upon which commands, modules, and tasks in a playbook operate. The inventory file provides Ansible with details about the nodes it will manage and control. Here’s a detailed look at the inventory file and its format:

### Inventory File Basics

1. **Purpose**: 
   - The inventory file is used to list and group your managed nodes (servers, devices, etc.). It can specify information like IP addresses, domain names, database servers, web servers, etc.

2. **Location**: 
   - By default, Ansible looks for the inventory file at `/etc/ansible/hosts`, but you can specify a different inventory file at the command line using the `-i` option.

3. **Formats**:
   - Ansible supports two main types of inventory file formats: INI and YAML.

### INI Format

- The INI format is the simplest and most straightforward. Here is an example:

### YAML Format

- The YAML format provides more flexibility and is beneficial for complex configurations. Here’s an example of an inventory in YAML format:

- The YAML format allows for more hierarchical and complex structures.

These examples will illustrate a setup with different groups of servers, such as web servers, database servers, and load balancers, along with some variables defined for individual hosts and groups.

### INI Format Example

In this INI format example, we have three groups: `webservers`, `dbservers`, and `loadbalancers`. Each group has a few hosts under it, and some hosts have specific variables like `ansible_port`.

```ini
# Sample Ansible Inventory file in INI format

[firewall:children]
webserver
dbservers

# Web Servers
[webservers]
webserver1.example.com ansible_port=2222
webserver2.example.com

# Database Servers
[dbservers]
db1.example.com db_user=admin db_password=secret
db2.example.com db_user=admin db_password=secret

# Load Balancers
[loadbalancers]
lb.example.com

# Group Variables
[webservers:vars]
http_port=80
maxRequestsPerChild=808

[dbservers:vars]
ansible_user=mydatabaseadmin
```

In this example:
- `webserver1.example.com` and `webserver2.example.com` are part of the `webservers` group.
- `db1.example.com` and `db2.example.com` are part of the `dbservers` group, each with database credentials specified.
- `lb.example.com` is part of the `loadbalancers` group.
- `webservers` and `dbservers` groups have group-specific variables defined under `[group_name:vars]`.

### YAML Format Example

Now, let's create a similar setup in YAML format, which allows for more structured and hierarchical definitions.

```yaml
# Sample Ansible Inventory file in YAML format

all:
  children:
    webservers:
      hosts:
        webserver1.example.com:
          ansible_port: 2222
        webserver2.example.com:
      vars:
        http_port: 80
        maxRequestsPerChild: 808

    dbservers:
      hosts:
        db1.example.com:
          db_user: admin
          db_password: secret
        db2.example.com:
          db_user: admin
          db_password: secret
      vars:
        ansible_user: mydatabaseadmin

    loadbalancers:
      hosts:
        lb.example.com:
```

In this YAML example:
- The structure is similar to the INI format, but YAML allows for a more hierarchical organization.
- Host-specific variables are defined directly under each host.
- Group-specific variables are defined under a `vars` section within each group.

Both these examples demonstrate how to organize hosts into groups and define both host-specific and group-specific variables. These formats give you flexibility in how you manage and categorize the hosts in your Ansible inventory.

