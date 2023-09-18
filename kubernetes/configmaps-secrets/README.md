### ConfigMap
- Kubernetes provides an object called a `ConfigMap (CM)` that lets you store configuration data outside a Pod.
- It also makes it easy to inject the config into Pods at run-time.
- `ConfigMap` are typically used to store non-sensitive configuration data such as:
  - Environment variables
  - Configuration files (things like web server configs and database configs)
  - Hostnames
  - Service ports
  - Account names
- You should not use ConfigMaps to store sensitive data such as certificates and passwords.
- Kubernetes provides a different object, called a `Secret`, for storing sensitive data.
- ConfigMaps are a map of key-value pairs, and we call each pair an entry.
- Sample of an entry: `key: value`
- Once data is stored in a ConfigMap, it can be injected into containers at run-time via any of the following methods:
  - Environment variables
  - Arguments to the container’s startup command
  - Files in a volume

### Creating ConfigMaps imperatively
- The command to imperatively create a ConfigMap is `kubectl create configmap`
- The command accepts two sources of data:
  - Literal values on the command line `--from-literal`
  - Files `--from-file`
- This command create a `configMap` called `temp-cm` with a map entry: `kubectl create configmap temp-cm --from-literal key=value`
- To create a `ConfirMap` from a file instead of literals: `kubectl create cm temp-file --from-file my-file.txt`. Note that the file needs to exist and contains the data we need.


### Creating ConfigMaps declarative
- This example shows a sample of the yaml file for creating a `configMap`:
- ```yaml
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: sample-cm
  data:
    key: "Value here"
  ```
- Then use the `kubectl apply -f configmap-file-name.yml` to create it.
- ConfigMaps are extremely flexible and can be used to insert complex configurations, including JSON files and even scripts, into containers at run-time.


### Injecting ConfigMap into containers
- We can inject ConfigMap data into a container via environment variables like the below sample:
- ```yaml
  spec:
    containers:
      - name: ctr
        env:
          - name: COUNTRY
            valueFrom:
              configMapKeyRef:
                key: country
                name: sample-cm
  ```
- When the Pod is scheduled and the container started, `COUNTRY` will be created as standard Linux environment variables inside the container.
- To list the existing environment variables inside a Pod: `kubectl exec my-pod -- env`
- A drawback to using ConfigMaps with environment variables is that environment variables are static.
- This means updates made to the map don’t get reflected in running containers.
- This is a major reason not to use environment variables.

### Injecting using volumes
- Using ConfigMaps with volumes is the most flexible option.
- You can reference entire configuration files, as well as make updates to the ConfigMap that will be reflected in running containers.
- This means you can make changes to entries in a ConfigMap after you’ve deployed a Pod, and those changes be seen in containers and available for running applications.
- The high-level process for exposing ConfigMap data via a volume looks like this:
  - Create the `ConfigMap`
  - Create a `ConfigMap volume` in the Pod template
  - Mount the `ConfigMap volume` into the container
  - Entries in the `ConfigMap` will appear in the container as individual files


### Secrets
- Secrets are almost identical to ConfigMaps – they hold application configuration data that is injected into containers at run-time.
- However, Secrets are designed for sensitive data such as passwords, certificates, and OAuth tokens.
- Despite being designed for sensitive data, Kubernetes does not encrypt Secrets in the cluster store.
- It merely obscures them as base-64 encoded values that can easily be decoded.
- Atypical workflow for a `Secret` is as below:
  1. The Secret is created and persisted to the cluster store as an un-encrypted object
  2. A Pod that uses it gets scheduled to a cluster node
  3. The Secret is transferred over the network, un-encrypted, to the node
  4. The kubelet on the node starts the Pod and its containers
  5. The Secret is mounted into the container via an in-memory `tmpfs filesystem` and decoded from base64 to plain text
  6. The application consumes it
  7. If/when the Pod is deleted, the Secret is deleted from the node
- By default, every Pod gets a `Secret` mounted into it as a volume, which it uses to authenticate itself if it talks to the API server.

### Creating Secrets using the commandline
- use this command: `kubectl create secret generic <secret-name> --from-literal secret-key=secret-value`
- Note that the secret values will be created as `base64-encoded`
- To decode the encoded value using the command line: `echo <encoded-value> | base64 -d`
- To encode a plain text value to base64 using the command line: `echo <plain-text> | base64`