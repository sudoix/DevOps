![68-swarm](../.gitbook/assets/68-swarm.png)

# What is docker swarm

Docker Swarm is a container orchestration platform provided by Docker. It allows you to create and manage a cluster of Docker hosts, and deploy and scale containerized applications across the cluster. Docker Swarm provides features such as service discovery, load balancing, rolling updates, and high availability for containers. It is designed to be easy to use and integrates seamlessly with Docker's existing tools and ecosystem.

## Prerequisites

- Docker
- Docker Compose
- Docker Machine

## Docker Swarm architecture

![swarm-architecture](../.gitbook/assets/69-swarm-diagram.webp)

Docker Swarm is a container orchestration tool, which means it allows you to manage multiple Docker hosts as a single virtual system. It's designed to work around four key components, which together provide a streamlined way to deploy, scale, and manage containerized applications. Here's a breakdown of Docker Swarm's architecture and its main components:

1. **Swarm Manager Nodes:**
   - These nodes are responsible for the entire Swarm and handle the orchestration and cluster management tasks. They make decisions about which node runs a container, handle the desired state of the Swarm, and schedule services. There are two types of Swarm managers:
     - **Leader:** Handles all orchestration and management tasks for the Swarm.
     - **Reachable and Unreachable Managers:** Additional manager nodes that can take over if the leader fails.

2. **Worker Nodes:**
   - Worker nodes are responsible for running containerized applications as specified by the Swarm manager. They communicate with the manager nodes to report on the status of tasks assigned to them but do not make scheduling decisions.

3. **Services and Tasks:**
   - **Service:** A service is the definition of the tasks to execute on the Docker Swarm. It defines the container image, ports, and the policy used to scale, update, or roll back the application.
   - **Task:** A task carries a Docker container and commands to run inside the container. It is the smallest unit of deployment, such as a single container running in a Docker Swarm, and is assigned to a node by a Swarm manager.

4. **Registry:**
   - A Docker registry stores Docker images. Docker Swarm nodes communicate with the registry to pull images to run as containers. The most common example of a registry is Docker Hub, but you can also set up your own private registry.

5. **Networking:**
   - Docker Swarm supports overlay networking for services, enabling secure, container-to-container communication across nodes. This is crucial for allowing containers to communicate with each other and for enabling the routing mesh, which makes services accessible from any node regardless of whether they're running on that node.

6. **Routing Mesh:**
   - The routing mesh is a feature that routes requests to the appropriate containers, even if they're not on the node that receives the request. It ensures that every node in the Swarm can accept requests for any service running in the Swarm, thus providing high availability and load balancing.

7. **Swarm Mode:**
   - When Docker runs in Swarm mode, it operates in a cluster management and orchestration features. This mode integrates the functionality of managing a cluster of Docker engines into a single, virtual Docker engine.

In summary, Docker Swarm's architecture simplifies the process of deploying and managing multi-container applications at scale. It uses a combination of manager nodes for orchestration, worker nodes for running applications, services, and tasks for application deployment, and integrated networking and service discovery mechanisms to ensure applications are highly available and accessible.


# Task and scheduling

![task-scheduling](../.gitbook/assets/70-service-lifecycle.webp)

In Docker Swarm, the process of managing and scheduling tasks involves several key components that work together to ensure the efficient deployment and operation of containerized applications across the cluster. Let's break down these components and understand their roles in task management and scheduling within Docker Swarm:

## On manager nodes

### 1. API

- **Role**: Serves as the entry point for users and external tools to interact with the Docker Swarm cluster. It accepts commands and configurations, such as service creation, updates, and deletions.
- **Function**: Translates user requests into actionable tasks, updates the desired state of the cluster, and triggers the orchestration process to implement these changes.

### 2. Orchestrator

- **Role**: The core component responsible for ensuring that the cluster's actual state matches the desired state specified by the user.
- **Function**: Manages the lifecycle of services and tasks. When a service is defined or updated, the orchestrator decides what actions are needed to achieve the desired state, such as creating new tasks, removing obsolete ones, or updating existing tasks.

### 3. Allocator

- **Role**: Responsible for assigning resources to tasks, such as IP addresses for the containers and ensuring that each task has the necessary resources allocated before it's scheduled on a node.
- **Function**: Works closely with the orchestrator to prepare tasks for execution, ensuring they are properly configured with all necessary resources. This process must be completed before tasks are dispatched.

### 4. Dispatcher

- **Role**: Acts as the bridge between the cluster management layer and the nodes in the cluster.
- **Function**: Responsible for assigning tasks to nodes. It monitors the heartbeats of worker nodes to manage their availability status and assigns tasks to healthy nodes. The dispatcher ensures that the scheduler's decisions are implemented by delivering tasks to the appropriate nodes.

### 5. Scheduler

- **Role**: Determines where in the cluster a task should run by selecting the most appropriate node based on various criteria.
- **Function**: Evaluates the cluster's current state, including resource availability, node health, and user-defined constraints (affinities, labels, etc.), to make intelligent scheduling decisions. It aims to balance the load across the cluster and respect the constraints defined in service specifications.

## On worker nodes

### 6. Worker

- **Role**: Represents the nodes (either manager nodes acting as workers or dedicated worker nodes) that execute the containerized tasks.
- **Function**: Executes the tasks assigned to it by the dispatcher, running the container instances as specified in the task. Workers report the status of their tasks back to the manager nodes, enabling the cluster to monitor and manage task health and lifecycle.

### 7. Executor

- **Role**: A component within the worker node that is responsible for running the tasks.
- **Function**: Interacts with the Docker Engine to start, stop, and manage container instances according to the tasks assigned to the worker node. The executor ensures that the containers are run with the correct configurations and resources as defined by their tasks.

In summary, these components work together in a Docker Swarm cluster to automate the deployment, scaling, and management of containerized applications. The API accepts user commands, the orchestrator manages the desired state, the allocator assigns resources, the dispatcher distributes tasks, the scheduler selects appropriate nodes, and the worker nodes, through their executors, run the tasks, maintaining a responsive and resilient system.
