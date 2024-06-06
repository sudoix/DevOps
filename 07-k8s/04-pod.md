# What is pod

In Kubernetes, a **pod** is the smallest and most basic deployable object. It represents a single instance of a running process in your cluster. Pods contain one or more containers, such as Docker containers. Here’s what makes pods crucial in Kubernetes:

1. **Container grouping**: Each pod can contain multiple containers that need to work together. These containers share resources like networking and storage, allowing them to communicate with each other efficiently.

2. **Resource sharing**: Containers in a pod share an IP address, port space, and volume mounts, allowing them to communicate through `localhost` and share data through shared volumes.

3. **Management and lifecycle**: Pods are ephemeral by nature. They are typically managed by higher-level Kubernetes constructs like Deployments or StatefulSets. If a pod fails, Kubernetes can automatically create a new one to replace it, maintaining the desired state.

4. **Atomic unit of scaling**: Pods are the smallest unit you scale in Kubernetes. When you need more capacity, Kubernetes doesn’t scale individual containers but rather scales pods.

Pods are designed to run multiple containers that need to work together (like an application and its logging sidecar), but it's generally best practice to keep pods as minimal as possible to leverage Kubernetes’ ability to manage and scale pods efficiently.

# Pod life cycle

![83-pod](../assets/83-pod.webp)

In Kubernetes, the life cycle of a pod is defined by various states it passes through from creation to termination. Understanding these states helps manage applications effectively. Here’s a detailed overview of the pod lifecycle:

1. **Pending**: When a pod is first created, it enters the "Pending" state. During this phase, the Kubernetes scheduler selects a suitable node for the pod to run on, and the pod remains in the pending state until all its necessary resources, like network configurations and storage volumes, are set up. If there’s an issue in scheduling the pod (due to resource constraints, for instance), it will remain in this state.

2. **Running**: Once the pod is scheduled on a node and all its containers are created and at least one container is still running, the pod's status moves to "Running". This state also includes the time during which the pod might be starting up its containers.

3. **Succeeded**: This state means that all containers in the pod have terminated successfully, and will not be restarted. This status is typical for short-lived processes.

4. **Failed**: If any of the containers in the pod exits with a non-zero status (indicating failure), and the container is not set to restart, the pod's status is marked as "Failed".

5. **Unknown**: This is a state where the status of the pod could not be obtained. This situation can occur due to an error in communication with the node where the pod is running.

6. **CrashLoopBackOff**: While not an official phase in the pod lifecycle, this is a common status seen when a pod fails to start its containers repeatedly due to an error. Kubernetes attempts to restart the container, but if the problem persists, it enters a back-off loop.

### Lifecycle Hooks

Kubernetes also provides lifecycle hooks that can be utilized to execute code at specific points in a container’s lifecycle:

- **PostStart**: This hook executes immediately after a container is created. However, there is no guarantee that the hook will execute before the container’s entrypoint/command is called.
  
- **PreStop**: This hook is called immediately before a container is terminated. It can be used to gracefully shut down processes or perform cleanup tasks.

These hooks help manage the application’s state and resources more effectively during startups and shutdowns.

Understanding these phases and hooks is crucial for effectively managing pods and ensuring that your applications run smoothly in a Kubernetes environment.
