## Monitoring Kubernetes Cluster

### About Prometheus
- Prometheus is a high-scalable open-source monitoring framework.
- It provides out-of-the-box monitoring capabilities for the Kubernetes container orchestration platform.

### Prometheus key points
1. **Metric Collection**: Prometheus uses the pull model to retrieve metrics over HTTP.
2. **Metric Endpoint**: The systems that you want to monitor using Prometheus should expose the metrics on an `/metrics` endpoint.
3. **PromQL**: Prometheus comes with `PromQL`, a very flexible query language that can be used to query the metrics in the Prometheus dashboard.
4. **Prometheus Exporters**: Exporters are libraries that convert existing metrics from third-party apps to Prometheus metrics format.
5. **TSDB (time-series database)**: Prometheus uses `TSDB` for storing all the data efficiently. By default, all the data gets stored locally.

### Prometheus Monitoring Setup on Kubernetes
- Create a `Namespace` & `ClusterRole`
  - First, we will create a Kubernetes namespace for all our monitoring components.
  - If you don’t create a dedicated namespace, all the Prometheus kubernetes deployment objects get deployed on the default namespace.
  - Prometheus uses Kubernetes APIs to read all the available metrics from Nodes, Pods, Deployments, etc.
  - For this reason, we need to create an `RBAC` policy with `read access` to required API groups and bind the policy to the `monitoring` namespace.
- Create a `Config Map` To Externalize Prometheus Configurations
  - `prometheus.yaml`: This is the main Prometheus configuration which holds all the scrape configs, service discovery details, storage locations, data retention configs, etc)
  - `prometheus.rules`: This file contains all the Prometheus alerting rules
- Create a Prometheus `Deployment` & `Service`
  - In this configuration, we are mounting the Prometheus config map as a file inside `/etc/prometheus`
- Setting Up Kube State Metrics
  - `Kube State metrics` is a service that talks to the Kubernetes API server to get all the details about all the API objects like deployments, pods, daemonsets, Statefulsets, etc.
  - Primarily it produces metrics in Prometheus format with the stability as the Kubernetes API
  - Overall it provides kubernetes objects & resources metrics that you cannot get directly from native Kubernetes monitoring components.
  - Kube state metrics service exposes all the metrics on `/metrics` URI.
  - Prometheus can scrape all the metrics exposed by Kube state metrics.
  - You will have to deploy the following Kubernetes objects for Kube state metrics to work.
    - **Service Account**
    - **Cluster Role** - For kube state metrics to access all the Kubernetes API objects.
    - **Cluster Role Binding** - Binds the service account with the cluster role.
    - **Deployment** - For kube state metrics
    - **Service** - To expose the metrics
  - All the above Kube state metrics objects will be deployed in the `kube-system` namespace
- Setting Up Alert Manager
  - `AlertManager` is an open-source alerting system that works with the Prometheus Monitoring system.
  - `AlertManager` setup has the following key configurations for kubernetes deployment:
    - A config map for AlertManager configuration
    - A config Map for AlertManager alert templates
    - Alert Manager Kubernetes Deployment
    - Alert Manager service to access the web UI
- Setting Up Node Exporter
- Setting Up Grafana
  - Template => [Kubernetes cluster monitoring](https://grafana.com/grafana/dashboards/315-kubernetes-cluster-monitoring-via-prometheus/)
  - Template => [Node Exporter Full](https://grafana.com/grafana/dashboards/1860-node-exporter-full/)
  - Template => [Kubernetes apiserver](https://grafana.com/grafana/dashboards/12006-kubernetes-apiserver/)


### Steps in brief
1. Create `Namespace` called `monitoring`
2. Create `ClusterRole` & `ClusterRoleBinding` for prometheus called `prometheus` and assign this role to the `default` serviceAccount at the `monitoring` namespace.
3. Create a `ConfigMap` To externalize Prometheus Configurations.
4. Create a Prometheus `Deployment` and a `Service` to be able to access it.
5. Expose prometheus using `Ingress`
6. Create a `ConfigMap` to externalize grafana configuration & datasources.
7. Setting up `Grafana` for visualizing prometheus metrics using dashboards.
8. Setting up `Node Exporter` for providing all the Linux system-level metrics of all Kubernetes nodes.


### References
- [How to Setup Prometheus Monitoring On Kubernetes Cluster](https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/)
- [How to Setup Prometheus Node Exporter on Kubernetes](https://devopscube.com/node-exporter-kubernetes/)
- [How To Setup Kube State Metrics on Kubernetes](https://devopscube.com/setup-kube-state-metrics/)
- [Setting Up Alert Manager on Kubernetes – Beginners Guide](https://devopscube.com/alert-manager-kubernetes-guide/)
- [How To Setup Grafana On Kubernetes](https://devopscube.com/setup-grafana-kubernetes/)