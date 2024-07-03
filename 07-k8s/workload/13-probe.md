In Kubernetes, probes are used to determine the health of a container. There are three types of probes:

1. **Liveness Probe**: Determines if a container is running. If the liveness probe fails, the kubelet kills the container, and the container is subject to the pod's restart policy.
2. **Readiness Probe**: Determines if a container is ready to start accepting traffic. If the readiness probe fails, the endpoints controller removes the pod's IP address from the endpoints of all services that match the pod.
3. **Startup Probe**: Used to check if the application within the container has started. This is useful for applications that have a longer startup time.

### Adding Probes to a Kubernetes Deployment

Here’s an example of how to add liveness, readiness, and startup probes to a Kubernetes Deployment for an NGINX server.

#### Step 1: Create a ConfigMap for NGINX Configuration (optional)

If you need a custom NGINX configuration, create a ConfigMap. If not, you can skip this step.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
data:
  nginx.conf: |
    server {
        listen 80;
        server_name localhost;

        location / {
            root   /usr/share/nginx/html;
            index  index.html index.htm;
        }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }
    }
```

Apply the ConfigMap:

```sh
kubectl apply -f nginx-configmap.yaml
```

#### Step 2: Create the NGINX Deployment with Probes

Create a `nginx-deployment.yaml` file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
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
        image: nginx:latest
        ports:
        - containerPort: 80
        volumeMounts:
        - name: nginx-config-volume
          mountPath: /etc/nginx/nginx.conf
          subPath: nginx.conf
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 5
          periodSeconds: 5
        startupProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 0
          periodSeconds: 10
          failureThreshold: 30
      volumes:
      - name: nginx-config-volume
        configMap:
          name: nginx-config
```

Apply the Deployment:

```sh
kubectl apply -f nginx-deployment.yaml
```

### Explanation

- **livenessProbe**:
  - Checks the health of the container by sending an HTTP GET request to the root path `/` on port 80.
  - `initialDelaySeconds: 30`: Waits for 30 seconds after the container starts before performing the first probe.
  - `periodSeconds: 10`: Performs the probe every 10 seconds.

- **readinessProbe**:
  - Checks if the container is ready to accept traffic by sending an HTTP GET request to the root path `/` on port 80.
  - `initialDelaySeconds: 5`: Waits for 5 seconds after the container starts before performing the first probe.
  - `periodSeconds: 5`: Performs the probe every 5 seconds.

- **startupProbe**:
  - Used to check if the application within the container has started by sending an HTTP GET request to the root path `/` on port 80.
  - `initialDelaySeconds: 0`: Starts checking immediately after the container starts.
  - `periodSeconds: 10`: Performs the probe every 10 seconds.
  - `failureThreshold: 30`: If the probe fails 30 times, the container is killed. This gives a total of 5 minutes (30 * 10 seconds) for the startup probe to succeed.

By using these probes, Kubernetes can ensure that the NGINX server is running correctly, is ready to serve traffic, and has started properly before starting readiness and liveness checks.