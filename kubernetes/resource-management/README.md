## Resource Management

### Overview
- [Computing Resources](#computing-resources)
  - [CPU](#cpu)
  - [Memory](#memory)
- [Requests](#requests)
- [Limits](#limits)
- [Quality of Service Classes](#quality-of-service-classes)
  - [Guaranteed](#guaranteed)
  - [Burstable](#burstable)
  - [BestEffort](#besteffort)
- [LimitRange](#limitrange)
- [ResourceQuota](#resourcequota)
- [Helpful Commands](#helpful-commands)
- [References](#resource-management)

### Computing Resources
- **CPU** & **Memory** are called compute resources.

#### CPU
- CPU is measured as a fraction of time.
- Ex: 200m(0.cpu) which is `200 millicores` or 1cpu(100m) which is `1000 millicores`
- CPU is a compressible resource meaning when ever an application is using maximum cpu, it throttles (slowing down the response instead of terminating the process).
- 1CPU is equal to: `1 vCPU in AWS`, `1 Core in GCP` & `1 vCore in Azure`
- The data that is being used by the processor is using currently is stored in memory.

#### Memory
- Memory is measured in `Bytes`
- Ex: 1KB = `1000 bytes` & 1KiB = `1024 bytes`
- Ex: 1MB = `1000 KB` & 1MiB = `1024 KB`
- Memory is not compressible means that is a process is using more memory than it should, it will be terminated immediately.

### Requests
- When you specify a `Pod`, you can optionally specify how much of each resource a `container` needs.
- The most common resources to specify are CPU and memory (RAM); there are others.
- When you specify the resource `request` for containers in a Pod, the `kube-scheduler` uses this information to decide which node to place the Pod on.
- So kubernetes guarantees to schedule this `Pod` on a `Node` where the minimum capacity is available.
- If there are no nodes with the minimum capacity defined in the pod, the Pod will remain in the `Pending` state until the resources are available.
- Once the resources are available on any node, the `kube-scheduler` schedules this pod to run on that node.
- In short, kubernetes compares the request resources defined in the pod to the available resources on each node in the cluster and automatically assigns a node to the pod.

### Limits
- When you specify a resource `limit` for a container, the kubelet enforces those limits so that the running container is not allowed to use more of that resource than the limit you set.
- If the node where a Pod is running has enough of a resource available, it's possible (and allowed) for a container to use more resource than its `request` for that resource specifies.
- However, a container is not allowed to use more than its resource `limit`.
- For example, if you set a `memory` request of `256 MiB` for a container, and that container is in a Pod scheduled to a Node with `8GiB` of memory and no other Pods, then the container can try to use more RAM.
- If you set a `memory` limit of `4GiB` for that container, the kubelet (and container runtime) enforce the limit.
- The runtime prevents the container from using more than the configured resource limit.
- Ex: when a process in the container tries to consume more than the allowed amount of memory, the system kernel terminates the process that attempted the allocation, with an `out of memory (OOMKilled) error`.

### Quality of Service Classes
- Kubernetes classifies the Pods that you run and allocates each Pod into a specific `quality of service (QoS) class`.
- Kubernetes uses that classification to influence how different pods are handled.
- Kubernetes does this classification based on the `resource requests` of the Containers in that Pod, along with how those requests relate to resource `limits`.
- Kubernetes assigns every Pod a `QoS` class based on the resource requests and limits of its component Containers.
- `QoS` classes are used by Kubernetes to decide which Pods to evict from a `Node` experiencing `Node Pressure`.
- The possible QoS classes are `Guaranteed`, `Burstable`, and `BestEffort`.
- When a `Node` runs out of resources, Kubernetes will first evict `BestEffort` Pods running on that Node, followed by `Burstable` and finally `Guaranteed` Pods.
- When this eviction is due to resource pressure, only Pods exceeding resource requests are candidates for eviction.

#### Guaranteed
- Pods that are `Guaranteed` have the strictest resource limits and are least likely to face eviction.
- They are guaranteed not to be killed until they exceed their limits or there are no lower-priority Pods that can be preempted from the Node.
- They may not acquire resources beyond their specified limits.
- For a Pod to be given a QoS class of `Guaranteed`:
  - Every Container in the Pod must have a memory limit and a memory request.
  - For every Container in the Pod, the memory limit must equal the memory request.
  - Every Container in the Pod must have a CPU limit and a CPU request.
  - For every Container in the Pod, the CPU limit must equal the CPU request.

#### Burstable
- Pods that are `Burstable` have some lower-bound resource guarantees based on the request, but do not require a specific limit.
- If a limit is not specified, it defaults to a limit equivalent to the capacity of the Node, which allows the Pods to flexibly increase their resources if resources are available.
- In the event of Pod eviction due to Node resource pressure, these Pods are evicted only after all `BestEffort` Pods are evicted.
- Because a `Burstable` Pod can include a Container that has no resource limits or requests, a Pod that is `Burstable` can try to use any amount of node resources.
- A Pod is given a QoS class of `Burstable` if:
  - The Pod does not meet the criteria for QoS class `Guaranteed`.
  - At least one Container in the Pod has a memory or CPU request or limit.

#### BestEffort
- Pods in the `BestEffort` QoS class can use node resources that aren't specifically assigned to Pods in other QoS classes.
- For example, if you have a node with 16 CPU cores available to the kubelet, and you assign 4 CPU cores to a `Guaranteed` Pod, then a Pod in the `BestEffort` QoS class can try to use any amount of the remaining 12 CPU cores.
- The kubelet prefers to evict `BestEffort` Pods if the node comes under resource pressure.
- A Pod has a QoS class of `BestEffort` if:
  - It doesn't meet the criteria for either `Guaranteed` or `Burstable`.
  - In other words, a Pod is `BestEffort` only if none of the Containers in the Pod have a memory limit or a memory request, and none of the Containers in the Pod have a CPU limit or a CPU request.
  - Containers in a Pod can request other resources (not CPU or memory) and still be classified as `BestEffort`.


### LimitRange
- `LimitRange` is a policy to constrain the resource allocations (limits and requests) that you can specify for each applicable object kind (such as `Pod` or `PersistentVolumeClaim`) in a namespace.
- A `LimitRange` provides constraints that can:
  - Enforce minimum and maximum compute resources usage per `Pod` or `Container` in a namespace.
  - Enforce minimum and maximum storage request per `PersistentVolumeClaim` in a namespace.
  - Enforce a ratio between request and limit for a resource in a namespace.
  - Set default request/limit for compute resources in a namespace and automatically inject them to Containers at runtime.
- A `LimitRange` is enforced in a particular namespace when there is a `LimitRange` object in that namespace.

### ResourceQuota
- `ResourceQuota` provides constraints that limit aggregate resource consumption per namespace.
- It can limit the quantity of objects that can be created in a namespace by type, as well as the total amount of compute resources that may be consumed by resources in that namespace.
- Resource quotas work like this:
  - Different teams work in different namespaces. This can be enforced with `RBAC`.
  - The administrator creates one `ResourceQuota` for each namespace.
  - Users create resources (pods, services, etc.) in the namespace, and the quota system tracks usage to ensure it does not exceed hard resource limits defined in a `ResourceQuota`.
  - If creating or updating a resource violates a quota constraint, the request will fail with HTTP status code `403 FORBIDDEN` with a message explaining the constraint that would have been violated.
  - If quota is enabled in a namespace for compute resources like cpu and memory, users must specify requests or limits for those values; otherwise, the quota system may reject pod creation.

### Helpful Commands
- `kubectl top pods` => to check how many resources a `Pod` is consuming.
- If we are using `minikube`, we will get an error message as the `metrics-server` is disabled by default.
- To enable the `metrics-server` we need to enable the `addon` using this command: `minikube addons enable metrics-server`
- The `metrics-server` collects and aggregates the collected metrics by the `kubelet` in each node such as CPU & memory consumption from all the pods.
- To get the available `limitRanges` in the namespace => `kubectl get limits`
- To get the available `resourceQuotas` in the namespace => `kubectl get quota`


### References
- [Resource Management for Pods and Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)
- [Pod Quality of Service Classes](https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/)
- [Resource Management in Kubernetes](https://www.youtube.com/watch?v=MbgFIQoVh6w&list=PLrMP04WSdCjrkNYSFvFeiHrfpsSVDFMDR&index=17)
- [Limit Ranges](https://kubernetes.io/docs/concepts/policy/limit-range/)
- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)