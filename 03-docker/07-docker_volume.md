

# Understanding Docker Storage

![docker-volume](../assets/66-docker-volume.png)

### Docker can store container data on Host Hard Disk or memory

Managing storage in Docker involves understanding how Docker stores data and how to configure it to best meet your needs, especially in terms of optimizing storage space and ensuring data persistence across container lifecycles. Docker uses volumes, bind mounts, and tmpfs mounts to store and manage data. Here's a guide to managing storage in Docker:

- **Volumes**: Stored in a part of the host filesystem managed by Docker (`/var/lib/docker/volumes/` on Linux). Non-Docker processes should not modify this part of the filesystem. Volumes are the preferred way to persist data in Docker containers because they are completely managed by Docker and are isolated from the core functionality of the host machine.
- **Bind Mounts**: Can be stored anywhere on the host system. They may even be important system files or directories. Bind mounts are dependent on the directory structure of the host system.
- **tmpfs Mounts**: Stored in the host system's memory only, and are never written to the filesystem. They are used for storing sensitive information or for caching purposes where persistence of the data is not required across container restarts.

### 2. Using Volumes for Persistent Storage

To create a volume and attach it to a container, you can use the following commands:

```sh
docker volume create my_volume
docker run -d --name my_container -v my_volume:/path/in/container my_image
```

This creates a volume named `my_volume` and mounts it to `/path/in/container` in the container. Data written to this path is stored in `my_volume`, ensuring data persistence.

### 3. Managing Docker Volumes

You can list, inspect, remove, and prune volumes to manage storage:

- **List Volumes**: `docker volume ls`
- **Inspect Volume**: `docker volume inspect my_volume`
- **Remove Volume**: `docker volume rm my_volume`
- **Prune Unused Volumes**: `docker volume prune` (This removes all unused volumes and is a good way to free up space. Be careful, as this will remove all volumes not used by at least one container.)

### 4. Using Bind Mounts for Specific Use Cases

Bind mounts are useful for specific cases where you need to store data directly on the host or need to share data between the host and containers. To use a bind mount:

```sh
docker run -d --name my_container -v /host/path:/container/path my_image
```

This mounts the host directory `/host/path` to `/container/path` inside the container.

### 5. Monitoring Docker Storage

Monitoring your Docker storage usage is important to avoid running out of space. You can use the Docker Disk Usage command to get a report of the disk usage by containers, images, and volumes:

```sh
docker system df
```

### 6. Cleaning Up

Over time, Docker can accumulate unused objects (images, containers, volumes, and networks) which can take up a significant amount of space. Docker provides commands to clean up these resources:

- **Remove Unused Resources**: `docker system prune` (This removes stopped containers, dangling images, unused networks. Add `-a` to remove all unused images not just dangling ones, and `--volumes` to remove unused volumes.)
- **Remove Unused Images**: `docker image prune -a`
- **Remove Stopped Containers**: `docker container prune`
- **Remove Unused Networks**: `docker network prune`

### 7. Configuring Docker for Different Storage Drivers

Docker supports different storage drivers (such as overlay2, aufs, btrfs, zfs, and others), which can affect performance and efficiency. The default storage driver depends on your platform, but you can configure Docker to use a different storage driver if necessary, typically by editing the Docker daemon configuration file (`/etc/docker/daemon.json` on Linux).



### Common Docker Storage Drivers

- **overlay2**: Recommended as the default storage driver for most use cases, it implements a union filesystem layered over an existing filesystem designed to support Copy-On-Write (CoW). It's efficient and fast, especially for read-heavy operations, and works well on most Linux distributions.
  
- **aufs**: An older storage driver that also uses a union filesystem. It was commonly used in older versions of Docker and Ubuntu. However, it's now deprecated in favor of `overlay2` due to various limitations and compatibility issues.

- **devicemapper**: This driver uses block-level storage and a device mapper to manage layers. It's been traditionally recommended for certain use cases where `overlay2` or `aufs` might not perform well, but it requires more management and has been deprecated in Docker 18.09 and removed in later versions due to complexity and maintenance issues.

- **btrfs**: A CoW filesystem with built-in volume management, `btrfs` is known for its advanced features like snapshots, dynamic inode allocation, and integrated device pooling. It requires a pre-formatted `btrfs` filesystem and is best used in environments where its advanced features can be fully utilized.

- **zfs**: Another advanced filesystem with features similar to `btrfs`, including snapshots, checksums, and volume management. `zfs` is not included with Docker by default and requires a pre-setup `zfs` filesystem. It's ideal for advanced users who need its specific features.

- **vfs**: A simple storage driver with no CoW capabilities, resulting in high disk space usage and slower performance compared to other drivers. It's typically used only for debugging purposes or in situations where no other storage driver is compatible.

### Selecting a Storage Driver

The optimal storage driver for your Docker environment depends on several factors, including the underlying filesystem, performance requirements, and specific features you might need (like snapshotting). Here are some general guidelines for selecting a storage driver:

- **Compatibility and Requirements**: Check your system's compatibility with the storage driver, including the underlying filesystem and kernel support.
- **Performance**: Consider the read/write performance and the efficiency of the storage driver, especially if your applications are I/O intensive.
- **Features**: Advanced features like snapshots and dynamic volume management may be crucial for certain deployments, influencing the choice of `btrfs` or `zfs`.
- **Maintenance and Support**: The ease of maintenance and the level of community or vendor support available for the storage driver can also be important factors.

### Configuring the Storage Driver

You can specify the storage driver Docker should use with the `--storage-driver=<name>` option when starting the Docker daemon, or by configuring the `storage-driver` option in the Docker daemon configuration file (`/etc/docker/daemon.json`):

```json
{
  "storage-driver": "overlay2"
}
```

After changing the storage driver, you'll need to restart the Docker daemon for the changes to take effect. It's also important to note that changing the storage driver will not automatically migrate existing images and containers to the new driver; you would need to manually manage this process.

In conclusion, the choice of Docker storage driver is a critical decision that affects the performance and capabilities of your Docker containers. `overlay2` is generally the recommended default, but specific needs might warrant the use of `btrfs`, `zfs`, or another driver.


## Supported backing file system

The performance and compatibility of Docker storage drivers depend significantly on the backing filesystem. Each storage driver has specific filesystems that it supports and can work efficiently with. Below is an overview of the most commonly used Docker storage drivers and the backing filesystems they support:

### overlay2
- **Supported Filesystems**: OverlayFS is compatible with most Linux filesystems as a backing filesystem, including **ext4 and xfs**, which are the most commonly used. It's recommended to use overlay2 with xfs formatted with `ftype=1` or ext4.
- **Notable**: Overlay2 is the preferred storage driver for Docker on Linux due to its performance and support across different Linux distributions.

### aufs
- **Supported Filesystems**: AUFS was typically used with **ext4 and xfs**, but its support and usage have declined in favor of overlay2. It's mainly relevant for older installations.
- **Notable**: AUFS might not be available in the kernel by default on some Linux distributions, requiring additional installation steps.

### devicemapper
- **Supported Filesystems**: Devicemapper works at the block level rather than the filesystem level, meaning it doesn't depend on a specific filesystem type on the logical volumes it manages. However, for the host filesystem where Docker's metadata and image layers are stored, xfs and ext4 are commonly used.
- **Notable**: Devicemapper in **direct-lvm** mode is considered more production-ready compared to loop-lvm mode, which has significant performance and stability drawbacks.

### btrfs
- **Supported Filesystems**: Btrfs is both a storage driver and a filesystem. It requires that the underlying storage is formatted as **btrfs**.
- **Notable**: Btrfs provides advanced features like snapshots, dynamic inode allocation, and integrated device pooling, making it a powerful but complex choice.

### zfs
- **Supported Filesystems**: ZFS, like btrfs, is both a storage driver and a filesystem. It requires the underlying storage to be formatted with **ZFS**.
- **Notable**: ZFS offers a comprehensive set of features, including efficient snapshots, copy-on-write cloning, continuous integrity checking, and automatic repair.

### vfs
- **Supported Filesystems**: VFS doesn't interact with the filesystem directly for storing data, as it creates a new directory for each layer and container. Therefore, it can work with **any filesystem**.
- **Notable**: Due to its lack of features like copy-on-write, VFS is not recommended for production use due to performance and storage efficiency concerns.

### Selecting the Right Combination
When selecting a storage driver, it's essential to consider not just the driver itself but also the underlying filesystem it will be operating on. The combination of the storage driver and the filesystem affects not only performance but also the features available to your Docker containers.

It's generally recommended to use:
- **overlay2** with **ext4** or **xfs** (with `ftype=1`) for most use cases due to its good balance of performance, compatibility, and ease of use.
- **btrfs** or **zfs** for scenarios requiring their advanced features, acknowledging the additional complexity and specific hardware requirements (e.g., ZFS often benefits from ECC RAM and additional tuning).

Before deploying a storage solution, testing performance under your specific workload conditions is advisable to ensure that the chosen driver and filesystem meet your requirements.


### Docker volume command

Docker volumes are used to persist data generated by and used by Docker containers. Here are examples of common Docker volume commands for creating, listing, inspecting, and removing volumes:

### Create a Volume
To create a new volume, you can use the `docker volume create` command. Optionally, you can specify a name for your volume. If you don't specify a name, Docker generates a random name for you.

```sh
docker volume create my_volume
```

This command creates a new volume named `my_volume`.

### Volume location

Docker volumes are stored on the host filesystem and are managed by Docker. The default location for Docker volumes on a Linux system is within the Docker directory, which is typically located at:

```
/var/lib/docker/volumes/
```

Within this directory, each volume is stored in a subdirectory named after the volume. This subdirectory contains the data for the volume and a JSON configuration file that holds metadata about the volume. For example, if you have a volume named `my_volume`, its data would be stored in:

```
/var/lib/docker/volumes/my_volume/_data
```

The `_data` subdirectory contains the actual data of the volume. This structure allows Docker to isolate and manage volume data separately from container data.


### List Volumes
To list all volumes, use the `docker volume ls` command. This will show you a list of all volumes on your Docker host, including their names and where they are stored.

```sh
docker volume ls
```

### Inspect a Volume
To get more details about a specific volume, such as its mount point or which containers are using it, you can use the `docker volume inspect` command followed by the name of the volume.

```sh
docker volume inspect my_volume
```

This command provides detailed information about `my_volume`, including its mount point, the driver used to create it, and any options that were used.

### Remove a Volume
To remove a volume, you can use the `docker volume rm` command followed by the name of the volume. Note that you cannot remove a volume that is in use by a container.

```sh
docker volume rm my_volume
```

This command removes the volume named `my_volume`. If the volume is in use, Docker returns an error.

### Prune Unused Volumes
Over time, you might accumulate volumes that are no longer used by any containers. To clean up these unused volumes and reclaim space, you can use the `docker volume prune` command.

```sh
docker volume prune
```

This command will prompt you for confirmation before removing all unused volumes. It's a good practice to run this command periodically to keep your system clean.

### Use a Volume with a Container
When you run a container, you can attach a volume to it using the `-v` or `--volume` flag followed by the volume name and the path where it should be mounted inside the container.

```sh
docker run -d -v my_volume:/data my_image
```

This command runs a container from `my_image`, attaching `my_volume` to it. Inside the container, the volume will be accessible at `/data`.


