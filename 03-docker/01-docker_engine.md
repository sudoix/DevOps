![dockerEngine](../assets/51-dockerEngine.png)

## Docker Engine

Docker Engine is at the core of the Docker system. When installing Docker on our device, we usually set up two components: the Docker Command Line Interface (CLI) and Docker Daemon.

**Server:** A long-running program called a daemon process (the dockerd command).

**REST API:** An interface that programs can use to talk to the daemon and instruct it what to do.

**Command Line Interface (CLI):** A command-line tool (docker) that allows users to interact with Docker daemons through the Docker API.


Docker Engine is the core component of Docker, a popular containerization platform. It's a client-server application with three major components:

Server: A long-running program called a daemon process (the dockerd command).

REST API: An interface that programs can use to talk to the daemon and instruct it what to do.

Command Line Interface (CLI): A command-line tool (docker) that allows users to interact with Docker daemons through the Docker API.

Here's a more detailed look at these components:

**Docker Daemon (dockerd):** The Docker daemon listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. It can also communicate with other Docker daemons to manage Docker services.

**REST API:** The Docker REST API provides a way for applications to interact programmatically with the Docker daemon. It can be used to control almost every aspect of Docker, from creating and managing containers to handling storage and networks.

**CLI (docker):** The Docker CLI client provides a command-line interface that users can use to interact with Docker. When you use commands such as docker run, the client sends these commands to dockerd, which carries them out.

## Docker Architecture

![Docker-Architecture](../assets/52-Docker-Architecture.gif)

