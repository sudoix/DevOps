pod --> replicaset --> deployment --> daemonset --> 


For see all kubernetes resources you can use:

```
k api-resources --namespaced=true
k api-resources
```

For see all kubernetes resources operations you can use:

```
k explain <resource>
k explain pod
```

For explain more information you can use:

```
k explain pod.metadata
```

For scaling up and down ReplicaSets you can use:

```
k scale rs <name> --replicas=3
```

For execute commands on your pod you can use:

```
k exec <pod-name> -- <command>
k exec test -- nginx -v
```

For rolling back your pod you can use:

```
k rollout undo deployment <name>
```

For checking history of your deployment you can use:

```
k rollout history deployment <name> --revision
```

For rolling out your deployment you can use:

```
k rollout undo deployment <name> --to-revision=2
```

#### website

https://k8s-examples.container-solutions.com/
https://k8syaml.com/
Kampose 

