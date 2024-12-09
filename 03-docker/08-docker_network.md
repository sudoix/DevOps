![docker network](../.gitbook/assets/67-docker-network.png)

## Docker Network

The Container Network Model (CNM) is a standard, proposed by Docker, designed to provide a general framework for networking in containerized environments. It aims to simplify and standardize how containers communicate with each other and with the outside world. The CNM is part of Docker's broader effort to make container technologies more accessible and easier to use, particularly in complex, multi-container environments. Here are the key components and concepts of the CNM:

1. **Network Sandbox**: A network sandbox holds the configuration of a container's network stack. This includes the container's network interfaces, routing table, and DNS settings. Each container has its own network sandbox.

2. **Endpoint**: An endpoint joins a network sandbox to a network. It represents a network interface within the container. A container can have multiple endpoints connected to different networks, allowing it to communicate across these networks.

3. **Network**: A network is a group of endpoints that can communicate directly with each other. In the CNM, networks are isolated from each other, meaning that containers on different networks cannot communicate unless explicitly allowed. Networks can be created with different drivers, allowing for different kinds of networking behavior, such as overlay networking for communication across different hosts or physical networking for high performance.

4. **Network Driver**: Network drivers provide the underlying technology that powers the networks. Docker supports several built-in network drivers (like bridge, overlay, and macvlan) and allows for third-party drivers through its plugin system. Each driver offers different features and is suitable for different use cases.

The CNM provides a flexible and extensible framework for container networking. It allows users to create complex, multi-host network configurations, supports network segmentation and isolation, and integrates with external networking solutions through plugins. The CNM's design is focused on simplicity, aiming to make it as straightforward as possible for users to connect their containers in a way that suits their application's architecture and security requirements.

### ipam driver

In the context of the Container Network Model (CNM) used by Docker and other container technologies, an IPAM (IP Address Management) driver is responsible for IP address management within container networks. The IPAM driver allocates IP addresses to containers and manages the IP address space for networks, ensuring that each container has a unique IP address and that address conflicts are avoided. It plays a crucial role in the network configuration and operation of containers, enabling seamless communication between containers, as well as between containers and external networks.

Key functions of an IPAM driver include:

1. **IP Address Allocation**: When a container is created or connected to a network, the IPAM driver allocates an IP address to it. The allocation is based on the network's address space and existing allocations to ensure no two containers have the same IP address within the same network.

2. **Subnet Management**: The IPAM driver manages subnets within each network, defining how the IP address space is divided and used. This includes determining the subnet mask and gateway for each subnet, which is crucial for routing traffic between containers and between containers and the outside world.

3. **Address Space Management**: For networks that span multiple hosts, the IPAM driver manages the distribution of IP address space across these hosts, ensuring that address allocations are consistent and non-conflicting across the cluster.

4. **DNS Configuration**: Some IPAM drivers also assist in managing DNS settings for containers, ensuring that containers can resolve each other's names and communicate effectively.

Docker, for example, comes with a default IPAM driver but also allows users to plug in custom IPAM drivers that can offer more advanced features or integration with external IPAM systems. This flexibility allows users to tailor their network management to the specific needs of their deployment, whether they're running a simple, single-host setup or a complex, multi-host environment.

By abstracting away the complexities of IP address management, IPAM drivers play a critical role in making container networking as automatic and frictionless as possible, enabling users to focus on building and scaling their applications instead of managing network details.

### Docker network type

Docker supports several types of networks, each designed for specific use cases and offering different features and behaviors. These network types are implemented using Docker's network drivers. Here are the main types of Docker networks:

1. **Bridge Network**: The default network type for containers. When you run a container without specifying a network, Docker connects it to a bridge network. This network type is suitable for single-host networking, where containers need to communicate with each other and with the host. Each container on a bridge network can access each other via IP addresses, and NAT is used to manage external access.

2. **Host Network**: Containers attached to the host network share the host's networking namespace. They use the host's IP address and port space, bypassing the network isolation between the container and the host. This type is useful for services that need to handle lots of traffic or need to avoid the overhead of network namespaces, but it sacrifices the isolation that containers usually provide.

3. **Overlay Network**: Designed for multi-host networking, overlay networks enable containers running on different Docker hosts to communicate with each other as if they were on the same host. Overlay networks use network overlays like VXLAN to encapsulate network traffic, allowing containers to communicate across different networks and data centers. This type is essential for **Docker Swarm and Kubernetes** setups that span multiple hosts.

4. **Macvlan Network**: Macvlan networks allow containers to have a unique MAC address, making them appear as physical devices on the network. This type is useful in scenarios where you need containers to appear as physical hosts on the network, with their own IP addresses directly on the physical network. It's beneficial for legacy applications that expect to be directly connected to the physical network.

5. **None Network**: When attached to the none network, a container does not have networking. It's isolated from the outside world and other containers. This type is useful for containers that should run tasks without any network access, for security or testing purposes.

6. **Custom Networks**: Users can create custom networks using Docker's network plugins, allowing for integration with third-party network solutions or the implementation of custom networking behaviors. This flexibility enables Docker to fit into a wide variety of networking environments and use cases.

Each network type serves different needs, from simple, isolated development environments to complex, distributed applications spanning multiple data centers. By choosing the appropriate network type, Docker users can tailor the networking behavior of their containers to meet the requirements of their applications and infrastructure.


```bash
docker network ls
```

To create network

```bash
docker network create [OPTIONS] NETWORK

docker network create --subnet 237.84.2.0/24 --gateway 237.84.2.1 net1

docker network create --driver=bridge --subnet=237.84.2.178/24 net1

docker network create net1
```

Let's create container with network

```bash
docker run -itd --name container1 --network net1  ubuntu # when you want to run container with network you can connect just one network
docker exec -it container1 /bin/bash
apt update && apt install iputils-ping iproute2

docker run -itd --name container2 --network net2  ubuntu
```

Connect container to another network

```bash
docker network connect net2 container1 # when you want to connect container to another network

docker network disconnect net2 container1 # when you want to disconnect container from another network
```

For checking container network

```bash
docker network inspect net1

docker container inspect container1
```

To remove network

```bash
docker network ls

docker network inspect net1

docker network rm net1

docker network rm $(docker network ls -q)
```

You can ping the ip and name of container in the network. but if it's a default bridge network, it will not work with name.


**The Docker embedded DNS server does not work in the default bridge network due to the way Docker's networking and service discovery mechanisms are designed. The default bridge network is the original network mode that Docker used before the introduction of user-defined networks and the embedded DNS server feature.**

### Host network

```bash
docker run -itd --name container1 --network host ubuntu
```

For checking container network

```bash
docker exec -it container1 /bin/bash

apt update && apt install iputils-ping iproute2
```

Let's create nginx container with host network

```bash
docker run -itd --name nginx --network host nginx:latest
```

and run another nginx container with host network and se the log of container

```bash
docker run -itd --name nginx2 --network host nginx:latest
```

## Publshic port

Publishing ports in Docker is a way to map a port inside a container to a port on the Docker host. This process allows external access to a service running inside a container, making the service accessible from outside the Docker host, including from other machines on the network. This feature is essential for deploying containerized applications that need to interact with external systems or be accessible to users.

When you run a container, you can specify port mappings using the `-p` or `--publish` flag with the `docker run` command. The syntax for this flag is as follows:

```
docker run -p <host_port>:<container_port> <image>
```

- `<host_port>`: The port on the Docker host you want to open and map to a port on the container.
- `<container_port>`: The port inside the container that the application is listening on.

For example, if you have a web application running inside a container that listens on port 80, and you want to make it accessible on the Docker host's port 8080, you would run:

```
docker run -p 8080:80 <image>
```

This command tells Docker to map port 80 inside the container to port 8080 on the Docker host. After running this command, any traffic that comes to the host on port 8080 will be forwarded to port 80 inside the container.

### Multiple Port Mappings

You can also publish multiple ports for a single container by using the `-p` or `--publish` flag multiple times:

```
docker run -p 8080:80 -p 8443:443 <image>
```

This would map port 80 inside the container to port 8080 on the host and port 443 inside the container to port 8443 on the host.

### Docker Compose

If you're using Docker Compose, you can specify port mappings in the `docker-compose.yml` file under the `ports` section of a service:

```yaml
version: '3'
services:
  webapp:
    image: <image>
    ports:
      - "8080:80"
      - "8443:443"
```

This configuration achieves the same result as the `docker run` command, mapping ports from containers to the host, but it's defined in a YAML file format.

Publishing ports is a powerful feature for deploying applications, as it allows containers to communicate with the outside world. It's crucial for web servers, databases, or any services that need to be accessible over the network.

```bash
docker run -dit --name nginx1 -p 8080:80 -p 8443:443 --expose 443 nginx:latest # expose port 443 if you want to expose port 443
```




