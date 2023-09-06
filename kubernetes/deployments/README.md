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