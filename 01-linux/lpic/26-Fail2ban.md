# Fail2ban

Fail2ban is a tool that can help you to protect your server from brute force attacks.

Install Fail2ban:

```bash
sudo apt update
sudo apt install fail2ban
```

After installing Fail2ban, you can start the service:

```bash
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
```

Now you can start using Fail2ban to protect your server from brute force attacks.

## Protect ssh with Fail2ban

You can use Fail2ban to protect your ssh server from brute force attacks.

First, you need to create a Fail2ban configuration file:

```bash
sudo vim /etc/fail2ban/jail.local
```

Add the following lines to the file:

```bash
[sshd]
enabled = true
port    = 22
logpath = /var/log/auth.log
maxretry = 3
bantime = 600
findtime = 600

# optional
ignoreip = 127.0.0.1/8 ::1 192.168.0.100 192.168.1.0/24
```
Then restart the Fail2ban service:

```bash
sudo systemctl restart fail2ban
```

Now, you can start using Fail2ban to protect your ssh server from brute force attacks.

### test ssh with fail2ban

lets attack the ssh server:

```bash
for i in {1..6}; do ssh invaliduser@192.168.122.100; done
```

On other terminal check the logs:

```bash
sudo tail -f /var/log/fail2ban.log
```

Check the ban IP:

```bash
sudo fail2ban-client status sshd
```

Unban the IP:

```bash
sudo fail2ban-client set ssh unbanip 38.0.101.76
```

other commands:

```bash
sudo fail2ban-client get sshd bantime
sudo fail2ban-client get sshd maxretry
sudo fail2ban-client get sshd actions
sudo fail2ban-client get sshd findtime
sudo fail2ban-client get sshd ignoreip
```
