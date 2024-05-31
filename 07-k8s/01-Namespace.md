![namespace](../assets/81-linux-namespace1.png)

In Linux, a **namespace** is a feature that partitions kernel resources so that one set of processes sees one set of resources while another set of processes sees a different set of resources. The resources being partitioned include, among others, the process IDs, hostnames, user IDs, file names, and network access. This allows for creating isolated environments within the same Linux instance, akin to lightweight virtualization.

Namespaces are a foundational technology for containers in Linux, allowing containers to operate independently without interfering with each other, even though they run on the same physical machine or the same instance of the Linux kernel. Here’s a brief overview of some key types of namespaces:

1. **PID (Process ID) Namespace**: Isolates the process ID number space, meaning processes in different PID namespaces can have the same PID. This is useful for process isolation and is critical for container technologies like Docker.

2. **Network Namespace**: Provides isolated network environments, including IP addresses, routing tables, port numbers, etc. Each network namespace has its own network devices, ports, and routing tables.

3. **Mount Namespace**: Isolates filesystem mount points seen by a group of processes. This allows the processes to have different views of the filesystem hierarchy.

4. **UTS (UNIX Time-sharing System) Namespace**: Allows a single system to appear to have different host and domain names to different processes.

5. **User Namespace**: Isolates user and group IDs. This means that a process can have a non-privileged user on the host but have root privileges inside the namespace, enhancing security.

6. **IPC (Interprocess Communication) Namespace**: Isolates interprocess communication between processes.

By using namespaces, system administrators and software developers can create environments that are secure and isolated from the rest of the system, preventing processes from interfering with each other and improving security and stability. This concept is crucial in the deployment and management of containerized applications, as seen in platforms like Kubernetes.


## Cgroups

In Linux, **cgroups** (short for control groups) is a kernel feature that limits, accounts for, and isolates the resource usage (CPU, memory, disk I/O, network, etc.) of a collection of processes. This technology is integral to implementing resource management and isolation functionalities in the Linux kernel.

Here’s a breakdown of what cgroups provide and how they are used:

1. **Resource Limiting**: Cgroups allow you to allocate resources—like CPU time, system memory, network bandwidth, or combinations of these resources—among user-defined groups of tasks (processes). You can control how much of a system’s resources a process or a group of processes can consume. If a process tries to use more than its allocated share, it will be throttled back.

2. **Prioritization**: Using cgroups, system administrators can set up priorities among different groups of processes. This is particularly useful in environments where multiple applications or services are running on the same server, and some services are prioritized over others.

3. **Accounting**: Cgroups provide detailed accounting for the resources used by different groups of processes. This is crucial for system monitoring, debugging, and performance tuning. It can also be used for billing purposes, especially in multi-tenant environments like cloud services.

4. **Control**: Beyond just tracking and limiting resource use, cgroups allow you to enforce policies and manage system resources dynamically. You can freeze groups of processes, restart them, and dynamically change their resource limits as system conditions change.

5. **Isolation**: Cgroups complement namespaces by not only isolating the view of the system environment (namespaces) but also controlling the amount of resources each isolated environment can use. This combination forms the backbone of container technologies like Docker and is also used in virtualization scenarios.

Cgroups are configured and managed via a pseudo-filesystem, typically mounted under `/sys/fs/cgroup`. Each resource controller (for CPU, memory, etc.) has its own directory where the limitations and usage statistics are managed and monitored.

Overall, cgroups are essential for resource management in Linux, providing the tools needed to manage workloads on a system effectively, ensuring that applications behave as expected without interfering with each other's operations.