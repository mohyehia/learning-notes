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