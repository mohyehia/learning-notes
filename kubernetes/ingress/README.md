## Ingress

### Ingress Overview
- Ingress is all about accessing multiple web applications through a single LoadBalancer Service.
- When you create a Kubernetes LoadBalancer Service, Kubernetes talks to your cloud platform and provisions a cloud load-balancer.

### NodePort & Loadbalancer service limitations
- NodePorts only work on high port numbers (30000-32767) and require knowledge of node names or IPs.
- LoadBalancer Services fix this but require a 1-to-1 mapping between an internal Service and a cloud load-balancer.
- This means a cluster with 25 internet-facing apps will need 25 cloud load-balancers, and cloud load-balancers aren’t cheap.
- Ingress fixes this by exposing multiple Services through a single cloud load-balancer.
- To do this, Ingress creates a single LoadBalancer Service, on port 80 or 443, and uses host-based and path-based routing to send traffic to the correct backend Service.

### Ingress Architecture
- Ingress is a stable resource in the kubernetes API.
- Ingress is defined in the `networking.k8s.io` API subgroup as a `v1` object and is based on the usual two constructs:
  - Controller
  - Object Spec
- The object spec defines rules that govern traffic routing and the controller implements them.

### Hands-on
- check if your cluster has an ingress controller: `kubectl get ing`
- check if an ingress object controller exists at your cluster: `kubectl get ingressclass`
- create a new self-signed certificate to secure the ingress controller using this command:
  - ```shell
    openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout tls.key -out tls.crt -subj "/CN=demo.com" -days 365
    ```
- create a secret for the nginx controller using the above ssl certificate `(the name of the secret should be demo-com with suffix '-tls' instead of demo.com)`:
  - ```shell
    kubectl create secrettls demo-com-tls --cert tls.crt --key tls.key
    ```