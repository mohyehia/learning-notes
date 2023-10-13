## Monitoring Kubernetes Cluster

1. Create `Namespace` called `monitoring`
2. Create `ClusterRole` & `ClusterRoleBinding` for prometheus called `prometheus` and assign this role to the `default` serviceAccount at the `monitoring` namespace.
3. Create a `ConfigMap` To externalize Prometheus Configurations.
4. Create a Prometheus `Deployment` and a `Service` to be able to access it.
5. Expose prometheus using `Ingress`
6. Create a `ConfigMap` to externalize grafana configuration & datasources.
7. Setting up `Grafana` for visualizing prometheus metrics using dashboards.
8. Setting up `Node Exporter` for providing all the Linux system-level metrics of all Kubernetes nodes.