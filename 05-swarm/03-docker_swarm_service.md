![swarm_service](../assets/72-swarm_service.jpg)

Docker Swarm Services are a key concept in Docker Swarm mode, enabling you to deploy, scale, and manage a set of containers across a cluster of Docker hosts. A service in Docker Swarm allows you to define the desired state of your application or a component of your application that runs on the Swarm cluster. Here’s an overview of how services work in Docker Swarm and how you can use them:

### What is a Docker Swarm Service?

A Docker Swarm service abstracts the way you run your application containers on a cluster of Docker nodes. It allows you to specify not only which container image to use and how many instances of that container should be running but also how the containers should behave—such as network configurations, storage options, and update policies—ensuring your application runs exactly as you’ve specified across your cluster.

### Key Features of Docker Swarm Services:

1. **Scalability**: Easily scale a service up or down using simple commands to increase or decrease the number of container instances (replicas) running in the swarm.

2. **Load Balancing**: Docker Swarm automatically distributes service instances among the nodes in the cluster. It also comes with an internal load balancer that can distribute network traffic among the instances of a service.

3. **Rolling Updates and Rollbacks**: Apply updates to your service without downtime. Docker Swarm can gradually update service instances across the cluster, ensuring high availability. If something goes wrong, you can rollback to the previous version of the service.

4. **Self-healing**: Docker Swarm monitors the health of nodes and services. If a container in a service fails, Swarm automatically restarts it on a healthy node to maintain the desired state.

5. **Service Discovery**: Services can discover each other through Docker's internal DNS server. Each service in the swarm gets a unique DNS name, allowing for inter-service communication without hardcoding container IP addresses.

### Creating and Managing Docker Swarm Services:

To create a service in Docker Swarm, you use the `docker service create` command with various options to define your service. Here’s a basic example:

```sh
docker service create --name my-web-app --replicas 3 -p 80:80 my-image:latest
```

This command creates a service named `my-web-app`, based on the `my-image:latest` Docker image. It starts 3 replicas of the container and maps port 80 on the host to port 80 in the containers.

To manage services, Docker provides several commands:

- **List Services**: `docker service ls`
- **Inspect a Service**: `docker service inspect --pretty <service-name>`
- **Scale a Service**: `docker service scale <service-name>=<num-replicas>`
- **Update a Service**: `docker service update --image <new-image>:<tag> <service-name>`
- **Remove a Service**: `docker service rm <service-name>`


### Docker Swarm Service commands:

```sh
docker service create --name nginx1 nginx:latest
```

list services

```sh
docker service ls
```

```sh
docker service ps nginx1
```

scale service

```sh
docker service scale nginx1=2
```