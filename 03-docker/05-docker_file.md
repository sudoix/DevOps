## Docker file

Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Here's a basic example of a Dockerfile:

create an example:

```bash
vim Dockerfile
```

```Dockerfile
From ubuntu:22.04 # this is the base image

LABEL maintainer="Your Name <your_email>" Description="This is an example"

RUN apt-get update # update the package list
RUN apt-get install -y vim nginx # install vim and nginx

```

Better use `Dockerfile` to build your image

```Dockerfile
From ubuntu:22.04 # this is the base image

LABEL maintainer="Your Name <your_email>" Description="This is an example"

RUN apt-get update && apt-get install -y vim nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

```

## Building and Running the Docker Container

1. **Build the Docker Image**:
   - In the directory containing your Dockerfile and Bash script, run:

     ```bash
     docker build -t myapp:v1 .
     ```

If you miss `t` you image name is `none`

**If you get 403 error user `docker.ir`**

Edit `vim /etc/docker/daemon.json` and add

```json
{
    "registry-mirrors": ["https://registry.docker.ir"]
}
```

Then

```bash
systemctl daemon reload
systemctl restart docker
```

2. **Run the Docker Container**:
   - To run your container, execute:

     ```bash
     docker run -dit --name myapp1 myapp:v1
     ```

For clear docker cache use `docker system prune -a -f`

Fot tag on image with name `none`

```bash
docker tag IMAGE ID NAME:v1
```

For rename tag use:

```bash
docker tag IMAGE ID NAME:v2
```

See the output

```bash
docker image ls
```

**Docker append tag to image name**


## Cleare docker cache

Clearing the Docker cache can help free up disk space and resolve certain issues by removing unused Docker images, containers, volumes, and networks. Here's how you can do it:

1. **Remove unused Docker images:**
   - To remove all unused images, you can use the command:
     ```bash
     docker image prune -a
     ```
   - This will remove all images that are not used by existing containers, including dangling images (images without a tag).

2. **Remove stopped containers:**
   - To remove all stopped containers, use the command:
     ```bash
     docker container prune
     ```
   - This will remove all containers that have a status of exited.

3. **Remove unused volumes:**
   - To remove all unused volumes, use the command:
     ```bash
     docker volume prune
     ```
   - This will delete all volumes not used by at least one container.

4. **Remove unused networks:**
   - To remove all unused networks, use:
     ```bash
     docker network prune
     ```
   - This will remove all networks not used by at least one container.

5. **Combine pruning commands:**
   - Docker provides a convenient way to clean up multiple types of unused objects at once:
     ```bash
     docker system prune
     ```
   - By default, this command will remove stopped containers, unused networks, and dangling images. If you also want to remove all unused images (not just dangling ones), you can add the `-a` flag:
     ```bash
     docker system prune -a
     ```

6. **Remove everything:**
   - If you want to remove all containers, networks, and images (both used and unused), you can use:
     ```bash
     docker system prune -a --volumes
     ```
   - Be cautious with this command as it will remove your entire Docker environment including data in volumes.

**Note:** These commands can lead to data loss if not used carefully. Make sure to backup important data before running these commands. Also, be aware that removing unused images and containers can affect your ability to revert to previous states or use cached layers for faster builds.

## Push to docker hub

Pushing a Docker image to Docker Hub involves several steps. You need to have a Docker Hub account, and the image you want to push should already be built on your local machine. Here's a step-by-step guide:

### 1. Create a Docker Hub Account

If you don't already have a Docker Hub account, you need to create one at [Docker Hub](https://hub.docker.com/). 

### 2. Log in to Docker Hub from the Command Line

Open your command line or terminal and log in to Docker Hub using the following command:

```bash
docker login
```

Enter your Docker Hub username and password when prompted. Once successfully logged in, you can start pushing images to your Docker Hub repository.

After login create your repository

### 3. Tag Your Docker Image

Before you can push an image, you need to tag it with your Docker Hub username and repository name. The general format for the tag is:

```
docker tag local-image:tag username/repository:tag
```

For example, if your Docker Hub username is `johndoe` and you have a local image named `my-python-app` (tagged as `latest`), you would tag it like this:

```bash
docker tag my-python-app:latest johndoe/my-python-app:latest
```

### 4. Push the Image to Docker Hub

After tagging the image, you can push it to Docker Hub with the `docker push` command:

```bash
docker push username/repository:tag
```

Following the previous example:

```bash
docker push johndoe/my-python-app:latest
```

This command uploads the `my-python-app` image to your Docker Hub account under the `johndoe` repository.

### 5. Verify the Image on Docker Hub

After pushing the image, you can log in to your Docker Hub account and check if the image is listed under your repositories.

### Notes:

- **Repository Naming**: The repository name on Docker Hub is case-sensitive.
- **Public vs. Private Repositories**: By default, repositories on Docker Hub are public. You can change the visibility to private in the repository settings on Docker Hub.
- **Image Size and Layers**: Be aware of the size of your image and the number of layers it has. Optimizing these can help with quicker downloads and deployments.
- **Version Tagging**: It's a good practice to tag your images with version numbers (other than just `latest`), especially for production use.

Pushing images to Docker Hub is a common practice for making your images available to others or for deploying them to various environments.

## How to see the layers of docker images

Viewing the layers of a Docker image can be helpful for understanding how the image is constructed, optimizing build processes, or simply satisfying curiosity about the contents and changes at each layer. Docker provides a way to inspect these layers using the `docker history` and `docker inspect` commands.

### Using `docker history`

The `docker history` command shows the history of an image including the layers and the commands that were run to create each layer. To use this command:

```bash
docker history [OPTIONS] IMAGE
```

For example, to see the layers of an image called `my-image:latest`, you would use:

```bash
docker history my-image:latest
```

This command will list each layer with details like the size of the layer, when it was created, and the command that was run to create it.

### Using `docker inspect`

The `docker inspect` command provides more detailed information about an image, including layer information. To inspect an image:

```bash
docker inspect [OPTIONS] IMAGE
```

For example:

```bash
docker inspect my-image:latest
```

This command returns a JSON array with a lot of information about the image. To specifically look at the layers, you might need to parse this JSON. You can do this manually, or use tools like `jq` to filter the output. For example:

```bash
docker inspect my-image:latest | jq '.[].RootFS.Layers'
```

This `jq` command filters the output to show only the layers of the image.

### Note:

- The `docker history` command is usually more user-friendly for a quick overview of the layers and their creation commands.
- The `docker inspect` command provides more detailed information, which can be useful for deeper analysis but might require JSON parsing for readability.
- These commands can help you understand how your Docker images are built and can aid in optimizing your Dockerfiles and build processes.

## Docker file command and option

Understanding the commands used in a Dockerfile is essential for creating Docker images effectively. Here's a brief overview of some of the most common Dockerfile instructions:

### FROM

- **Purpose**: Specifies the base image from which you are building.
- **Example**: `FROM ubuntu:18.04`

### RUN

- **Purpose**: Executes commands in a new layer on top of the current image and commits the results.
- **Example**: `RUN apt-get update && apt-get install -y python3`

### CMD

- **Purpose**: Provides defaults for an executing container. There can only be one CMD instruction in a Dockerfile.
- **Example**: `CMD ["python3", "./app.py"]`

### LABEL

- **Purpose**: Adds metadata to an image as a key-value pair.
- **Example**: `LABEL maintainer="name@example.com"`

### EXPOSE

- **Purpose**: Informs Docker that the container listens on the specified network ports at runtime.
- **Example**: `EXPOSE 80`

### ENV

- **Purpose**: Sets environment variables.
- **Example**: `ENV API_KEY="123456789"`

### ADD

- **Purpose**: Copies new files, directories, or remote file URLs from `<src>` and adds them to the filesystem of the image at the path `<dest>`.
- **Example**: `ADD . /app`

### COPY

- **Purpose**: Copies new files or directories from `<src>` and adds them to the filesystem of the container at the path `<dest>`.
- **Example**: `COPY . /app`

### ENTRYPOINT

- **Purpose**: Allows you to configure a container that will run as an executable.
- **Example**: `ENTRYPOINT ["python3"]`

### VOLUME

- **Purpose**: Creates a mount point with the specified name and marks it as holding externally mounted volumes from the native host or other containers.
- **Example**: `VOLUME /data`

### WORKDIR

- **Purpose**: Sets the working directory for any RUN, CMD, ENTRYPOINT, COPY, and ADD instructions that follow it in the Dockerfile.
- **Example**: `WORKDIR /app`

### USER

- **Purpose**: Sets the user name or UID to use when running the image and for any RUN, CMD, and ENTRYPOINT instructions that follow it in the Dockerfile.
- **Example**: `USER myuser`

### HEALTHCHECK

- **Purpose**: Tells Docker how to test a container to check that it is still working.
- **Example**: `HEALTHCHECK CMD curl --fail http://localhost:80/ || exit 1`

### ONBUILD

- **Purpose**: Adds a trigger instruction to be executed at a later time, when the image is used as the base for another build.
- **Example**: `ONBUILD ADD . /app`

### SHELL

- **Purpose**: Allows the default shell used for the shell form of commands to be overridden.
- **Example**: `SHELL ["powershell", "-command"]`

Remember, the order of instructions in a Dockerfile is significant. Each instruction creates a new layer in the image, and Docker caches these layers to speed up subsequent builds. Efficient ordering and use of instructions can significantly optimize your build process and the size of the image.

**ADD and COPY**

In Dockerfiles, both `ADD` and `COPY` are instructions used to copy files and directories from a specified source on the host into the Docker image. However, they have different functionalities and are suited for different scenarios. Here's a breakdown of their differences:

### COPY

- **Function**: `COPY` is a straightforward command used to copy files and directories from the host file system into a Docker image. 
- **Usage**: It's the preferred command for simply copying local files into an image.
- **Example**: `COPY ./app /usr/src/app`
- **Behavior**: It only copies files and directories from a local source - it doesn't support URLs or extracting archives.

### ADD

- **Function**: `ADD` has more features than `COPY`. In addition to copying files from a local source, `ADD` also supports two additional functionalities:
  1. **URL Support**: It can copy files from a remote URL into the image.
  2. **Auto-extraction**: It can automatically unpack local tar files into the image.
- **Usage**: `ADD` is used when you need to leverage these additional capabilities (downloading from a URL or auto-extracting tar files).
- **Example**:
  - Copying from a URL: `ADD https://example.com/big.tar.xz /usr/src/big`
  - Auto-extracting a tar file: `ADD files.tar.gz /usr/src/app`
- **Caveats**: Since `ADD` can automatically extract tar files, it's important to be explicit in your Dockerfile to ensure the clarity and predictability of your builds.
   3. **copy hidden file or direcroy**
### When to Use Each

- **Use `COPY` when**: You need to copy local files and directories into an image. It's the safer and more transparent option for standard copying operations.
- **Use `ADD` when**: You need to copy files from a remote URL or automatically extract a tar file into the image.

In general, Docker recommends using `COPY` for copying files from the local file system, as it's more transparent than `ADD`. `ADD` should be used for its advanced capabilities when they are specifically required.

### docker info

The `docker info` command in Docker is a powerful tool that provides comprehensive information about the Docker installation and its current state. When you run this command, it returns a detailed report about the Docker environment


## more about docker file

Here's a Dockerfile based on your specifications, along with descriptions for each command:

```Dockerfile
# This is the base image, using Ubuntu 22.04
FROM ubuntu:22.04

# Metadata for the image with maintainer information and a description
LABEL maintainer="Your Name <your_email>" Description="This is an example"

# Update the package lists, install vim and nginx, then clean up 
# the cache to reduce the size of the image. This installs vim and nginx 
# and then removes unnecessary files and lists to keep the image size small.
RUN apt-get update && apt-get install -y vim nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the working directory to /app1. Docker creates the directory if it doesn't exist.
WORKDIR /app1

# Copy all shell script files from the current directory on the host
# to the working directory in the image (/app1).
COPY ./*.sh . 

# Create a mount point at /home/milad and /app2/. This is a declaration that these
# directories are intended to be mounted as volumes, possibly from the host or 
# from other containers. Note that this doesn't actually mount anything by itself;
# it's more documentation for users of the image.
VOLUME ["/home/milad", "/app2/"]
```

Each line in the Dockerfile serves a specific purpose:

1. `FROM`: Specifies the base image from which you are building.
2. `LABEL`: Adds metadata to the image, useful for documentation and specifying the maintainer.
3. `RUN`: Runs shell commands inside the container. Here, it's used for installing packages and cleaning up.
4. `WORKDIR`: Sets the working directory for any `RUN`, `CMD`, `ENTRYPOINT`, `COPY`, and `ADD` instructions that follow it.
5. `COPY`: Copies files from your Docker client’s current directory.
6. `VOLUME`: Indicates that the specified directories should be treated as mount points.

Remember to replace `"Your Name <your_email>"` with your actual name and email address. This Dockerfile is a basic starting point and can be extended or modified according to your specific requirements.

Creating a Dockerfile with a comprehensive set of instructions involves covering various aspects such as setting up the environment, installing necessary software, configuring settings, and ensuring best practices for security and performance. Below is an example of a detailed Dockerfile for a typical web application using Nginx as a web server. This example includes comments for clarity:

```Dockerfile
# Use an official Ubuntu base image
FROM ubuntu:22.04

# Define maintainer and provide a description
LABEL maintainer="Your Name <your_email@example.com>" \
      Description="Web application with Nginx"

# Set environment variables to non-interactive (to avoid prompts during package installation)
ENV DEBIAN_FRONTEND=noninteractive

# Run a series of commands to update and install necessary packages
# Install Nginx, Vim, and other utilities
# Clean up to reduce image size
RUN apt-get update && apt-get install -y \
    nginx \
    vim \
    curl \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy local files to the container's working directory
COPY . /var/www/html

# Set up volume for persistent data
VOLUME /var/www/html

# Expose port 80 for the web server
EXPOSE 80

# Set up health checks (optional)
# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
#   CMD curl -f http://localhost/ || exit 1

# Use a custom entrypoint script (optional)
# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]

# Default command to execute
# Here, start Nginx in the foreground to ensure that the Docker container stays running

# `ENTRYPOINT ["nginx"]`
# `CMD ["-g", "daemon off;"]`

CMD ["nginx", "-g", "daemon off;"]
```

In this Dockerfile:

- `FROM` specifies the base image.
- `LABEL` adds metadata.
- `ENV` sets environment variables.
- `RUN` executes commands to install necessary software.
- `WORKDIR` sets the working directory.
- `COPY` copies files from the local file system to the container.
- `VOLUME` declares a volume for persistent data.
- `EXPOSE` informs Docker that the container listens on specified network ports at runtime.
- `HEALTHCHECK` sets up a command to check the health of the container.
- `CMD` provides the default command to run when the container starts.

You may need to adjust paths, port numbers, and other settings to match your specific application requirements. The `entrypoint.sh` is optional and can be used to execute custom startup scripts or commands. If you use it, ensure you have an `entrypoint.sh` script in your context directory and uncomment the relevant lines.

In Dockerfiles, `RUN`, `CMD`, and `ENTRYPOINT` are three different instructions that each serve a unique purpose in the image building process and the behavior of the container at runtime. Understanding the difference between them is crucial for effectively utilizing Docker:

1. **`RUN`**:
   - **Purpose**: The `RUN` instruction is used to execute commands inside your Docker image at build time. It's commonly used for installing software packages, compiling code, or setting up the environment.
   - **Behavior**: Each `RUN` instruction creates a new layer in the Docker image. Multiple `RUN` instructions can lead to many layers, which is why they are often combined using logical operators (`&&`) to reduce the number of layers in the image.
   - **Example**: `RUN apt-get update && apt-get install -y nginx`

**RUN execute when docker image builded**

2. **`CMD`**:
   - **Purpose**: The `CMD` instruction provides default commands and arguments that will be executed when the Docker container starts. It's a way to specify the default behavior of a container.
   - **Behavior**: If a Docker container is run without specifying a command, the `CMD` instruction is used. However, if you run the container and pass a command (like `bash` or `python script.py`), the `CMD` is overridden. A Dockerfile should have only one `CMD`; if there are multiple, the last `CMD` is the one that takes effect.
   - **Example**: `CMD ["nginx", "-g", "daemon off;"]` (This starts Nginx when the container runs)

3. **`ENTRYPOINT`**:
   - **Purpose**: The `ENTRYPOINT` instruction is similar to `CMD`, but it is meant to define the container as an executable. It allows you to set the default command and parameters and then use any additional `CMD` commands as parameters.
   - **Behavior**: `ENTRYPOINT` configures the container to run as an executable. When used in combination with `CMD`, the `ENTRYPOINT` defines a base command, and `CMD` provides default arguments which can be overridden from the command line when the container runs.
   - **Example**: 
     - `ENTRYPOINT ["nginx"]`
     - `CMD ["-g", "daemon off;"]`
     - In this case, `nginx -g "daemon off;"` is the default command. If you run `docker run [image] -g "daemon on;"`, it replaces the `CMD` part, resulting in `nginx -g "daemon on;"`.

In summary, `RUN` is for building the image, `CMD` is for defining a default command that can be overridden, and `ENTRYPOINT` is for making the container act as a specific executable.

**IN ENTRYPOINT YOU CAN'T OWERWRITE COMMAND IN DOCKER RUN BUT IN CMD YOU CAN**


### Docker file is in another location

```bash
docker build -t test:latest -f Dockerfile-prod /tmp
```
