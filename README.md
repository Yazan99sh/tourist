# tourist (Yazan forks)

## Build Process

1. Build Config Image
2. Build Project Images
3. Deploy it using the files in GKE folder



## How

to build config files:

```bash
docker build ./dev_symfony -f ./dev_symfony/config.Dockerfile -t gcr.io/tourists-280412/config:latest
docker push gcr.io/tourists-280412/config:latest
```

Then build server container

```bash
docker build ./dev_symfony -f ./dev_symfony/server.Dockerfile -t gcr.io/tourists-280412/server-container:latest
docker push gcr.io/tourists-280412/server-container:latest

docker build ./nginx -t gcr.io/tourists-280412/tourists-server:latest
docker push gcr.io/tourists-280412/tourists-server:latest
```



**NOTE** the image `dockerfile` needs to be modified to get the correct config image file. and GKE K8s config files



we then deploy using:

```bash
# ******************* MySQL *******************
# Using Helm V3
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install tourists bitnami/mysql
# For AKS use https://bitnami.com/stack/mysql/helm

# *******************  PVC  *******************
# Use the provider version of the pressitance volume claim
kubectl create -f ./GKE/tourists-claim.yaml


# ******************* Server *******************
# Deploy Backend
kubectl create -f ./GKE/backend-service.yaml # I'm using the service as a balancer here
kubectl create -f ./GKE/backend-deployment

```



## Migrations

first we need a pod name, we can do that using

```bash
kubectl get pods
```

once we get the name, we can use the following:

```bash
kubectl exec -it <pod_name> --container nginx -- start-point # To prepair PVC
kubectl exec -it <pod_name> --container php -- sh
# Inside the contaienr
cd tourists
php bin/console doctrine:migration:migrate
exit
```

Done!
