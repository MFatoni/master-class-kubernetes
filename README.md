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

> install k3s

```
/usr/local/bin/k3s-uninstall.sh
```

> uninstall k3s

```
kubectl get node
```

> see all node

```
kubectl describe node _node_name
```

> see node description

Pod

pod -> the smallest unit that can be deployed on kubernetes
pod can be contained more than 1 container
pod = our application that running on kubernetes cluster


```
kubectl get pod
kubectl get pod -o wide
```

> see all pod

```
kubectl describe pod _pod_name
```

> see pod description

```
kubectl create -f _file_name
```

> create pod

```
kubectl delete pod _pod1_name _pod2_name _pod3_name
kubectl delete pod -l _key=_value
kubectl delete pod --all --namespace _namespace
```

> delete pod

```
kubectl port-forward --address 0.0.0.0 _pod_name _external_port:_internal_port 
```

> forward port

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
kubectl get pods -l _key
kubectl get pods -l _key=_value
kubectl get pods -l ‘!_key’
kubectl get pods -l _key!=_value
kubectl get pods -l ‘_key in (_value1,_value2)’
kubectl get pods -l ‘_key notin (_value1,_value2)’
kubectl get pods -l _key,_key2=_value
kubectl get pods -l _key=_value,_key2=_value
```

> querying pod

annotation -> cant filter by using annotation, usually used to add description, have a max size of 256kb


```
kubectl annotate pod _pod_name _key=_value --overwrite
```

> add / update pod annotation

namespace -> to separate resource for multi tenant, team, environment, resources can have a same name in different namespace, pod in different namespace can communicate

```
kubectl get namespaces
kubectl get namespace
kubectl get ns

kubectl get pod --namespace _namespace
kubectl get pod -n _namespace
```

> see namespaces

```
kubectl create -f _file_name --namespace _namespace
```

> create pod on namespace

```
kubectl delete namespace _namespace
```

> delete namespace, and all the pod inside of it

probe -> liveness, readiness, startup probe

kubelet check when should kubelet restart pod using liveness probe
kubelet check is pod ready to received the traffic using readiness probe. there wont be any incoming traffic if not ready.
kubelet check is pod ready to run. if it is not ready, liveness and readiness checking wont be conducted.

probe mechanism -> http get, tcp socket, command exec

replication controller 
responsible to always make the pod is running
if pod missing, if there is node off, replication controller will automatically run that pod
replication controller usually handle more than 1 pod
replication controller will always make sure the running pod have a same with the selected number

replication controller components
label selecter, pod marker
replica count, total pod that should be running
pod template, template to run the pod

```
kubectl get replicationcontrollers
kubectl get replicationcontroller
kubectl get rc
```

> see replication controller

```
kubectl delete rc _replication_controller_name --cascade=true
```

> delete replication controller. if cascade is set to true, all pod will be also deleted.

replica set -> new generation of replication controller (more expresive controller)

matchLabels == replication controller
match = In, NotIn, Exist, NotExists

daemon set
replica set will randomly select the node
if wanna run pod in each node, and the pod should only run 1 each node, daemon set can be utilized
daemon set will run pod on each pod by default

```
kubectl get daemonsets
```

> see daemon set

```
kubectl delete daemonsets _daemonsets_name
```

> delete daemon set

job -> run pod once
cron job -> scheduled job (crontab.guru)

```
kubectl logs _resource_name
```

> see logs

node selector -> ask kubernetes to run on specific node

```
kubectl label node _node_name _key=_value
```

> add label to node

```
kubectl get all
kubectl get all --namespace _namespace
```
   
> show all resources

```
kubectl delete all --all                          
kubectl delete all --all --namespace _namespace
```

> delete all resources

service -> gate that can be used for accessing 1 or more pod, service ip wont be change, service will equal distribute the request to all pod, 
service use label selector

```
kubectl apply -f _file_name
kubectl get service
kubectl describe service _service_name
kubectl delete service _service_name
```

> service command

```
kubectl exec _pod_name -it -- /bin/sh
```

> access the pod

```
kubectl exec _pod_name -it -- env
```

> show all info variable

dns of service -> _service_name._namespace_name.svc.cluster.local:_port

> access the pod

```
kubectl get endpoints
```

> show all endpoints

```
kubectl describe service _service_name
kubectl get endpoints _service_name
```

> show service endpoints

service type -> ClusterIP, ExternalName, NodePort, LoadBalancer

ClusterIP expose service for internal kubernetes
ExternalName mapping to external endpoint
NodePort expose node ip and port
LoadBalancer expose to external for using LoadBalancer

expose service 
NodePort -> service
LoadBalancer -> NodePort -> service
ingress -> service (http only)

volume -> emptyDir, hostPath, gitRepo, nfs
volume can be shared between container on pod

env -> cant be reused
configMap -> can be reused, contained unsensitive value
secret -> contained sensitive value, only distribute into the node that required the value, value is encrypted, stored on memory not in physical storage 

```
kubectl create -f _file_name
kubectl get configmaps
kubectl describe configmap _configmap_name
kubectl delete configmap _configmap_name
```

> configmap command

```
kubectl create -f _file_name
kubectl get secret
kubectl describe secret _secret_name
kubectl delete secret _secret_name
```

> secret command

downward api -> get information about node and pod
list downward api information

```
requests.cpu
requests.memory
limits.cpu
limits.memory
metadata.name
metadata.namespace
metadata.uid
metadata.labels[‘<KEY>’]
metadata.annotations[‘<KEY>’]
status.podIP
spec.serviceAccountName
spec.nodeName
status.hostIP
```

imperative management

```
kubectl create -f _file_name
kubectl replace -f _file_name
kubectl get -f _file_name -o yaml/json
kubectl delete -f _file_name
```

declarative management -> configuration file will be saved on annotations

```
kubectl apply -f _file_name 
```

> create and update kubernetes object

deployment -> create ReplicaSet -> create Pod

```
kubectl apply -f _file_name
kubectl get deployments
kubectl describe deployment _deployment_name
kubectl delete deployment _deployment_name
```

> deployment command

