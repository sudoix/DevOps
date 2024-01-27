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
