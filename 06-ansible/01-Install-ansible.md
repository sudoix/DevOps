![Steps-to-install-Ansible](../assets/64-Steps-to-install-Ansible-on-Ubuntu-22.04-LTS.png)

## Install ansible

Installing Ansible typically involves a few straightforward steps. Here's a general guide on how to do it:

### For Linux (Ubuntu/Debian)

1. **Update the System:** First, update your system's package index. This ensures you get the latest available version of Ansible.
   ```bash
   sudo apt update
   ```

2. **Install Ansible:** You can install Ansible directly from the default repository.
   ```bash
   sudo apt install ansible
   ```

OR

```bash
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```

### For RedHat/CentOS

1. **Enable EPEL Repository:** Ansible is available in the EPEL repository. Enable it using:
   ```bash
   sudo yum install epel-release
   ```

2. **Install Ansible:**
   ```bash
   sudo yum install ansible
   ```

### Post-Installation

- **Verify Installation:** To check if Ansible has been installed successfully, run:
  ```bash
  ansible --version
  ```

- **Configure:** You may need to set up your inventory file and configure Ansible settings as per your requirements.

Remember, the exact commands may vary slightly depending on your specific OS version and configuration. Always refer to the official Ansible documentation for the most accurate and detailed instructions.


#### check your ansible:

```bash
ansible --version
```


- create a directory
  ```bash
  mkdir -p /root/ansible
  cd /root/ansible
  ```

 - create some directory

  ```bash
  mkdir -p /root/ansible/inventory
  mkdir -p /root/ansible/roles
  mkdir -p /root/ansible/inventory/group_vars
  touch /root/ansible/inventory/hosts.ini
  touch /root/ansible/inventory/group_vars/all.yml
  ```
and the output is:

```
root@ansible:~/ansible# tree
.
├── inventory
│   ├── group_vars
│   │   └── all.yml
│   └── hosts.ini
└── roles
```

your hosts.ini file is in `inventory/hosts.ini` should have the following:

```ini
[all]
test1 ansible_host=37.152.178.226 private_ip=172.16.100.11
test2 ansible_host=185.97.118.58 private_ip=172.16.100.21
test3 ansible_host=37.152.182.216 private_ip=172.16.100.31

[webserver]
test1

[dbserver]
test2
```

and your all.yml file is in `inventory/group_vars/all.yml` should have the following:

```yml
# Docker
docker_gpg_key_url: "https://download.docker.com/linux/ubuntu/gpg"
docker_gpg_key_path: "/etc/apt/keyrings/docker.gpg"
docker_apt_repo: "https://download.docker.com/linux/ubuntu"

```


https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu