## Service Discovery

### Components of Service Discovery
- Registration
- Discovery

### Service Registration
- Service registration is the process of an application listing its connection details in a service registry so other apps can find it and consume it.
- For the service discovery in kubernetes:
  - Kubernetes uses its internal DNS as service registry.
  - All kubernetes Services are automatically registered with DNS.
- For this to work:
  - Kubernetes provides a well-known internal DNS service that we usually call the "**Cluster DNS**".
  - It’s well known because every Pod in the cluster is automatically configured to know where to find it.
  - It’s implemented in the `kube-system` Namespace as a set of Pods managed by a Deployment called `coredns` and fronted by a Service called `kube-dns`.
  - Behind the scenes, it’s based on a DNS technology called `CoreDNS` and runs as a Kubernetes-native application.
- This command lists the `Pods` running the cluster DNS: `kubectl get pods -n kube-system -l k8s-app=kube-dns`
- This command lists the `Deployment` managing the above Pods: `kubectl get deploy -n kube-system -l k8s-app=kube-dns`
- This command lists the `Service` fronting them: `kubectl get svc -n kube-system -l k8s-app=kube-dns`

### Process of Service registration
1. You post a new Service manifest to the API server.
2. The request is authenticated, authorized, and subjected to admission policies.
3. The Service is allocated a stable virtual IP address called a ClusterIP.
4. An Endpoints object (or EndpointSlice) is created to hold a list of healthy Pods matching the Service’s label selector.
5. The Pod network is configured to handle traffic sent to the ClusterIP.
6. The Service’s name and IP are registered with the cluster DNS.

### Service Discovery
- For service discovery to work, apps need to know both of the following:
  - The name of the Service fronting the apps they want to connect to.
  - How to convert the name to an IP address.
- Application developers are responsible for point 1. They need to code apps with the names of other apps they want to consume.
- Kubernetes takes care of point 2, converting the name to an IP.

### Service Discovery & Namespaces
- Every cluster has an `address space`, and we can use `Namespaces` to partition this address space.
- Cluster address spaces are based on a DNS domain that we call the `cluster domain`.
- The domain name is usually `cluster.local` and objects have unique names within it.
- ex: a Service has a name `ent` would have a fully qualified domain name '`FQDN`' of `ent.default.svc.cluster.local`
- Means that the format of the service is: `<object-name>.<namespace>.svc.cluster.local`
- Namespaces let you partition the address space below the cluster domain.
- ex: If we have 2 Namespaces called `dev` & `prod` will partition the cluster address space into the following 2 address spaces:
  - dev: `<service-name>.dev.svc.cluster.local`
  - prod: `<service-name>.prod.svc.cluster.local`
- Object names have to be unique within a Namespace but not across Namespaces.
- Objects can connect to Services in the local Namespace using the `<service-name>`.
- But connecting to objects in a different Namespace requires FQDNs such as `<service-name>.<namespace>.svc.cluster.local`