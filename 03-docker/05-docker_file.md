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