# Llama-cpp-Rpi-cluster

## Environment Setup

* Docker
```
sudo apt-get update
sudo apt-get install docker.io
sudo usermod -aG docker $USER
```
* Minicube: 管理Kubernetes
```
sudo apt-get install -y curl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start --driver=docker --force (if not root, don't use force)

```

* Kubernetes 

```
sudo snap install kubectl --classic
kubectl cluster-info
kubectl apply -f https://raw.githubusercontent.com/volcano-sh/volcano/master/installer/volcano-development.yaml
```

## Build Dockerfile
```
docker build -t llama_cluster_image .
docker images
```

`docker run -it --rm llama_cluster_image`

## Test Llama.cpp



2. **Install via Helm**:
   - Add Volcano’s Helm repository and install it using:
     ```bash
     helm repo add volcano-sh https://volcano-sh.github.io/helm-charts
     helm install volcano volcano-sh/volcano -n volcano-system --create-namespace
     ```

More detailed instructions are available on [Volcano GitHub](https://github.com/volcano-sh/volcano).