![30](../../assets/30-NFS.jpg)

# nfs-server-configuration-ubuntu.md

NFS (Network File System) is a distributed file system protocol that allows clients to access files and directories on remote servers over a network. It enables file sharing between machines in a network, allowing multiple users to access and modify files as if they were on their local system.

To configure NFS (Network File System) on Ubuntu Linux, you can follow these steps:

#### install nfs-kernel-server

1. Install `nfs-kernel-server` package:

```
sudo apt update
sudo apt install nfs-kernel-server nfs-common
```

2. Create a directory to be shared:

```
mkdir /mnt/nfs
chown nobody:nogroup /mnt/nfs
chmod 777 /mnt/nfs
```

3. Add the directory to the `/etc/exports` file:

Add the following line to the file to specify the directory to be shared and the allowed client IP addresses (replace client_ip with the actual IP address or subnet):

```
echo "/mnt/nfs *(rw,sync,no_root_squash)" >> /etc/exports
```
or
```echo "/mnt/nfs       192.168.1.0/24(rw,sync,no_subtree_check)" >> /etc/exports```

4. Restart the `nfs-kernel-server` service:

```
exportfs -r
exportfs -a
sudo systemctl restart nfs-kernel-server
```

### client side

To configure the NFS client on Ubuntu Linux, you can follow these steps:

1. Install `nfs-common` package:

```
sudo apt update
sudo apt install nfs-common
```

2. Create a directory to be shared:

```
mkdir /mnt/nfs
chown nobody:nogroup /mnt/nfs
chmod 777 /mnt/nfs
```

3. Mount the NFS share from the server:

```
mount 192.168.1.180:/mnt/nfs /mnt/nfs
```

4. Add the directory to the `/etc/fstab` file:

```
echo "192.168.1.180:/mnt/nfs /mnt/nfs nfs defaults 0 0" >> /etc/fstab
```

