## First run 

```
ansible -i inventory/hosts.ini all -m ping
```

```
ansible -i inventory/hosts.ini all -a "df -h"
```

```
ansible -i inventory/hosts.ini all -a "uptime"
```

```
ansible -i inventory/hosts.ini all -m shell -a "cat /etc/os-release"
```

