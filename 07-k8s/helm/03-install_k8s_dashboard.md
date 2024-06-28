helm repo add k8s-dashboard https://kubernetes.github.io/dashboard

helm install my-kubernetes-dashboard k8s-dashboard/kubernetes-dashboard --version 7.5.0

kubectl expose deployment my-kubernetes-dashboard-kong --name my-new-k8s --target-port 8443 --port 8081 --type NodePort
service/my-new-k8s exposed

```
helm pull bitnami/kube-prometheus

helm upgrade --install -n video-db ai-mongo ./deployment/mongo/production/mongodb  -f deployment/mongo/production/mongodb/values.yaml
```