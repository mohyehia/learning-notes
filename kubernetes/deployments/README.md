## Deployments

### Overview
- Deployments bring `cloud-native` features such as `self-healing`, `scaling`, `rolling updates` & `versioned rollbacks` to stateless apps on kubernetes.
- Kubernetes offers several controllers that augment pods with important capabilities.
- The `Deployment` controller is specifically designed for stateless apps.

### Process of deploying pods in kubernetes:
- You start with a stateless application, package it as a container, then define it in a Pod template.
- At this point you could run it on Kubernetes.
- However, static Pods like this don’t self-heal, they don’t scale, and they don’t allow for easy updates and rollbacks.
- For these reasons, you’ll almost always wrap them in a Deployment object.

### Deployments and ReplicaSets
- Deployments rely heavily on another object called a ReplicaSet.
- At a high-level, containers are a great way to package applications and dependencies.
- Pods allow containers to run on Kubernetes and enable co-scheduling and a bunch of other good stuff.
- ReplicaSets manage Pods and bring self-healing and scaling.
- Deployments manage ReplicaSets and add rollouts and rollbacks.

### Self-healing & scalability
- Pods offer nothing in the way of self-healing & scalability.
- If the node a pod is running on failed, the pod is lost.
- If pods managed by a deployment failed, the pods will be replaced (**self-healing**)
- If pods managed by a deployment see increased or decreased load, they can be scaled up or down (**scaling**)
- Behind the scenes, the `ReplicaSet` is actually doing the self-healing & scalability.

### ReplicaSet reconciliation
- ReplicaSets are implemented as a controller running as a background reconciliation loop.
- This loop checking the right number of Pod replicas are present on the cluster.
- If there aren’t enough, it adds more.
- If there are too many, it terminates some.

### Rolling updates
- When designing microservices application, we need to have a pod for each microservice.
- For convenience, self-healing, scaling, rolling updates and more – you wrap the Pods in their own higher-level controller such as a Deployment.
- Each Deployment describes all the following:
  - How many Pod replicas.
  - What images used for the Pod's containers.
  - What network ports to expose.
  - Details about how to perform rolling updates.
- In the case of Deployments, when you post the YAML file to the API server, the Pods get scheduled to healthy worker nodes.
- The Deployment & ReplicaSet work together to make the magic happen.
- The ReplicaSet controller sits in a watch loop making sure that the observed state and desired state are the same.
- A Deployment object sits above the ReplicaSet, governing its configuration and providing mechanisms for rollouts and rollbacks.
- For updating the application with a newer version:
  - you update the same Deployment YAML file with the new image version and re-post it to the API server.
  - This updates the existing Deployment object with a new desired state requesting the same number of Pods but all running the newer image.
  - To make this happen, Kubernetes creates a second ReplicaSet to create and manage the Pods with the new image.
  - You now have two ReplicaSets – the original one for the Pods with the old image, and a new one for the Pods with the new image.
  - As Kubernetes increases the number of Pods in the new ReplicaSet (with the new version of the image), it decreases the number of Pods in the old ReplicaSet (with the old version of the image).
  - The result, you get a smooth incremental rollout with zero downtime.

### Rollback
- The older ReplicaSets are down and no longer manage any Pods.
- However, their configurations still exist on the cluster, making them a great option for reverting to previous versions.

### Deployment Sample
Checkout the below yaml configuration and we are going to describe some of the keywords that is being used:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  revisionHistoryLimit: 5
  progressDeadlineSeconds: 300
  minReadySeconds: 10
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  selector:
    matchLabels:
      app: hello-world
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
        - name: hello-pod
          image: hello-world:1.0
          ports:
            - containerPort: 80
```
- `apiVersion` The latest stable Deployment schema is defined in `apps/v1` subgroup.
- `kind` Tells kubernetes that this is a `Deployment` object.
- `metadata` Gives the Deployment a name. This should be a valid DNS name.
- `spec` Anything below `spec` belongs to the Deployment.
- `spec.template` Anything nested below this value is the Pod template the Deployment uses to stamp out Pod replicas.
- `spec.replicas` How many Pod replicas the Deployment should create and manage.
- `spec.selector` List of labels that Pods must have in order for the Deployment to manage them.
- `spec.revisionHistoryLimit` The number of old ReplicaSets to keep to allow rollback.
- `spec.progressDeadlineSeconds` The maximum time in seconds for a deployment to make progress before it is considered to be failed.
- `spec.minReadySeconds` Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available.
- `spec.strategy` The deployment strategy to use to replace existing pods with new ones.
- `spec.strategy.rollingUpdate.maxSurge` The number of pods that can be created above the desired amount of pods during an update. This can be an absolute number or percentage of the replicas count. The default is 25%.
- `spec.strategy.rollingUpdate.maxUnavailable` The number of pods that can be unavailable during the update process. This can be an absolute number or a percentage of the replicas count. The default is 25%.

### Rollout commands
- `kubectl rollout status deployment <deployment-name>`: monitor the progress of the rolling updates.
- `kubectl rollout pause deploy <deployment-name>`: If the rollout is still in progress, you can pause it with this command.
- `kubectl rollout resume deploy <deployment-name>`: To resume the rollout.
- `kubectl rollout history deployment/<deployment-name>`: The revision history of the rollouts.
- `kubectl rollout undo deploy <deployment-name> --to-revision=<old-revision>`: Revert the application to an old revision. **This operation is not recommended as it's an imperative operation**