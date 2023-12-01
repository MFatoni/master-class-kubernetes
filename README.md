"# master-class-kubernetes"

configuration file -> kubernetes master -> kubernetes workers
kubernetes cluster -> kubernetes master -> kubernetes workers

![kubernetes architectures](https://kubernetes.io/images/docs/kubernetes-cluster-architecture.svg)

components on master 

kube-apiserver -> api for interact with kubernetes cluster
etcd -> database for kubernetes cluster data
kube-scheduler -> monitor app, ask node to run the app
kube-controller-manager -> kubernetes cluster controller
cloud-controller-manager -> cloud provider controller

components on node

kubelet -> make sure the app running (controller by kube-controller-manager)
kube-proxy -> proxy and load balancer
container-manager -> managing container like docker, containerd, cri-o, rktlet, etc

developer -> image registry -> configuration file -> kubernetes master (received by kube-apiserver) -> kubernetes workers -> kubelet -> docker -> image registry

node

node / minion -> worker machine in kubernetes
node can be a vm or physical machine
inside node always contains kubelet, kube-proxy, container manager


```
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server --disable=traefik --docker" sh -
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo apt-get -y install socat
```

> install k3s.

```
/usr/local/bin/k3s-uninstall.sh
```

> uninstall k3s.

```
kubectl get node
```

> see all node.

```
kubectl describe node _node_name
```

> see node description.

Pod

pod -> the smallest unit that can be deployed on kubernetes
pod can be contained more than 1 container
pod = our application that running on kubernetes cluster


```
kubectl get pod
kubectl get pod -o wide
```

> see all pod.

```
kubectl describe pod _pod_name
```

> see pod description.

```
kubectl create -f _file_name.yaml
```

> create pod.

```
kubectl port-forward --address 0.0.0.0 _pod_name _external_port:_internal_port 
```

> forward port.

label -> add mark to the pod, organize pod, space is not allowed, label also available on another resource such as replication controller, replica set, service, etc

```
kubectl get pod --show-labels
```

> show pod labels


```
kubectl label pod _pod_name _key=_value --overwrite
```

> add / update pod labels

```
kubectl get pods -l key
kubectl get pods -l key=value
kubectl get pods -l ‘!key’
kubectl get pods -l key!=value
kubectl get pods -l ‘key in (value1,value2)’
kubectl get pods -l ‘key notin (value1,value2)’
kubectl get pods -l key,key2=value
kubectl get pods -l key=value,key2=value
```

> querying pod.

annotation -> cant filter by using annotation, usually used to add description, have a max size of 256kb


```
kubectl annotate pod _pod_name _key=_value --overwrite
```

> add / update pod annotation