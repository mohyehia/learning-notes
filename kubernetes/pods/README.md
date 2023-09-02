## Pods
### Pod Definition
- The smallest deployable unit in kubernetes is the Pod.
- If you deploy an app, you deploy it in a Pod.
- If you terminate an app, you terminate its Pod.
- If you scale an app up or down, you add or remove Pods.

### How we are building apps on kubernetes:
1.  Write your app/code.
2. Package it as a container image.
3. Wrap the container image in a pod.
4. Run the pod in kubernetes.

### Why Pods
- Kubernetes doesn't allow containers to run directly on a cluster, they always have to be wrapped in a Pod for the below reasons:
  - Pods augment containers.
  - Pods assist in scheduling.
  - Pods enable resource sharing.

### Pods augment containers
- Pods augment containers in the following ways:
  - Labels and annotations
  - Restart polices
  - Probes (startup probes, readiness probes, liveness probes ... )
  - Affinity & anti-affinity rules
  - Termination control
  - Security policies
  - Resource requests and limits

### Pods assist in scheduling
- Every container in a Pod is guaranteed to be scheduled to the same worker node.
- This in turn guarantees they’ll be in the same region and availability zone in the cloud or your datacenter.
- This is called co-scheduling & co-locating.
- Labels, affinity and anti-affinity rules, and resource requests and limits give you fine-grained control over which worker nodes Pods can run on.

### Pods enable resource sharing
- Pods provide a shared execution environment for the containers inside it such as:
  - Shared filesystem
  - Shared IP address, port, ...
  - Shared memory
  - Shared volumes
- Every container in a Pod shares the Pod’s execution environment.

### Deploying Pods
- The process of deploying a `Pod` to kubernetes is as below:
  1. Define the `Pod` in a yaml manifest file.
  2. Post the yaml file to the API server.
  3. The API server authenticates and authorizes the request.
  4. The configuration inside the yaml file is validated.
  5. Scheduler deploys the `Pod` to a healthy worker node with enough resources.
  6. `Kubelet` monitor the `Pod`.
- If the `Pod` is deployed via a controller, the configuration will be added to the cluster store (`etcd`) as part of the desired state & a controller will monitor it.

### Pods and shared networking
- Each pod creates its own namespace.
- This means that a pod has its own IP address, single range of ports & single routing table.
- Containers inside the pod share the IP, port range & the routing table.
- Container-to-container communication within the same pod happens via the pod's `localhost` adapter and a port number.

### Pod network
- Every pod gets its own unique IP address that's fully routable on the internal kubernetes network called `Pod Network`.
- Each pod can communicate with any other pod via the IP address.

### Pod lifecycle
- Once we have the yaml configuration file and posted to the API server, it enters the `pending` phase.
- Once scheduled to a healthy worker node and all containers are pulled and running, the pod enters the `running` phase.
- If it’s a `short-lived Pod`, as soon as all containers terminate successfully the Pod itself terminates and enters the `successful` phase.
- If it’s a `long-lived Pod`, it remains indefinitely in the `running` phase.

### Multi-container Pods
- Kubernetes offers several well-defined multi-container Pod patterns:
  - Sidecar Pattern
  - Adapter Pattern
  - Ambassador Pattern
  - Init Pattern

## Important Commands

- For creating new pod using the command line: `kubectl run <pod-name> --image=<image-id>`
  - ```shell
    kubectl run nginx-pod --image=nginx:latest
    ```
- For creating new pod using the yaml file: `kubectl apply -f pod-config.yml`
  - ```shell
    kubectl apply -f nginx-pod.yml
    ```
- To get all kubernetes object classes definitions: `kubectl api-resources`
  - ```shell
    kubectl api-resources
    ```
- To get a definition of a specific object class: `kubectl api-resources | grep <pods/any other object class>`
  - ```shell
    kubectl api-resources | grep pods
    ```
- To filter the object class based on the metadata: `kubectl get pod -l app=web`
  - ```shell
    kubectl get pod -l app=web
    ```
- To get pod definition: `kubectl get pod <my-pod> -o wide`
  - ```shell
    kubectl get pod nginx-pod -o wide
    ```
- To view the yaml definition for the pod and view the full copy of the pod from the cluster store: `kubectl get pod <my-pod> -o yaml`
  - ```shell
    kubectl get pod nginx-pod -o yaml
    ```
- To view more info about the pod along with the object lifecycle events: `kubectl describe pod <my-pod>`
  - ```shell
    kubectl describe pod nginx-pod
    ```
- To execute commands inside the pod: `kubectl exec -it <my-pod> bash`
  - ```shell
    kubectl exec -it nginx-pod bash
    ```
- To access the pod from host machine using port forward: `kubectl port-forward <my-pod> hostPort:containerPort`
  - ```shell
    kubectl port-forward nginx-pod 8081:80
    ```
- To retrieve logs of the running pod: `kubectl logs <my-pod>`
  - ```shell
    kubectl logs nginx-pod
    ```
- To delete a pod using its name: `kubectl delete pod <pod-name>`
  - ```shell
    kubectl delete pod nginx-pod
    ```
- To delete a pod created using a yaml file: `kubectl delete -f pod-config.yml`
  - ```shell
    kubectl delete -f nginx-pod.yml
    ```