### first command for initializing the kubernetes cluster

`kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr 10.5.0.0/16`

### second command for applying the networking of the cluster
`kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml`

### third command for adding new worker nodes
`kubeadm join 192.168.0.23:6443 --token ktpntf.daqxp1tdevt0cqya --discovery-token-ca-cert-hash sha256:d27c797259bb9e20df8fe4ccb0b482daf4048dccb8014a2049fe32468358a495 `

### List available nodes in the cluster
`kubectl get nodes`

### Check the status of the minikube cluster with the name
`minikube status -p <cluster-name>`

### Add new worker node to the minikube cluster
`minikube node add --worker -p minikube`

### delete an existing node from the minikube cluster
`minikube node delete <node-name> -p minikube`

### view the minikube dashboard
`minikube dashboard -p <cluster-name>`

### get service url from minikube
`minikube service <service-name> --url`

### open service directly
`minikube service <service-name>`

### open ingress resource from browser in windows. Use the `127.0.0.1` at the hosts file instead of the minikube IP
`minikube tunnel`