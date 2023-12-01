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