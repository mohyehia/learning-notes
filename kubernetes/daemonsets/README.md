## DaemonSets

### Overview
- [What is DaemonSet](#what-is-daemonset)
- [Use cases for DaemonSets](#use-cases-for-daemonsets)
- [Running Pods on select Nodes](#running-pods-on-select-nodes)
- [Apply Taint and Tolerations For DaemonSet](#apply-taint-and-tolerations-for-daemonset)
- [References](#references)

### What is DaemonSet
- A `DaemonSet` is a `native kubernetes object` ensures that all (or some) Nodes run a copy of a Pod.
- As nodes are added to the cluster, Pods are added to them.
- As nodes are removed from the cluster, those Pods are garbage collected.
- Deleting a DaemonSet will clean up the Pods it created.
- You cannot scale `DaemonSet` pods in a node.
- If for so,me reason, the `DaemonSet` pod gets deleted from the node, the `DaemonSet` controller creates it again.

### Use cases for DaemonSets
- Cluster Log Collection
- Cluster Monitoring
- Security and Compliance
- Storage Provisioning
- Network Management

### Running Pods on select Nodes
- If you specify a `.spec.template.spec.nodeSelector`, then the `DaemonSet` controller will create Pods on nodes which match that `node selector`.
- Likewise, if you specify a `.spec.template.spec.affinity`, then `DaemonSet` controller will create Pods on nodes which match that `node affinity`.
- If you do not specify either, then the `DaemonSet` controller will create Pods on all nodes.

### Apply Taint and Tolerations For DaemonSet
- `Taints` and `Tolerations` are the Kubernetes feature that allows you to ensure that pods are not placed on inappropriate nodes.
- We taint the nodes and add tolerations in the pod schema using this command => `kubectl taint nodes node1 key1=value1:<Effect>`
- There are 3 effects:
  - **NoSchedule**: Kubernetes scheduler will only allow scheduling pods that have tolerations for the tainted nodes.
  - **PreferNoSchedule**: Kubernetes scheduler will try to avoid scheduling pods that don’t have tolerations for the tainted nodes.
  - **NoExecute**: Kubernetes will evict the running pods from the nodes if the pods don’t have tolerations for the tainted nodes.
- Ex: `kubectl taint node k8s-worker-1 app=fluentd-logging:NoExecute`
- Above, we are tainting one of the nodes with key app and value monitoring and the effect is `NoExecute`.
- We don’t want `DaemonSet` to run the pod on this particular node.

### References
- [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/)
- [Kubernetes Daemonset: A Comprehensive Guide](https://devopscube.com/kubernetes-daemonset/)
- [DaemonSets in Kubernetes](https://www.youtube.com/watch?v=FGJ5OeFItd4)