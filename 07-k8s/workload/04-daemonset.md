# DaemonSet

In Kubernetes, a DaemonSet is a type of workload object that ensures that a specific pod is running on each node in a cluster. It is useful for running system daemons or cluster-wide tasks. The DaemonSet controller automatically creates and manages the pods, ensuring that there is one pod on each node and that new pods are created if new nodes are added to the cluster.

DaemonSet in Kubernetes, summarized in bullet points:

Ensures that a specific pod is running on each node in a cluster.
Manages the lifecycle of the pods, including creation, deletion, and scaling.
Monitors the nodes and ensures that the desired number of pods is always running.
Automatically creates pods on new nodes added to the cluster.
Commonly used for running system daemons, log collectors, monitoring agents, or any workload that needs to be deployed on every node in a Kubernetes cluster.


```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
    name: nginx
spec:
    selector:
        matchLabels:
            app: nginx
    template:
        metadata:
            labels:
                app: nginx
        spec:
            containers:
            - name: nginx
                image: nginx

```