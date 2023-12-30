![docker-container](../assets/59-docker-container.png)

## Docker container

A Docker container is a lightweight, standalone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and configuration files. Docker containers are built from Docker images, which are templates that define the container's contents and behaviors.

#### Docker Run == docker pull + create + start

The `docker run` command is versatile and can be used in many different ways depending on your needs. Here are several examples to illustrate various use cases:

1. **Running a Container Interactively**:
   ```bash
   docker run -it ubuntu /bin/bash
   ```
   This command runs an Ubuntu container and gives you an interactive shell (`/bin/bash`) inside it. The `-it` option makes the container start in interactive mode with a tty.

2. **Running a Container with Environment Variables**:
   ```bash
   docker run -e MY_VAR=myvalue my-image
   ```
   Here, the `-e` flag is used to set an environment variable `MY_VAR` with the value `myvalue` in the container created from `my-image`.

3. **Running a Container with a Volume**:
   ```bash
   docker run -v /my/host/folder:/my/container/folder my-image
   ```
   This mounts the host directory `/my/host/folder` to `/my/container/folder` in the container. Changes to this directory are reflected in both the container and the host.

4. **Running a Container on a Specific Network**:
   ```bash
   docker run --network=my-network my-image
   ```
   This runs a container on a user-defined network `my-network`, allowing it to communicate with other containers on the same network.

5. **Running a Container with a Specific Hostname**:
   ```bash
   docker run --hostname=my-container my-image
   ```
   Sets the hostname of the container to `my-container`.

6. **Running a Container with Custom CPU and Memory Constraints**:
   ```bash
   docker run --cpus=1.5 --memory=512m my-image
   ```
   Limits the container to 1.5 CPUs and 512 megabytes of RAM.

7. **Running a Container and Removing it After Exit**:
   ```bash
   docker run --rm my-image
   ```
   The `--rm` flag automatically removes the container file system upon exit.

8. **Running a Container in Detached Mode with a Name**:
   ```bash
   docker run -d --name my-background-container my-image
   ```
   Runs the container in detached mode (in the background) and names it `my-background-container`.

9. **Running a Container and Publishing Multiple Ports**:
   ```bash
   docker run -p 80:80 -p 443:443 nginx
   ```
   Maps both port 80 and 443 from the container to the same ports on the Docker host, useful for running a web server like Nginx.

10. **Running a Container with a Read-Only File System**:
    ```bash
    docker run --read-only my-image
    ```
    Starts a container where the file system is read-only, which can improve security by preventing changes to system files.

11. **Running a Container with a name**:

```bash
docker run --name my-container my-image
```

12. **Running a Container with -d -i -t**:

```bash
docker run -dit --name nginx2 --expose 443 --expose 445 nginx:latest
```

These examples demonstrate how `docker run` can be used in various scenarios. Depending on your specific use case, you might combine several of these options in a single command. Remember, each Docker image might have its specific requirements and supported options, so always refer to the documentation for the images you are using.


### Docker rm

The `docker rm` command is used to remove one or more Docker containers. It's important to note that only stopped containers can be removed. If you try to remove a running container, you will encounter an error unless you use the `-f` (force) flag, which will stop and then remove the container.

Here's a basic example of the `docker rm` command:

```bash
docker rm my-container
```

In this example, `my-container` is the name or ID of the container you want to remove. You can find the name or ID of your containers by using the `docker ps -a` command, which lists all containers (running and stopped).

Here are a few more examples with different options:

1. **Removing Multiple Containers**:
   ```bash
   docker rm container1 container2 container3
   ```
   This command will remove containers named `container1`, `container2`, and `container3`.

2. **Force Removing a Running Container**:
   ```bash
   docker rm -f running-container
   ```
   The `-f` or `--force` option will stop a running container and then remove it.

3. **Remove a Container Upon Exit**:
   You can also set a container to be automatically removed when it stops by using the `--rm` flag with `docker run`, like so:
   ```bash
   docker run --rm my-image
   ```
   In this case, the container will be removed automatically when it exits. This is useful for keeping your system clean if you frequently create and dispose of temporary containers.

##### Here are more examples of using the `docker rm` command to remove Docker containers:

1. **Remove a Container by ID**:
   ```bash
   docker rm 1c2d3e4f5g
   ```
   In this case, `1c2d3e4f5g` is the ID of the container. Docker IDs are unique identifiers assigned to each container.

2. **Remove Containers Using a Wildcard**:
   ```bash
   docker rm $(docker ps -aq --filter "name=my-container*")
   ```
   This command removes all containers whose names start with `my-container`. The `docker ps -aq` command lists all containers (with the `-a` flag), and the `--filter` option filters them by name. The `-q` flag returns only the container IDs, which are then passed to `docker rm`.

3. **Remove All Stopped Containers**:
   ```bash
   docker rm $(docker ps -aq -f status=exited)
   ```
   This command removes all containers that have a status of "exited". The `-f` flag filters the listed containers by their status.

4. **Remove Containers Created Before a Certain Container**:
   ```bash
   docker rm $(docker ps -aq --before container_id)
   ```
   Here, `container_id` is the ID of a specific container. This command removes all containers that were created before the specified container.

5. **Remove Containers that Exited More Than an Hour Ago**:
   ```bash
   docker rm $(docker ps -aq --filter "status=exited" --filter "since=1h")
   ```
   This command will remove all containers that have been in an exited state for more than an hour.

6. **Remove Containers with a Specific Label**:
   ```bash
   docker rm $(docker ps -aq --filter "label=my-label")
   ```
   Removes all containers that have a specific label assigned to them.

7. **Remove the Most Recently Created Container**:
   ```bash
   docker rm $(docker ps -aq --latest)
   ```
   The `--latest` flag will target the most recently created container.

8. **Remove Containers Except One**:
   ```bash
   docker rm $(docker ps -aq --filter "id!=container_id")
   ```
   This will remove all containers except the one with the specified `container_id`.

Remember, the `docker rm` command only removes containers, not images. If you want to remove images, you would use the `docker rmi` command instead. Also, it's always a good practice to ensure you really want to remove these containers, as this action is irreversible and any unsaved data in the containers will be lost.

### Expose Port in Docker run command

Exposing ports in Docker is a crucial aspect of container configuration, especially when you want to enable communication with the container from the outside world or between containers.

The `-p` flag in the `docker run` command is used to map a network port from the container to your host. This is crucial for accessing applications running inside containers from outside the Docker host. Here are more examples to illustrate different uses of the `-p` flag for exposing ports:

1. **Mapping a Single Port**:
   ```bash
   docker run -p 5000:5000 my-image
   ```
   This maps port 5000 inside the container to port 5000 on the Docker host. Useful for applications like web servers that listen on a single port.

2. **Mapping Multiple Ports**:
   ```bash
   docker run -p 8000:80 -p 2222:22 my-image
   ```
   Here, port 80 inside the container is mapped to port 8000 on the host, and port 22 inside the container is mapped to port 2222 on the host. This setup might be used for a container running a web server and an SSH server.

3. **Mapping a Range of Ports**:
   ```bash
   docker run -p 7000-7005:7000-7005 my-image
   ```
   This maps a range of ports (7000 to 7005) from the container to the same range on the Docker host. Useful for applications that use multiple consecutive ports.

4. **Dynamic Host Port Mapping**:
   ```bash
   docker run -p 80 my-image
   ```
   Docker automatically assigns a free port on the host to port 80 in the container. You can check which port was assigned by running `docker ps` and looking at the "PORTS" column.

5. **Bind to a Specific Host Interface**:
   ```bash
   docker run -p 192.168.1.100:80:80 my-image
   ```
   This binds port 80 in the container to port 80 on a specific interface (`192.168.1.100`) of the Docker host, rather than all interfaces.

6. **Mapping UDP Ports**:
   ```bash
   docker run -p 12345:12345/udp my-image
   ```
   Maps UDP port 12345 inside the container to UDP port 12345 on the Docker host.

7. **Mapping Different Internal and External Ports**:
   ```bash
   docker run -p 8080:80 my-image
   ```
   This maps port 80 inside the container to port 8080 on the Docker host. This is commonly used when the standard ports (like 80 for HTTP) are already in use on the host.

8. **Bind Multiple Ports to the Same Internal Port**:
   ```bash
   docker run -p 8080:80 -p 8081:80 my-image
   ```
   Here, both port 8080 and 8081 on the Docker host are mapped to port 80 in the container. This can be useful for load balancing scenarios.

Remember, when you map ports, the Docker host's firewall settings may affect accessibility. Ensure that the host's firewall allows traffic on the ports you've exposed. Also, Docker port mapping is designed for development and testing. For production deployments, consider using Docker Swarm or Kubernetes, which offer more advanced networking and orchestration features.

#### Docker prune

Certainly! The `docker prune` command comes in handy for efficiently cleaning up unused or dangling Docker objects. Here are examples for each type of prune command, demonstrating their usage and functionality:

```bash
yes | docker container prune
```

### 1. Container Pruning

**Remove all stopped containers**:
```bash
docker container prune
```
This will remove all containers that have been stopped. Docker will ask for confirmation before deletion unless you add the `-f` or `--force` flag.

### 2. Image Pruning

**Remove dangling images** (those that are not tagged and not referenced by any container):
```bash
docker image prune
```

**Remove all unused images (both dangling and unreferenced by any container)**:
```bash
docker image prune -a
```
This is a more aggressive cleanup that will free up more space but may remove images that you intended to use later.

### 3. Volume Pruning

**Remove all unused volumes**:
```bash
docker volume prune
```
This command cleans up volumes not used by at least one container. Be cautious with this command as it may lead to data loss if you accidentally remove volumes containing important data.

### 4. Network Pruning

**Remove all unused networks**:
```bash
docker network prune
```
This will remove all networks not used by at least one container, helping to clean up potentially complex networking setups.

### 5. System-wide Pruning

**Remove stopped containers, dangling images, and unused networks**:
```bash
docker system prune
```

**Remove all unused objects (containers, images, volumes, and networks)**:
```bash
docker system prune -a --volumes
```
This is the most comprehensive cleanup. It removes stopped containers, all unused images (not just dangling ones), all unused volumes, and networks. It's very effective for freeing up space but should be used with caution to avoid unintentional data loss.

### Additional Options

**Force Pruning without Confirmation Prompt**:
Add `-f` or `--force` to any of these commands to bypass the confirmation prompt. This is useful for scripting or automated cleanup tasks:
```bash
docker system prune -af
```

**Filtering**:
You can use filters with prune commands to target specific objects based on criteria like until (time-based), label, etc.:
```bash
docker container prune --filter "until=24h"
```
This command will remove all containers stopped more than 24 hours ago.

Using these commands periodically can help manage disk space and keep your Docker environment clean, especially in development scenarios where frequent changes are made. However, always exercise caution and ensure that you are not removing data or resources that you still need.


#### Docker container inspect

The `docker container inspect` command is used to get detailed information about a Docker container in JSON format. It's particularly useful for retrieving low-level information about the container's configuration, state, network settings, and more. Here are some examples:

1. **Basic Inspect Command**:
   To inspect a container named `mycontainer`, you would use:
   ```bash
   docker container inspect mycontainer
   ```
   This command will output a JSON object with a wealth of information about `mycontainer`.

2. **Filtering for Specific Data with `--format`**:
   If you're only interested in specific information, such as the container's IP address, you can use the `--format` option. For example:
   ```bash
   docker container inspect --format '{{ .NetworkSettings.IPAddress }}' mycontainer
   ```
   This command retrieves only the IP address of `mycontainer`.

3. **Inspecting Multiple Containers**:
   You can inspect multiple containers at once by listing their names or IDs:
   ```bash
   docker container inspect container1 container2 container3
   ```
   This will return detailed information for `container1`, `container2`, and `container3`.

4. **Getting Mounted Volumes Information**:
   To see information about mounted volumes in a container:
   ```bash
   docker container inspect --format '{{ json .Mounts }}' mycontainer
   ```
   This command displays details of all mounts in `mycontainer` in JSON format.

5. **Retrieving Environment Variables**:
   If you need to see the environment variables set in a container:
   ```bash
   docker container inspect --format '{{ range .Config.Env }}{{ println . }}{{ end }}' mycontainer
   ```
   This will list all the environment variables configured in `mycontainer`.

6. **Checking Container’s Health Status**:
   For containers with health checks, you can find out the health status:
   ```bash
   docker container inspect --format '{{ .State.Health.Status }}' mycontainer
   ```
   This returns the health status of `mycontainer`, like `healthy` or `unhealthy`.

7. **Extracting Container Creation Time**:
   To find out when a container was created:
   ```bash
   docker container inspect --format '{{ .Created }}' mycontainer
   ```
   This command shows the creation timestamp of `mycontainer`.

8. **Finding Out the Restart Count**:
   To see how many times a container has been restarted:
   ```bash
   docker container inspect --format '{{ .RestartCount }}' mycontainer
   ```
   This will give you the number of times `mycontainer` has been restarted.

Each of these examples demonstrates how `docker container inspect` can be a powerful tool for getting detailed insights into your Docker containers. Remember to replace `mycontainer`, `container1`, `container2`, etc., with your actual container names or IDs as needed for your specific use cases.

```bash
docker ps -a
```

#### Docker exec

The `docker exec` command is used to run a new command in a running container. It's a powerful tool in Docker's command-line interface, allowing users to interact with or modify containers that are already running. Here's a basic overview of how it works:

- **Basic Syntax**: The basic syntax of the `docker exec` command is `docker exec [OPTIONS] CONTAINER COMMAND [ARG...]`. This means that after specifying the command, you provide options (if needed), the container ID or name where you want to run the command, followed by the command you wish to execute and any arguments it requires.

- **Common Use Cases**:
  - **Running an interactive shell**: You can start an interactive shell inside a running container, like bash or sh, using a command like `docker exec -it <container_name> /bin/bash`. The `-it` flag attaches your terminal input to the shell inside the container.
  - **Executing scripts or commands**: If you want to run a script or a specific command inside a container, you can do so without needing to enter the container's shell. For example, `docker exec <container_name> python script.py` would run a Python script inside the container.
  - **Checking container health**: You might want to check the status of processes in a container, for which you could use something like `docker exec <container_name> ps aux` to view running processes.

- **Options**:
  - `-d`, `--detach`: Run the command in the background.
  - `-i`, `--interactive`: Keep STDIN open even if not attached.
  - `-t`, `--tty`: Allocate a pseudo-TTY, useful for interactive applications.
  - `--env`: Set environment variables.

Remember, any changes you make to a container using `docker exec` are not persistent if the container is deleted. To make persistent changes, you usually need to update the Dockerfile or the image from which the container is created.

```bash
docker exec -it CONTAINER_ID /bin/bash
```

Certainly! Here are more examples of how to use the `docker exec` command in various scenarios:

1. **Running a Shell Command Inside a Container**: 
   Suppose you want to list the contents of the root directory in a running container named `mycontainer`. You would use:
   ```bash
   docker exec mycontainer ls /
   ```
   This command executes `ls /` inside `mycontainer`, listing the contents of its root directory.

2. **Accessing an Interactive Shell**:
   If you need to access a bash shell inside a container named `webapp`:
   ```bash
   docker exec -it webapp /bin/bash
   ```
   This opens an interactive bash shell inside the `webapp` container.

3. **Creating a New File Inside a Container**:
   To create a new text file inside a container:
   ```bash
   docker exec mycontainer touch /tmp/newfile.txt
   ```
   This command uses `touch` to create a new file named `newfile.txt` in the `/tmp` directory of `mycontainer`.

4. **Running a Python Script**:
   If you have a Python script in your container and want to execute it:
   ```bash
   docker exec mycontainer python /path/to/script.py
   ```
   Replace `/path/to/script.py` with the actual path to your Python script inside the container.

5. **Checking Memory Usage**:
   To check the memory usage inside a container:
   ```bash
   docker exec mycontainer free -m
   ```
   This executes the `free -m` command, which shows memory usage in megabytes.

6. **Setting Environment Variables in the Executed Command**:
   You can set environment variables for the command you're running:
   ```bash
   docker exec -e VAR1=value1 mycontainer some-command
   ```
   This sets the environment variable `VAR1` to `value1` before executing `some-command` in `mycontainer`.

7. **Running a Command as a Specific User**:
   You can specify the user that the command should be run as:
   ```bash
   docker exec -u username mycontainer whoami
   ```
   This runs the `whoami` command inside `mycontainer` as `username`.

Each of these examples demonstrates the versatility of `docker exec` in managing and interacting with Docker containers. Remember to replace `mycontainer`, `webapp`, and other placeholders with your actual container names or commands as per your use case.


#### Docker cp

The `docker cp` command is used to copy files or directories between a Docker container and the local filesystem. This command is particularly useful for transferring data to and from containers. Here's a basic overview of how it works:

- **Basic Syntax**:
  The syntax of the `docker cp` command is either `docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH` or `docker cp [OPTIONS] SRC_PATH CONTAINER:DEST_PATH`. This means you can copy files from the local filesystem to a container or from a container to the local filesystem.

- **Copying from Container to Host**:
  To copy a file or directory from a container to the host, you specify the container name followed by a colon and the path to the file or directory inside the container, and then the path where you want to copy it on your host.
  Example: 
  ```bash
  docker cp mycontainer:/path/to/file/in/container /path/on/host
  ```
  This command copies a file from `mycontainer` to a specified path on the host.

- **Copying from Host to Container**:
  To copy a file or directory from your host to a container, you specify the path on the host and then the container name followed by a colon and the path inside the container where you want to copy it.
  Example:
  ```bash
  docker cp /path/on/host mycontainer:/path/to/destination/in/container
  ```
  This command copies a file from the host to a specified path inside `mycontainer`.

- **Options**:
  - `-a`, `--archive`: Archive mode (copies all file attributes).
  - `-L`, `--follow-link`: Always follow symbol link in SRC_PATH.

- **Important Considerations**:
  - The `docker cp` command does not require the container to be running. You can copy files to and from stopped containers as well.
  - When copying folders, Docker copies all subdirectories and files recursively.
  - File ownership and permissions can be affected by the host system's user and group IDs.

The `docker cp` command is very handy for quick file transfers, but for more complex or frequent file synchronization needs, it's usually better to use Docker volumes.

#### Docker stats

The `docker stats` command displays a live stream of resource usage statistics for running containers. It provides information like CPU usage, memory usage, network I/O, and block I/O. Here are some examples of how you can use `docker stats`:

1. **View Stats for All Running Containers**:
   The simplest way to use `docker stats` is without any additional parameters. This will display the stats for all currently running containers.
   ```bash
   docker stats
   ```
   This command shows a live updating table of CPU, memory, network, and block I/O statistics for each running container.

2. **View Stats for Specific Containers**:
   You can specify the names or IDs of specific containers to view their stats only.
   ```bash
   docker stats container1 container2 container3
   ```
   Replace `container1`, `container2`, and `container3` with the actual names or IDs of the containers you want to inspect. This command will show the stats only for these specified containers.

3. **View Stats Without Streaming**:
   If you want to get the stats at a single point in time without the live stream, you can use the `--no-stream` option.
   ```bash
   docker stats --no-stream
   ```
   This command provides a snapshot of the current stats for all running containers, then exits.

4. **Formatting Output**:
   You can format the output of `docker stats` using the `--format` option. For example, to display only the container ID and memory usage:
   ```bash
   docker stats --format "table {{.Container}}\t{{.MemUsage}}"
   ```
   This will show a table with two columns, one for the container ID and the other for memory usage.

5. **View Stats with Truncated IDs**:
   By default, `docker stats` shows the full container IDs. You can truncate these IDs for a more compact view.
   ```bash
   docker stats --no-trunc
   ```
   This command will display the stats with truncated container IDs.

6. **Displaying Stats for Stopped Containers**:
   While `docker stats` typically shows information for running containers, you can view the last known stats of a stopped container by specifying its name or ID.
   ```bash
   docker stats stopped_container
   ```
   Replace `stopped_container` with the name or ID of the stopped container. Note that this will only show the last recorded statistics before the container stopped.

Each of these examples demonstrates different ways to use `docker stats` to monitor the resource usage of Docker containers. This tool is particularly useful for managing system resources, troubleshooting, and performance analysis in a Dockerized environment.

#### Docker container --dns

The `docker container` command itself doesn't have a `--dns` option, but you can use the `--dns` flag with `docker run` to set custom DNS servers for a new container. This option is useful when you want to specify which DNS servers the container should use for DNS resolution. Here are some examples:

1. **Running a Container with a Single Custom DNS Server**:
   If you want to start a new container and use a specific DNS server, such as `8.8.8.8` (Google's DNS server), you can do so like this:
   ```bash
   docker run --dns 8.8.8.8 -d --name mycontainer myimage
   ```
   This command starts a new container named `mycontainer` from the image `myimage` and sets its DNS server to `8.8.8.8`.

2. **Using Multiple DNS Servers**:
   You can specify multiple DNS servers by adding multiple `--dns` flags:
   ```bash
   docker run --dns 8.8.8.8 --dns 8.8.4.4 -d --name mycontainer myimage
   ```
   This will configure the container to use both `8.8.8.8` and `8.8.4.4` as its DNS servers.

3. **Setting DNS Options**:
   In addition to setting the DNS server, you can also set DNS options with the `--dns-opt` flag. For example:
   ```bash
   docker run --dns 8.8.8.8 --dns-opt timeout:3 --dns-opt attempts:5 -d --name mycontainer myimage
   ```
   This sets custom DNS options like timeout and attempts along with the DNS server.

4. **Specifying a DNS Search Domain**:
   You can use the `--dns-search` flag to set a DNS search domain for the container:
   ```bash
   docker run --dns 8.8.8.8 --dns-search mydomain.com -d --name mycontainer myimage
   ```
   This configures the container to use `mydomain.com` as the search domain in DNS queries.

#### Docker container --env

The `--env` (or `-e` for short) flag with Docker commands, such as `docker run`, is used to set environment variables in a new Docker container. This is useful for passing configuration settings or other runtime variables to the container. Here's how it's typically used:

1. **Setting a Single Environment Variable**:
   To set one environment variable, use the `--env` or `-e` flag followed by the variable and its value. For example:
   ```bash
   docker run -e MY_VAR=myvalue --name mycontainer myimage
   ```
   This command will start a container named `mycontainer` from the `myimage` image, with an environment variable `MY_VAR` set to `myvalue`.

2. **Setting Multiple Environment Variables**:
   You can set multiple environment variables by using multiple `--env` flags:
   ```bash
   docker run -e VAR1=value1 -e VAR2=value2 --name mycontainer myimage
   ```
   This sets two environment variables `VAR1` and `VAR2` in the container.

3. **Using Environment Variables from a File**:
   If you have a file containing environment variables (usually referred to as an `.env` file), you can use the `--env-file` flag to import all of them into the container:
   ```bash
   docker run --env-file ./myenvfile.env --name mycontainer myimage
   ```
   This command reads environment variables from `myenvfile.env` and sets them in `mycontainer`.

4. **Combining Individual and File-Based Environment Variables**:
   You can mix both methods to set some environment variables from a file and others individually:
   ```bash
   docker run --env-file ./myenvfile.env -e ADDITIONAL_VAR=additionalvalue --name mycontainer myimage
   ```
   This command will use the environment variables in `myenvfile.env` and also set `ADDITIONAL_VAR`.

5. **Overriding Default Environment Variables**:
   If the image `myimage` has default environment variables set (in its Dockerfile), you can override them using the `--env` flag:
   ```bash
   docker run -e VAR_IN_IMAGE=newvalue --name mycontainer myimage
   ```
   Here, `VAR_IN_IMAGE` will be set to `newvalue` in the container, overriding any default value set in the image.

6. **Setting Environment Variables in Docker Compose**:
   In a `docker-compose.yml` file, you can also set environment variables using the `environment` key:
   ```yaml
   version: '3'
   services:
     myservice:
       image: myimage
       environment:
         - MY_VAR=myvalue
   ```
   This sets `MY_VAR` for `myservice` when using Docker Compose.

These examples demonstrate how to use the `--env` flag to set environment variables in Docker containers, which is essential for configuring container behavior and passing runtime settings.


#### Docker container --restart

The `--restart` flag in Docker is used to control the restart policy of a container. This policy determines how Docker should handle the container's restarts in cases where the container exits. The flag is primarily used with the `docker run` command to set the restart policy when creating a new container. when the docker service is restarted if your restart policy is set to `always` or `on-failure` the container will be restarted but if your restart policy is set to `no` the container will not be restarted. The default restart policy is `no`.

Here are different ways to use this flag:

1. **No Restart Policy**:
   To specify that a container should not automatically restart, use the `no` policy.
   ```bash
   docker run --restart=no --name mycontainer myimage
   ```
   This command starts `mycontainer` with a policy that prevents it from restarting automatically.

2. **Always Restart Policy**:
   If you want the container to always restart regardless of the exit status, use the `always` policy.
   ```bash
   docker run --restart=always --name mycontainer myimage
   ```
   Here, `mycontainer` will always restart automatically if it stops for any reason.

3. **Restart on Failure Policy**:
   To make the container restart only when it exits with a non-zero (failure) status, use `on-failure`.
   ```bash
   docker run --restart=on-failure --name mycontainer myimage
   ```
   `mycontainer` will restart automatically only if it exits with an error. exit status `non-zero`
   It dosn't restart automatically if it exits with a zero (success) status. like restart docker daemon.
4. **Restart on Failure with Maximum Retry Count**:
   You can also specify a maximum number of restart attempts with the `on-failure` policy.
   ```bash
   docker run --restart=on-failure:5 --name mycontainer myimage
   ```
   This sets up `mycontainer` to restart on failure, but it will give up after 5 failed attempts.

5. **Using Restart Policies in Docker Compose**:
   In a Docker Compose file, you can set the restart policy using the `restart` key in the service configuration.
   ```yaml
   version: '3'
   services:
     myservice:
       image: myimage
       restart: always
   ```
   This ensures that the service `myservice` will always restart automatically.

6. **Changing Restart Policy of Existing Containers**:
   For containers that are already running or have been created, you can update the restart policy using the `docker update` command.
   ```bash
   docker update --restart=always mycontainer
   ```
   This updates the restart policy of an existing container named `mycontainer` to `always`.

These examples illustrate how to set and manage the restart policies of Docker containers. Restart policies are crucial for ensuring high availability and resilience of services, especially in production environments.

7. **unless-stopped**:
   Similar to always, except that when the container is stopped (manually or otherwise), it isn't restarted even after Docker daemon restarts.
   To make a container restart only when it exits, use the `unless-stopped` policy.
   ```bash
   docker run --restart=unless-stopped --name mycontainer myimage
   ```
   This command starts `mycontainer` with a policy that prevents it from restarting automatically unless it is stopped manually.

#### Docker logs

The `docker logs` command is used to fetch the logs of a running container. This command is incredibly useful for debugging and monitoring the behavior of containers by providing access to the stdout and stderr streams of the container. Here's how you can use it:

1. **Basic Usage**:
   To view the logs of a container, use the container ID or name:
   ```bash
   docker logs mycontainer
   ```
   This command will display the logs of `mycontainer`.

2. **Following Log Output**:
   To continuously follow the log output (similar to `tail -f`), use the `-f` or `--follow` flag:
   ```bash
   docker logs -f mycontainer
   ```
   This will show the log output in real-time.

3. **Displaying Timestamps**:
   If you want to include timestamps in each log entry, use the `--timestamps` or `-t` flag:
   ```bash
   docker logs -t mycontainer
   ```
   This will show the logs with timestamps for each entry.

4. **Tail Logs**:
   To show only the last `n` lines of the log, use the `--tail` flag:
   ```bash
   docker logs --tail 10 mycontainer
   ```
   This command shows the last 10 lines of logs for `mycontainer`.

5. **Viewing Logs Since a Certain Time**:
   You can display log entries since a certain timestamp using the `--since` option:
   ```bash
   docker logs --since 2021-01-01T00:00:00 mycontainer
   ```
   This will show logs starting from the specified timestamp.

6. **Showing Logs before a Specific Time**:
   Similarly, to show logs before a certain time, use the `--until` flag:
   ```bash
   docker logs --until 2021-01-01T00:00:00 mycontainer
   ```
   This will display logs up to the specified timestamp.

7. **Limiting Log Output**:
   To limit the amount of log output, you can combine `--tail` with `--since`:
   ```bash
   docker logs --since 1h --tail 50 mycontainer
   ```
   This shows the last 50 lines of logs from the past hour.

These examples cover various ways to use the `docker logs` command to access and filter the log output from Docker containers. It's a crucial tool for troubleshooting issues, monitoring container behavior, and understanding the runtime behavior of applications running inside containers.

```bash
docker run -dit --name mysql mysql:latest # get error because you can't set root variable
```
and the output is:

```bash
docker logs mysql
2023-12-30 11:23:52+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.2.0-1.el8 started.
2023-12-30 11:23:53+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2023-12-30 11:23:53+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.2.0-1.el8 started.
2023-12-30 11:23:53+00:00 [ERROR] [Entrypoint]: Database is uninitialized and password option is not specified
    You need to specify one of the following as an environment variable:
    - MYSQL_ROOT_PASSWORD
    - MYSQL_ALLOW_EMPTY_PASSWORD
    - MYSQL_RANDOM_ROOT_PASSWORD
```

Lets try again:

```bash
docker run -dit --name mysql2 -e MYSQL_ROOT_PASSWORD=Aa1234 mysql:latest
```

```bash
[node2] (local) root@192.168.0.12 ~
$ docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS                 NAMES
4e643f6b3d88   mysql:latest   "docker-entrypoint.s…"   About a minute ago   Up About a minute   3306/tcp, 33060/tcp   mysql2
[node2] (local) root@192.168.0.12 ~
```

## Let's use labs.play-with-docker.com to learn more

Login to the `labs.play-with-docker.com` website to access all the resources for 4 hours

You can copy and paste the private key from `~/.ssh/id_rsa` to your local machine(ctrl + shift + insert for copy) to access the servers. the defualt use is `root`. Remember the private key always is same for all the servers.

```bash
[node2] (local) root@192.168.0.12 ~
$ cat .ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBlxyi89vBZk8iISR70zEF1KMq8S/Xe3OebPQJyMNFd0QAAAJgZ05i7GdOY
uwAAAAtzc2gtZWQyNTUxOQAAACBlxyi89vBZk8iISR70zEF1KMq8S/Xe3OebPQJyMNFd0Q
AAAECbQoApAGpgiRSLjGiOSmbN80A0/9vJW2T+BNjVNPkLjGXHKLz28FmTyIhJHvTMQXUo
yrxL9d7c55s9AnIw0V3RAAAAFHJvb3RAYnVpbGRraXRzYW5kYm94AQ==
-----END OPENSSH PRIVATE KEY-----
```

The host os is Alpine Linux and you can add package with `apk add` command. 

```bash
[node2] (local) root@192.168.0.12 ~
$ apk add vim
```


### Docker event

The `docker events` command is a powerful tool in Docker's command-line interface that provides a real-time stream of events happening within the Docker daemon. These events can include various actions related to Docker objects such as containers, images, volumes, networks, and more. Here's an overview of what `docker events` is and how it can be used:

- **Purpose of Docker Events**:
  Docker events offer a live stream of what's happening at the Docker daemon level. It's useful for monitoring and reacting to various changes in the Docker environment, such as container lifecycle events (creation, start, stop, kill, die, etc.), image events (pull, push, delete), and more.

- **Basic Usage**:
  To start streaming events from the Docker daemon, simply run:
  ```bash
  docker events
  ```
  This will display a continuous stream of events as they occur.

- **Filtering Events**:
  You can filter events based on criteria like event type, container, image, volume, network, or labels. This is done using the `--filter` option. For example, to watch for events related to a specific container, you can use:
  ```bash
  docker events --filter 'type=container' --filter 'container=mycontainer'
  ```
  This will show events only for the container named `mycontainer`.

- **Specifying Time Range**:
  `docker events` can also be used to get events from a specific time range using the `--since` and `--until` options. For instance, to get events that occurred in the last 24 hours:
  ```bash
  docker events --since 24h
  ```
  Or to get events between two specific timestamps:
  ```bash
  docker events --since '2021-01-01T00:00:00' --until '2021-01-02T00:00:00'
  ```

- **Event Information**:
  Each event displayed by `docker events` includes details such as the time of the event, the type of object involved (container, image, network, etc.), the action that occurred, and the ID of the object.

- **Use Cases**:
  Monitoring Docker events can be especially useful in automated systems, where you might need to trigger actions based on specific Docker events. It's also useful for auditing and logging purposes in complex Docker environments.

- **Streaming to a File**:
  You can also redirect the output of `docker events` to a file for later analysis or monitoring:
  ```bash
  docker events > docker_events.log
  ```

Understanding and utilizing Docker events is key for advanced Docker usage, especially in environments where real-time monitoring and automated response systems are required.