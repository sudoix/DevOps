
## Limiting Resources

Limiting resources in Docker is essential for ensuring that no single container can monopolize system resources, such as CPU, memory, and I/O, which can lead to degraded performance or system instability. Docker provides several options to limit resources for containers, which can be specified when you run a container using the `docker run` command. Here are some of the key resource constraints you can apply:

### CPU Limitation

- **Limit CPU usage**: You can limit the CPU usage of a container to a certain percentage of a single core using the `--cpu-shares` option. This option does not prevent containers from using more CPU resources when the system is idle but provides a way to prioritize container CPU resources under load.

    ```
    docker run -dit --cpu-shares 512  <image> # 512 is default value and max size is 1024
    ```

- **Limit CPU cores**: Use the `--cpus` option to specify the number of CPU cores a container can use. For instance, if you want a container to use at most two cores, you can start it with:

    ```
    docker run -dit --cpus 1.0  <image> # assign 1 cpu to container
    ```

### Memory Limitation

- **Limit memory usage**: The `--memory` (or `-m`) option allows you to limit the maximum amount of memory the container can use. If a container exceeds this limit, it might be terminated.

    ```
    docker run -dit --memory 1g <image>
    ```

- **Limit memory reservation**: The `--memory-reservation` option sets the maximum amount of memory that can be reserved for the container. If a container exceeds this limit, it might be terminated.

    ```
    docker run -dit --memory-reservation 150m --memory 200m <image>
    ```

example

```bash
docker run -dir --name nginx1 --memory 200m --memory-reservation 150m  --cpu-shares 256 nginx:latest
```

```bash
docker stats
```


### Applying Limits in Docker Compose

These resource limits can also be specified in a `docker-compose.yml` file for Docker Compose-managed containers. For example, to limit memory and CPU for a service:

```yaml
version: '3'
services:
  web:
    image: <image>
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 50M
```

Remember that resource constraints can affect the performance and stability of your applications, so it's important to set these limits thoughtfully based on the application's requirements and available system resources.