## Kubernetes Architecture - Detailed Explanation

### Overview
- [Kubernetes Architecture](#kubernetes-architecture)
  - [Control Plane](#control-plane)
  - [Worker Node](#worker-node)
- [Kubernetes Control Plane Components](#kubernetes-control-plane-components)
- [Kubernetes Worker Node Components](#kubernetes-worker-node-components)
- [Kubernetes Cluster Addon Components](#kubernetes-cluster-addon-components)
- [References](#references)

### Kubernetes Architecture
- The first and foremost thing you should understand about Kubernetes is, it is a `distributed system`.
- Meaning, it has multiple components spread across different servers over a network.
- These servers could be Virtual machines or bare metal servers.
- We call it a Kubernetes cluster.
- A Kubernetes cluster consists of control plane nodes and worker nodes.

### Control Plane
The control plane is responsible for container orchestration and maintaining the desired state of the cluster.
It has the following components:
1. kube-api-server
2. etcd
3. kube-scheduler
4. kube-controller-manager
5. cloud-controller-manager

### Worker Node
The Worker nodes are responsible for running containerized applications.
The worker Node has the following components:
1. kubelet
2. kube-proxy
3. Container runtime

### Kubernetes Control Plane Components
- **kube-api-server**
  - The `kube-api server` is the central hub of the Kubernetes cluster that exposes the Kubernetes API.
  - End users, and other cluster components, talk to the cluster via the API server.
  - Very rarely monitoring systems and third-party services may talk to API servers to interact with the cluster.
  - So when you use kubectl to manage the cluster, at the backend you are actually communicating with the API server through **HTTP REST APIs**.
  - However, the internal cluster components like the scheduler, controller talk to the API server using **gRPC**.
  - The communication between the API server and other components in the cluster happens over TLS to prevent unauthorized access to the cluster.
- **etcd**
  - Kubernetes is a distributed system, and it needs an efficient distributed database like `etcd` that supports its distributed nature.
  - It acts as both a backend service discovery and a database.
  - You can call it the brain of the Kubernetes cluster.
  - `etcd` is an open-source strongly consistent, distributed key-value store.
  - Characteristics of the `etcd`:
    - **Strongly consistent**: If an update is made to a node, strong consistency will ensure it gets updated to all the other nodes in the cluster immediately.
    - **Distributed**: etcd is designed to run on multiple nodes as a cluster without sacrificing consistency.
    - **Key Value Store**: A non-relational database that stores data as keys and values. It also exposes a key-value API. The datastore is built on top of `BboltDB` which is a fork of `BoltDB`.
  - To put it simply, when you use kubectl to get kubernetes object details, you are getting it from etcd.
  - Also, when you deploy an object like a pod, an entry gets created in etcd.
  - etcd stores all configurations, states, and metadata of Kubernetes objects (pods, secrets, daemonsets, deployments, configmaps, statefulsets, etc).
  - Also, etcd it is the only `Statefulset` component in the control plane
- **kube-scheduler**
  - The kube-scheduler is responsible for scheduling Kubernetes pods on worker nodes.
  - When you deploy a pod, you specify the pod requirements such as CPU, memory, persistent volumes (PV), etc. The scheduler’s primary task is to identify the create request and choose the best node for a pod that satisfies the requirements.
  - In a Kubernetes cluster, there will be more than one worker node. Here is how the scheduler selects the best node out of all worker nodes:
    - To choose the best node, the Kube-scheduler uses **filtering** and **scoring** operations.
    - In **filtering**, the scheduler finds the best-suited nodes where the pod can be scheduled.
    - In the **scoring** phase, the scheduler ranks the nodes by assigning a score to the filtered worker nodes.
    - Finally, the worker node with the highest rank will be selected for scheduling the pod.
    - Once the node is selected, the scheduler creates a binding event in the API server. Meaning an event to bind a pod and node.
- **Kube Controller Manager**
  - In Kubernetes, controllers are control loops that watch the state of your cluster, then make or request changes where needed.
  - Each controller tries to move the current cluster state closer to the desired state.
  - **Kube controller manager** is a component that manages all the Kubernetes controllers.
  - Kubernetes' resources/objects like pods, namespaces, jobs, replicaset are managed by respective controllers.
  - Also, the kube scheduler is also a controller managed by Kube controller manager.
  - The Kube controller manager manages all the controllers and the controllers try to keep the cluster in the desired state.
  - You can extend kubernetes with **custom controllers** associated with a custom resource definition.
  - Following is the list of important built-in Kubernetes controllers:
    - `Deployment controller`
    - `Replicaset controller`
    - `DaemonSet controller`
    - `Job Controller`
    - `CronJob Controller`
    - `endpoints controller`
    - `namespace controller`
    - `service accounts controller`
    - `Node controller`
- **Cloud Controller Manager (CCM)**
  - When kubernetes is deployed in cloud environments, the cloud controller manager acts as a bridge between Cloud Platform APIs and the Kubernetes cluster.
  - This way the core kubernetes core components can work independently and allow the cloud providers to integrate with kubernetes using plugins.
  - Cloud controller integration allows Kubernetes cluster to provision cloud resources like instances (for nodes), Load Balancers (for services), and Storage Volumes (for persistent volumes).
  - Cloud Controller Manager contains a set of cloud platform-specific controllers that ensure the desired state of cloud-specific components (nodes, Load balancers, storage, ...)
  - Following are the three main controllers that are part of the cloud controller manager:
    - **Node controller**: This controller updates node-related information by talking to the cloud provider API. For example, node labeling & annotation, getting hostname, CPU & memory availability, nodes health, etc.
    - **Route controller**: It is responsible for configuring networking routes on a cloud platform. So that pods in different nodes can talk to each other.
    - **Service controller**: It takes care of deploying load balancers for kubernetes services, assigning IP addresses, etc.

### Kubernetes Worker Node Components
- **kubelet**
  - Kubelet is an agent component that runs on every node in the cluster.
  - It does not run as a container instead runs as a daemon, managed by systemd.
  - kubelet is responsible for the following:
    - Creating, modifying, and deleting containers for the pod.
    - Responsible for handling liveliness, readiness, and startup probes.
    - Responsible for Mounting volumes by reading pod configuration and creating respective directories on the host for the volume mount.
    - Collecting and reporting Node and pod status via calls to the API server
- **Kube proxy**
  - Kube-proxy is a daemon that runs on every node as a `daemonset`.
  - It is a proxy component that implements the Kubernetes Services concept for pods (single DNS for a set of pods with load balancing).
  - It primarily proxies UDP, TCP, and SCTP and does not understand HTTP.
  - When you expose pods using a Service (ClusterIP), Kube-proxy creates network rules to send traffic to the backend pods (endpoints) grouped under the Service object.
  - Meaning, all the load balancing, and service discovery are handled by the Kube proxy.
- **Container Runtime**
  - Container runtime runs on all the nodes in the Kubernetes cluster.
  - It is responsible for pulling images from container registries, running containers, allocating and isolating resources for containers, and managing the entire lifecycle of a container on a host.
  - Kubernetes supports multiple container runtimes (`CRI-O`, `Docker Engine`, `containerd`) that are compliant with `Container Runtime Interface (CRI)`.
  - This means, all these container runtimes implement the CRI interface and expose gRPC CRI APIs (runtime and image service endpoints).

### Kubernetes Cluster Addon Components
Apart from the core components, the kubernetes cluster needs addon components to be fully operational. Choosing an addon depends on the project requirements and use cases.
<br />
Following are some of the popular addon components that you might need on a cluster:
1. **CNI Plugin (Container Network Interface)**
2. **CoreDNS (For DNS server)**: CoreDNS acts as a DNS server within the Kubernetes cluster. By enabling this addon, you can enable DNS-based service discovery.
3. **Metrics Server (For Resource Metrics)**: This addon helps you collect performance data and resource usage of Nodes and pods in the cluster.
4. **Web UI (Kubernetes Dashboard)**: This addon enables the Kubernetes dashboard for managing the object via web UI.

### References
- [Kubernetes Architecture – Detailed Explanation](https://devopscube.com/kubernetes-architecture-explained/)
- [Kubernetes Architecture](https://www.youtube.com/watch?v=H7VrMXgf634)