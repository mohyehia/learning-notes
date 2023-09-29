## API Security & RBAC

### API security big picture
- Kubernetes is `API-centric` and the API is served through the `API server`.
- All the following make CRUD-style requests to the API server (create, read, update, delete):
  - Operators & developers using kubectl.
  - Pods
  - Kubelets
  - Control plane services
- Here are the flow if you need to deploy a `pod` or perform any `kubectl apply`:
  - User `username` issues a `kubectl apply` command to create the Resource.
  - This generates a request to the API server with the user’s credentials embedded.
  - Thanks to the magic of TLS, the connection between the client and the API server is secure.
  - The authentication module determines whether it’s the user really or an imposter.
  - After that, the authorization module (`RBAC`) determines whether user is allowed to create the resource in the specified `Namespace` or not.
  - If the request passes authentication and authorization, `admission control` checks and applies policies, and the request is finally accepted and executed.

### RBAC big picture
- The most common authorization module is RBAC (Role-Based Access Control). At the highest level, it’s about three things:
  - Users
  - Actions
  - Resources
- Which _users_ can perform which _actions_ against which _resources_.
- RBAC is enabled on most kubernetes clusters.
- It’s a `least-privilege deny-by-default` system, meaning all actions are denied by default, and you enable specific actions by creating `allow rules`.
- Kubernetes doesn't support `deny-rules`, it only supports `allow-rules`.

### Users and Permissions
- Two concepts are vital to understanding Kubernetes RBAC:
  - `Role`
  - `RoleBinding`
- Roles define a set of permissions, and RoleBindings grant those permissions to users.
- On their own, Roles don’t do anything. They need binding to a user.
- Each Role will have 3 objects inside the `rules` object of the `Role` definition:
  - apiGroups
  - resources
  - verbs
- Together, they define which actions are allowed against which objects. 
- `apiGroups` and `resources` define the object, and `verbs` define the actions.
- Use this command to find the available `verbs` for any `resources`: `kubectl api-resources --sort-by name -o wide | grep <reourceName>`
- `Roles` and `RoleBindings` are namespaced objects. This means they can only be applied to a single Namespace.
- `ClusterRole` and `ClusterRoleBinding` are cluster-wide objects and apply to all Namespaces.
- A powerful pattern is to define `Role` at the cluster level (`ClusterRole`) and bind them to specific Namespaces via RoleBindings.
- This lets you define common roles once, and re-use them across multiple Namespaces.

### Create New Users
1. Generate new private key for the new user: `openssl genrsa -out mohyehia.key 2048`
2. Create the certificate signing request (`csr`) for the user with the private key: `openssl req -new -key mohyehia.key -out mohyehia.csr -subj "/CN=mohyehia/O=dev"`
3. Sign the `csr` by the certificate authority for the minikube cluster using this command: `openssl x509 -req -CA path/to/.minikube/ca.crt -CAkey path/to/.minikube/ca.key -CAcreateserial -days 730 -in mohyehia.csr -out mohyehia.crt`
4. Add the newly created user to the minikube cluster using this command: `kubectl config set-credentials mohyehia --client-certificate=mohyehia.crt --client-key=mohyehia.key`
5. Create new context for the newly created user to assign him to an existing cluster: `kubectl config set-context <context-name> --cluster=<cluster-name> --user=<username> --namespace=<namespace-name>`
6. Example for the above command: `kubectl config set-context mohyehia-minikube --cluster=minikube --user=mohyehia --namespace=default`
7. Switch the minikube context to the newly created context for our new user using this command: `kubectl config use-context <context-name>`

### Another Commands
- check if the current logged-in user can perform an action: `kubectl auth can-i <verb> <resource>`
- ex for the above command: `kubectl auth can-i create pods`
- To check if a `ServiceAccount` can perform an action: `kubectl auth can-i <verb> <resource> --as="system:serviceaccount:<namespace>:<service-account-name>"`
- ex for the above command: `kubectl auth can-i create pods --as="system:serviceaccount:default:test-sa"`

### Admission Control
- Admission control runs immediately after successful authentication and authorization and is all about policies.
- There are two types of admission controllers:
  - Mutating
  - Validating
- Mutating controllers check for compliance and can modify requests.
- Validating controllers check for policy compliance but cannot modify requests.
- Mutating controllers always run first, and both types only apply to requests that will modify state.
- Requests to read state are not subjected to admission control.
- An example for the admission controller is `AlwaysPullImages` controller.
- It’s a mutating controller that sets the `spec.containers.imagePullPolicy` of all new Pods to `Always`.
- This means container images will always be pulled from the registry.
- It accomplishes quite a few things, including the following:
  - Preventing the use of local images that could be malicious
  - Only nodes with valid credentials can pull images and run containers
- If any admission controller rejects a request, it’s immediately rejected without checking other admission controllers.
- However, if all admission controllers approve the request, it gets persisted to the cluster store and instantiated on the cluster.