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

