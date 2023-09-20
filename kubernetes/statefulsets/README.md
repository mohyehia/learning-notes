## StatefulSets

### Overview
- Stateful application is an application that creates and saves valuable data.
- An example might be an app that saves data about client sessions and uses it for future sessions.
- Other examples include databases and data stores.
- It’s often useful to compare StatefulSets with Deployments.
- Both are first-class API objects and follow the typical Kubernetes controller architecture.
- Both are implemented as controllers that operate reconciliation loops watching the state of the cluster, via the API server, and moving observed state into sync with desired state.
- Both also manage Pods and bring self-healing, scaling, rollouts, and more.
- But there are also some differences between `StatefulSet` & `Deployment`. StatefulSets guarantee:
  - Predictable and persistent Pod names
  - Predictable and persistent DNS hostnames
  - Predictable and persistent volume bindings
- The three properties form the `state` of a Pod, sometimes referred to as its `sticky ID`.
- StatefulSets ensure this `state/sticky ID` is persisted across failures, scaling, and other scheduling operations, making them ideal for applications that require unique reliable Pods.
- The failed `Pods` managed by `StatefulSet` will be replaced by new pods with the exact same pod name, the exact same DNS hostname, and the exact same volumes.
- This is true even if the replacement is started on a different cluster node.
- The same is not true of Pods managed by a Deployment.


### StatefulSet Pod naming
- All Pods managed by a `StatefulSet` get _predictable_ and _persistent_ names.
- These names are vital and are at the core of how Pods are started, self-healed, scaled, deleted, attached to volumes, and more.
- The format of StatefulSet Pod names is `<StatefulSetName>-<Integer>`. The integer is a _zero-based index_.
- For example, if we have 3 replicas in the `StatefulSet` definition with a name `stateful-svc`, the first Pod will be `stateful-svc-0`, the second will be `stateful-svc-1`, and the third will be `stateful-svc-2`.


### Headless Service
- A headless Service is just a regular Kubernetes Service object without an IP address(`spec.clusterIP set to None`).
- It becomes a StatefulSet’s governing Service when you list it in the StatefulSet config under `spec.serviceName`.
- When the two objects are combined like this, the Service will create `DNS SRV` records for every Pod matching the label selector of the headless Service.
- Other Pods and apps can then find members of the StatefulSet by performing DNS lookups against the name of the headless Service.