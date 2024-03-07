# Swarm stack

A Docker Swarm stack is a group of interrelated services that share dependencies and are orchestrated and managed together in a Docker Swarm environment. Stacks make it easier to deploy, manage, and scale multi-service applications as a single entity. They are defined using Docker Compose files, which specify all the services, networks, and volumes that make up the application. This allows for complex applications to be described in a single, declarative file, making deployment and management more straightforward and consistent.

### Key Concepts of Docker Swarm Stacks:

- **Compose File**: Docker stacks are defined using Docker Compose files (YAML file format), which are used to describe the desired state of your application's services, networks, and volumes. The same Compose file format is used for both single-node development environments (with Docker Compose) and multi-node production environments (with Docker Swarm).

- **Services**: Within a stack, services define the containers that need to be run. Each service can represent a part of an application. For example, a web application stack might have services for the web frontend, backend API, and database.

- **Networks**: Stacks allow you to define custom networks for communication between the services. Overlay networks are commonly used in Swarm stacks to enable service discovery and secure communication between services on different nodes.

- **Volumes**: For persistent data storage, stacks can define volumes that are mounted into services. Volumes can be used for databases, file storage, and any other stateful parts of your application.

### Deploying a Stack:

To deploy a stack, you use the `docker stack deploy` command, specifying the name of the stack and the Compose file that defines it. For example:

```sh
docker stack deploy -c docker-compose.yml my_stack
```

This command tells Docker to deploy the stack named `my_stack` using the service, network, and volume definitions found in `docker-compose.yml`.

### Advantages of Using Docker Swarm Stacks:

- **Simplified Management**: By grouping services into stacks, you can manage related services as a unit, simplifying tasks such as deployment, updates, and scaling.

- **Consistency**: Stacks ensure that your application is deployed consistently across all nodes in the Swarm, as defined in the Compose file. This reduces the chances of configuration errors.

- **Scalability**: With Docker Swarm's built-in orchestration capabilities, you can easily scale services within a stack up or down based on demand, directly from the Compose file or with CLI commands.

- **Portability**: Since stacks are defined in Compose files, they can be easily ported and deployed across different environments, from development to production, provided the underlying services are compatible.

Docker Swarm stacks offer a powerful abstraction for deploying complex, multi-service applications in a clustered environment, leveraging Docker Swarm's native clustering, scheduling, and networking capabilities to provide a seamless, scalable deployment experience.


### scale stack

```sh
docker stack scale my_stack=3
```

and for service

```sh
docker service ls

docker service scale my_stack_service=3
```

