# pod

In Kubernetes, a Pod is the smallest and most basic unit. It represents a single instance of a running process in a cluster. A Pod can contain one or more containers, which are tightly coupled and share the same network and storage resources. Containers within a Pod can communicate with each other using localhost.

Pods are designed to be ephemeral, meaning they can be created, destroyed, and replaced as needed. They are scheduled onto Nodes (servers) in the cluster by the Kubernetes scheduler.

Pods provide a layer of abstraction for managing containers and enable scaling, load balancing, and self-healing capabilities in Kubernetes.