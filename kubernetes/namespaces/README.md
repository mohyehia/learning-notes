## Namespaces

### Namespaces definition
- Namespaces are a native way to divide a single kubernetes cluster into multiple virtual clusters.
- `Kubernetes Namespaces` are not the same as Linux kernel namespaces.
- `Kernel namespaces` are an integral part of slicing operating systems into virtual operating systems called containers.
- `Kubernetes Namespaces` divide Kubernetes clusters into virtual clusters called `Namespaces`

### Namespaces use cases
- `Kubernetes Namespaces` are a good way of sharing a single cluster among different departments and environments.
- For example, a single cluster might have the following Namespaces:
  - Dev
  - Test
  - Staging
- Each one can have its own set of users and permissions, as well as unique resource quotas.

### Commands
- To list namespaces inside the cluster: `kubectl get namespaces`
- To inspect a namespace inside the cluster: `kubectl describe ns <namespace>`
- To list resources for ex: services inside a specific namespace: `kubectl get svc -n <namespace>`
- To list resources from all the namespaces in the cluster: `kubectl get svc --all-namespaces`
- To create new namespace using the command line: `kubectl create ns <namespace>`
- To delete an existing namespace: `kubectl delete ns <namespace>`
- To modify `kubectl` to use a specific namespace as the default one: `kubectl config set-context --current --namespace <namespace>`