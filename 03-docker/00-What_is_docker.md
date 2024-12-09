![what-is-docker](../.gitbook/assets/49-what-is-docker.png)


# Docker

Docker is a platform that uses OS-level virtualization to deliver software in packages called containers. Containers are isolated from each other and bundle their own software, libraries, and configuration files; they can communicate with each other through well-defined channels. The key features of Docker are:

#### Containerization:

Docker packages applications and their dependencies in a virtual container that can run on any Linux server. This helps provide flexibility and portability so that the application can run in various environments, whether on-premises, in the cloud, or in a hybrid environment.

#### Lightweight and Fast:

Containers share the machine's OS system kernel and are therefore lighter than virtual machines. This allows for more efficient use of system resources.

#### Docker Images:

Docker containers are created from Docker images. These images are a lightweight, standalone, executable package that includes everything needed to run an application - code, runtime, libraries, environment variables, and config files.

#### Docker Hub:

Docker Hub is a cloud-based registry service where users can find and share container images. It's a vast library of pre-made containers for various applications and services.

#### Microservices Architecture:

Docker is ideal for microservices architecture as it allows applications to be broken down into smaller, independent pieces that can be deployed and managed dynamically.

#### Scalability and Agility:

Docker allows for easy scaling of applications. Containers can be quickly added or subtracted to scale application workloads.

#### Consistent Environment:

Developers, QA, and production teams can all work in the same environment, reducing the **it works on my machine** problem.

#### Community and Enterprise Editions:

Docker is available in both a Community Edition (Docker CE) and an Enterprise Edition (Docker EE), catering to different user needs.

Docker has become a key component in modern software development, particularly in continuous integration and continuous deployment (CI/CD) pipelines.


## Virtual Machines vs Containers


![containers-vs-virtual-machines](../.gitbook/assets/50-containers-vs-virtual-machines.jpg)

Comparing Virtual Machines (VMs) and Containers helps to understand their differences, advantages, and use cases. Here are the key points of comparison:

Architecture:

#### Virtual Machines:

VMs run on a hypervisor and are a full abstraction of a physical server, including a full copy of an operating system, the application, necessary binaries, and libraries. Each VM is completely isolated from the host.

#### Containers:

Containers virtualize the operating system, sharing the OS kernel but packaging the application and its dependencies into a container. They are lighter than VMs as they don't need a full OS for each instance.

#### Performance and Resource Utilization:

- VMs: They require more resources as each VM runs a full copy of an operating system. This results in more resource overhead and potentially slower performance compared to containers.
- Containers: Generally more efficient, agile, and faster than VMs as they share the host system’s kernel. They use fewer resources than VMs and can start up almost instantly.

#### Isolation and Security:

- VMs: Offer strong isolation as they are completely separated from the host system and other VMs. This can be advantageous for running applications that require high security or isolation.
- Containers: While containers are isolated from each other, they share the host OS kernel. This shared kernel model can pose a security risk if a container is breached.

#### Portability:

- VMs: Moving VMs across different environments can be challenging due to dependencies on the underlying hardware and hypervisor.

- Containers: Easier to port across different environments since they are not tied to the OS of the host. This makes them ideal for continuous integration and continuous deployment (CI/CD) practices.

#### Scalability:

- VMs: Scaling can be slower because it involves replicating the entire VM, including its full operating system.

- Containers: Offer rapid scalability because they are lightweight and can be quickly started and stopped, making them suitable for applications that need to scale frequently.


#### Use Cases:

- VMs: Ideal for running applications that need full isolation, extensive OS-level customization, or running different operating systems on the same server.

- Containers: Best for microservice architectures, cloud-native development, and situations where you need to deploy many instances of the same application.

#### Management:

- VMs: Typically require more storage and more complex management, particularly in environments with a large number of VMs.

- Containers: Easier to manage, especially in large-scale deployments, due to their lightweight nature.

###### In summary, the choice between VMs and containers depends on the specific needs of the application, security requirements, environment, and scalability needs. Containers are often preferred in modern, cloud-native applications due to their lightweight nature and efficiency, whereas VMs are chosen for applications requiring strong isolation, full operating system control, or running on different OS kernels.


### High lever container runtime and low level container runtime

Container runtimes in the context of containerization and virtualization in software development can be divided into high-level and low-level runtimes. These runtimes handle the execution, lifecycle management, and resource allocation for containers. Understanding the distinction between high-level and low-level container runtimes is important for grasping how containerized applications are managed and executed.

### High-Level Container Runtimes

1. **Definition**: High-level container runtimes deal with container management at a more abstract level. They are responsible for higher-order functions like managing container images, orchestrating containers, handling user requests, and setting up networking for containers.

2. **Examples**:
   - **Docker**: One of the most popular high-level runtimes, providing a comprehensive platform for building, running, and managing containers.
   - **Podman**: An alternative to Docker, often used for managing containers and pod-like structures.

3. **Features**:
   - **Image Management**: They handle pulling container images from registries, building images from Dockerfiles, and managing image caches.
   - **User Interface**: Provide user-friendly command-line interfaces (CLIs) and APIs for interacting with containers.
   - **Networking**: Set up and manage network configurations for containers, enabling them to communicate with each other and the outside world.
   - **Volume Management**: Manage data volumes and bind mounts for persistent data storage and sharing between containers and host.

4. **Use in Development**: High-level runtimes are commonly used by developers for local development and testing, as they provide an easy-to-use interface for managing containers.

### Low-Level Container Runtimes

1. **Definition**: Low-level container runtimes are more focused on running containers according to the OS-level details. They are responsible for the actual execution of containers and directly interact with the operating system's kernel to manage the container's lifecycle.

2. **Examples**:
   - **containerd**: An industry-standard core container runtime, part of the Cloud Native Computing Foundation (CNCF).
   - **runc**: A CLI tool for spawning and running containers according to the Open Container Initiative (OCI) specification.

3. **Features**:
   - **Execution and Lifecycle Management**: Manage the creation, execution, stopping, and deletion of containers.
   - **Resource Isolation**: Handle CPU, memory, and I/O isolation for containers using cgroups and namespaces in Linux.
   - **Security**: Implement security features like SELinux, AppArmor, and seccomp for container processes.

4. **Use in Orchestration Systems**: Often used as components in larger container orchestration systems like Kubernetes, where they are managed by higher-level tools.

### Interaction between High-Level and Low-Level Runtimes

- In many container ecosystems, high-level and low-level runtimes work together. For example, Docker uses `containerd` as its low-level runtime to execute containers. 
- High-level runtimes manage the user interface and orchestration, while low-level runtimes handle the nuts and bolts of container execution and OS-level interactions.

Understanding the distinction between these two types of runtimes is crucial for anyone working with containerized environments, as it impacts how applications are deployed, scaled, and managed in production.
