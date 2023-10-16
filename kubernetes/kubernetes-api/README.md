## Kubernetes API big picture
- Kubernetes is `API centric`.
- This means everything in Kubernetes is about the API, and everything goes through the API and API server.
- Clients send requests to Kubernetes to create, read, update, and delete objects such as Pods and Services.
- For the most part, you’ll use `kubectl` to send these requests, however, you can craft them in code or use API testing and development tools to generate them.
- The point is, no matter how you generate requests, they go to the `API server` where they are authenticated and authorized.
- If they pass the above validation, they are executed on the cluster.
- If it’s a create request, the object is deployed to the cluster and the serialized state of it is persisted to the cluster store.

### JSON Serialization
- `Serialization` is the process of converting an object into a string, or stream of bytes, so it can be sent over a network and persisted to a data store.
- `Deserialization` is the process of converting a string or a stream of bytes into an object.
- Kubernetes serializes objects, such as Pods and Services, as JSON strings to be sent over HTTP.
- When using `kubectl`, it is serializing objects when posting to the API server, and the API server serializing responses back to it.
- So, in Kubernetes, serialization is the process of converting an object to into a JSON string to be sent over an HTTP connection and persisted to the cluster store.

### The API Server
- The API server exposes the API over a secure `RESTful` interface using HTTPS.
- In kubernetes, everything talks to everything else via REST API calls to the API server.
- All kubectl commands go to the API server (creating, retrieving, updating, deleting objects).
- All node Kubelets watch the API server for new tasks and report status to the API server.
- All control plane services communicate with each other via the API server (they don’t talk directly each other).
- The API server exposes the API over a secure restful interface that lets you manipulate and query the state of objects on the cluster.
- It runs on the control plane, which needs to be highly available and have enough performance to service requests quickly.

### The API
- The API is where all Kubernetes resources are defined. It’s large, modular, and restful.
- When Kubernetes was originally created, the API was monolithic in design with all resources existing in a single global namespace.
- However, as Kubernetes grew, it became necessary to divide the API into smaller more manageable groups.
- At the highest level, there are two types of API group:
  - The `core` group
  - The `named` group

### The Core API group
- Resources in the core group are mature objects that were created in the early days of Kubernetes before the API was divided into groups.
- They tend to be fundamental objects such as Pods, nodes, Services, Secrets, and ServiceAccounts.
- They are located in the API below `/api/v1`
- On the topic of REST paths, `GVR` stands for `group, version, resource`, and can be a good way to remember the structure of REST paths in the Kubernetes API.

### Named API groups
- The named API groups are the future of the API, and all new resources get added to named groups.
- Sometimes we refer to them as "subgroups".
- Resources in the named groups live below the `/apis/{group-name}/{version}/` path.
- Ex => `/apis/storage.k8s.io/v1/storageclasses`
- Dividing the API into smaller groups makes it more scalable and easier to navigate.
- It also makes it easier to extend.

### Alpha, Beta & Stable
- Kubernetes has a strict process for adding new resources to the API.
- They come in as `alpha`, progress through `beta`, and eventually reach `stable`.
- Resources in `alpha` are experimental and should not be used.
- A lot of clusters disable alpha APIs by default, and you should use them with extreme caution.
- A resource that progresses through two alpha versions will go through the following APIs:
  - `/apis/some-api/v1alpha1/`
  - `/apis/some-api/v1alpha2/`
- Resources in `beta` are considered "pre-release" and are starting to look and feel a lot like they will graduate to `stable`.
- Most clusters enable `beta` APIs by default, and many people use `beta` objects in production environments.
- A resource that progresses through two beta versions will be served through the following APIs:
  - `/apis/some-api/vbeta1`
  - `/apis/some-api/vbeta2`
- The final phase after beta is `stable`, sometimes referred to as `generally available (GA)`.
- Stable resources are considered production-ready and Kubernetes has a strong long term commitment to them.
- Examples of paths to stable resources include the following:
  - `/apis/some-api/v1/`
  - `/apis/some-api/v2/`