helm repo add k8s-dashboard https://kubernetes.github.io/dashboard

helm install my-kubernetes-dashboard k8s-dashboard/kubernetes-dashboard --version 7.5.0

kubectl expose deployment my-kubernetes-dashboard-kong --name my-new-k8s --target-port 8443 --port 8081 --type NodePort
service/my-new-k8s exposed

```
helm pull bitnami/kube-prometheus

helm upgrade --install -n video-db ai-mongo ./deployment/mongo/production/mongodb  -f deployment/mongo/production/mongodb/values.yaml
```

### Install ingress nginx controler

- Add ingress nginx helm repo

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/sudoix/.kube/sudoix
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/sudoix/.kube/sudoix
"ingress-nginx" has been added to your repositories
```

```
helm repo list

helm search repo ingress-nginx
```

pull helm chart

```
helm pull ingress-nginx/ingress-nginx
```

```
tar -xzvf ingress-nginx-4.10.1.tgz
```

