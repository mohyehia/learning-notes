### kubectl

### Overview
- When you work on Kubernetes projects, you will have to deal with multiple kubernetes clusters at a time.
- It could be clusters that are part of the same environments or different environments.
- Here is where `kubectl config set context` command comes in handy.
- A context is a set of parameters (cluster, namespace, user) present in the `kubeconfig` file that are required to connect to a kubernetes cluster.
- A single `kubeconfig` file can contain more than one context.
- You can view all the contexts using the following kubectl command => `kubectl config view`

### List Cluster Contexts
- To list all the available contexts in your workstation, you can use the following kubectl command. the -o=name flag lists only the context names => `kubectl config get-contexts -o=name`

### kubectl set context
- To set the current context, you can use the following command => `kubectl config use-context [context-name]`
- When you set a new context, the value is also set in the `Kubeconfig` file.
- You can find a parameter called `current-context`: in the `Kubeconfig` file.

### kubectl set context with namespace
- By default, all the commands get executed in the default namespace if you don’t specify a namespace with the `-n` flag.
- You can change that behavior by setting the current namespace using the `use-context` command.
- Here is the command syntax to be used to set another namespace other than the default one => `kubectl config use-context [context-name] --namespace [namespace-name]`
- Once you set the current namespace, you don’t have to use the `-n` flag with the `kubectl` command.
- all the kubectl command gets executed in the current namespace set by the `use-context` command.

### kubectl delete context
- You can delete the context created by kubectl using the `delete-context` command => `kubectl config delete-context [context-name]`

### Kubectl Set Context Alias
- If you regularly switch between contexts to work on different clusters, you can create an alias to list and set the context.
- Here is the alias to list the contexts => `alias klist='kubectl config get-contexts -o=name'`

### References
- [kubectl set context Tutorial](https://devopscube.com/kubectl-set-context/)