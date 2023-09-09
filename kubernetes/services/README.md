## Services

### Overview
- Service provide stable and reliable networking for a set of unreliable Pods.

### Why we should never rely on Pods
- When Pods fail, they get replaced by new ones with new IPs.
- Scaling-up introduces new Pods with new IP addresses. Scaling down removes Pods.
- Rolling updates delete existing Pods and replace them with new ones with new IPs.
- All of this creates massive IP churn and demonstrates why you should never connect directly to any Pod.

### Why using Services
- Every Service gets its own **stable IP address**, its own **stable DNS name**, and its own **stable port**.
- Services use **labels and selectors** to dynamically select the Pods they send traffic to.
- With using Services above Pods, the Pods can scale up and down, they can fail, and they can be updated and rolled back.
- Despite all of this, clients will continue to access them without interruption.
- This is because the Service is observing the changes and updating its list of healthy Pods it sends traffic to.
- **But it never changes its stable IP, DNS, and port**.

### Service types
- **ClusterIP Service**
  - The default service type in kubernetes.
  - A ClusterIP service has a stable virtual IP address that is only accessible from inside the cluster.
  - Every Service you create gets a ClusterIP that is registered, along with the name of the Service in the cluster internal DNS service.
- **NodePort Service**
  - Built on top of the CLusterIP type and allow external clients to hit a dedicated port on every cluster node and reach the Service.
  - Pods on the cluster can access the service by its name and the `port` configured for it.
  - Clients connecting from outside the cluster can connect through any cluster node on the `nodePort` configured for it.
- **LoadBalancer Service**
  - LoadBalancer Service make external access easy by integrating with an internet-facing load-balancer on the underlying cloud platform.
  - You get a high-performance highly-available public IP or DNS name that you can access the Service from.
  - You can even register friendly DNS names to make access even simpler – you don’t need to know cluster node names or IPs.