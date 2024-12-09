![inventory_files](../.gitbook/assets/61-inventory.png)

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

[all]
# the first node is the first master node (k8s-test-master1)

k8s-test-master1 ansible_host=37.152.178.226 private_ip=172.16.100.11
k8s-test-master2 ansible_host=185.97.118.58 private_ip=172.16.100.21
k8s-test-master3 ansible_host=37.152.182.216 private_ip=172.16.100.31

k8s-test-worker1 ansible_host=37.32.21.250 private_ip=172.16.100.41
; k8s-test-worker2 ansible_host=172.24.96.6 private_ip=172.16.100.22
; k8s-test-worker3 ansible_host=172.24.96.7 private_ip=172.16.100.23

lb1-test ansible_host=185.206.92.135 private_ip=172.16.100.81
lb2-test ansible_host=185.206.92.220 private_ip=172.16.100.91

[k8s]
k8s-test-master1
k8s-test-master2
k8s-test-master3
k8s-test-worker1
; k8s-test-worker2
; k8s-test-worker3

[k8s_masters]
k8s-test-master1
k8s-test-master2
k8s-test-master3

[k8s_workers]
k8s-test-worker1
# k8s-test-worker2
# k8s-test-worker3


[lb]
lb1-test
lb2-test


[all:vars]
ansible_user=milad
ansible_port=22
ansible_python_interpreter = "/usr/bin/python3"
domain="sudoix.com"
apiserver_url="espenu.sudoix.com"
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
        1921.168.1.100:
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

### Inventory Parameters

Ansible inventory parameters are used to define the hosts and groups of hosts upon which commands, modules, and tasks in a playbook operate. The inventory file can be in one of many formats, including INI and YAML. It's not just about specifying hosts; inventory parameters can include variables that provide additional details about the hosts, which can be used in playbooks for more dynamic and flexible automation scripts.

Here's an overview of some key inventory parameters and how they're used:

### Basic Structure

- **Hosts**: Individual machines identified by their addresses (IP or domain).
- **Groups**: Collections of hosts that share common attributes and can be targeted together.

### Standard Parameters

- **ansible_host**: Specifies the IP address of the host.
- **ansible_port**: Specifies the port on which to connect to the host.
- **ansible_user**: The user to log in as.
- **ansible_password**: SSH password (although key-based authentication is recommended).
- **ansible_connection**: Type of connection to use (e.g., ssh, localhost, winrm).
- **ansible_ssh_private_key_file**: Path to the SSH private key file.
- **ansible_python_interpreter**: Specifies the path to the Python interpreter on the remote host.


For example

```ini
[webservers]
webserver1.example.com ansible_host=237.84.2.178 ansible_user=ubuntu ansible_ssh_password=changeme ansible_connection=ssh ansible_port=2222
```

For listing all hosts

```ansible
ansible --list-hosts all -i /etc/ansible/hosts
```

For use ansible module

```ansible
ansible -m ping -i /etc/ansible/hosts all
```

The output is

```
ansible -m ping -i ansible/inventory/hosts.ini all
The authenticity of host '172.16.0.11 (172.16.0.11)' can't be established.
ED25519 key fingerprint is SHA256:if5fYKjbSlSFbe+ZQS5/PEfUcvpxx+zgBKhdxv6c3J0.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
server2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}

```

#### command module

```ansible
ansible -m command -a "uptime" -i /etc/ansible/hosts all
```
The output is:

```
server2 | CHANGED | rc=0 >>
 09:17:55 up 5 min,  1 user,  load average: 0.18, 0.10, 0.03
```

Another example

```ansible
ansible -m command -a "iptables -nvL" -i ansible/inventory/hosts.ini all
```

The output is: (need root permission)

```
server2 | FAILED | rc=4 >>
iptables v1.8.7 (nf_tables): Could not fetch rule set generation id: Permission denied (you must be root)non-zero return code
```

For fixing permission error

```ansible
ansible -m command -a "sudo iptables -nvL" -i ansible/inventory/hosts.ini all


[WARNING]: Consider using 'become', 'become_method', and 'become_user' rather than running sudo
server2 | CHANGED | rc=0 >>
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination 

```


