## Kubernetes Storage
- Kubernetes has a mature and feature-rich storage subsystem called: `Persistent Volume Subsystem`.

### Overview
- Kubernetes supports a variety of storage back-ends, and each requires slightly different configuration. 
- Kubernetes supports lots of types of storage from lots of different places.
- For example: `block, file & object storage` from a variety of external systems that can be in the cloud or on on-premises datacenters.
- However, no matter what type of storage, or where it comes from, when it’s exposed on Kubernetes it’s called a volume.
- The storage providers only need a `plugin` to allow their storage resources to be surfaced  as volumes in kubernetes.
- Storage can be on-premises or any cloud storage like `AWS EBS` or `GCE PD` or any other provider.
- The `Plugin` layer is the interface that connects external storage with Kubernetes.
- Modern plugins are be based on the `Container Storage Interface (CSI)` which is an open standard aimed at providing a clean storage interface for container orchestrators such as Kubernetes.
- The kubernetes `Persistent Volume Subsystem` is a set of API objects that make it easy for applications to consume storage.
- There are a growing number of storage-related API objects, but the core ones are:
  - `Persistent Volumes (PV)` => these are the external storage assets.
  - `Persistent Volume Claims (PVC)` => authorize the `Pods` to use the `PV`.
  - `Storage Classes (SC)` => make it all automatic and dynamic.

### StorageClasses
#### The basic workflow for deploying and using a StorageClass is as follows:
1. Have a storage back-end (can be cloud or on premises)
2. Have a Kubernetes cluster connected to the back-end storage
3. Install and configure the CSI storage plugin
4. Create one or more StorageClasses on Kubernetes
5. Deploy Pods with PVCs that reference those StorageClasses

### StorageClass example
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
```
### Additional volume settings
- There are other settings we can configure in `StorageClass` like:
  - Access mode
  - Reclaim policy

### Access mode
- Kubernetes support three access modes for the volumes:
  - `ReadWriteOnce (RWO)`
  - `ReadWriteMany (RWM)`
  - `ReadOnlyMany (ROM)`
- `ReadWriteOnce` defines a `PV` that can only be bound as R/W by a single `PVC`. Attempts to bind it from multiple PVCs will fail.
- `ReadWriteMany` defines a `PV` that can be bound as R/W by multiple PVCs. This mode is usually only supported by file and object storage such as NFS. Block storage usually only supports RWO.
- `ReadOnlyMany` defines a `PV` that can be bound as R/O by multiple PVCs.

### Reclaim policy
- A volume’s `ReclaimPolicy` tells Kubernetes how to deal with a `PV` when its `PVC` is released. Two policies currently exist:
  - **Delete**
    - `Delete` is the most dangerous and is the default for PVs created dynamically via storage classes unless you specify otherwise.
    - It deletes the PV and associated storage resource on the external storage system when the PVC is released.
    - This means all data will be lost!
  - **Retain**
    - `Retain` will keep the associated PV object on the cluster as well as any data stored on the associated external asset.
    - However, other PVCs are prevented from using it in the future.
    - The obvious disadvantage is it requires manual clean-up.

### Commands
- view list of storage classes exists at your cluster: `kubectl get sc`
- view list of existing `PersistentVolume` at your cluster: `kubectl get pv`
- view list of existing `PersistentVolumeClaim` at your cluster: `kubectl get pvc`