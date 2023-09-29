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