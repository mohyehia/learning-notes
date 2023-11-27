# Elastic Kubernetes Service


### Different ways to set up EKS cluster
- AWS Management Console
- `eksctl` utility provided by AWS
- `Infrastructure-as-code` tools like `terraform`


### Prerequisites for creating EKS cluster
- AWS account with admin privileges
- AWS cli access to use `kubectl` utility
- Instance (to manage cluster by using kubectl)

### Steps for using AWS console for creating EKS cluster
1. Create IAM role for `EKS cluster`
2. Create dedicated VPC for the EKS cluster
3. Create EKS cluster
4. Install & setup IAM authenticator and kubectl utility
5. Switch context for `kubectl` to point to the newly created eks using this command: `aws eks --region <region> update-kubeconfig --name <eks-cluster-name>`
6. Create IAM role for EKS worker nodes
7. Create worker nodes (by creating a `Node Group`)
8. Deploy your application
9. Delete the EKS cluster

### The dedicated VPC to be created for the cluster:
- Use a cloudformation stack already provided by aws for creating the recommended VPC: `https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml`

### Roles to be created for the EKS cluster:
- Control Plane => create new role contains this permission: `AmazonEKSClusterPolicy`
- Worker Nodes => create new role for `AWS service 'ec2'` contains these permissions => `AmazonEC2ContainerRegistryReadOnly`, `AmazonEKS_CNI_Policy`, `AmazonEKSWorkerNodePolicy`

### Delete the EKS cluster
- Delete any services that have an associated `EXTERNAL-IP` value.
- Delete all node groups.
- Delete the cluster.
- Delete the VPC AWS CloudFormation stack.

### Steps for creating EKS cluster using `eksctl` utility
1. Download and install the `eksctl` utility
2. Create cluster using this command => `eksctl create cluster --name=<cluster-name> --region=<region> --zones=<zone1,zone2...> --without-nodegroup`
3. Create & Associate IAM OIDC Provider for our EKS Cluster => `eksctl utils associate-iam-oidc-provider --region <region> --cluster <cluster-name> --approve`
4. Create EC2 key pair to be able to ssh to the EKS worker nodes using terminal
5. Create nodegroup for the EKS cluster using this command => `eksctl create nodegroup --cluster=<cluster-name> --region=<region> --name=<nodegroup-name> --node-type=<ec2-machine-type> --nodes=<num-of-ec2-instances> --nodes-min=2 --nodes-max=2 --node-volume-size=8 --managed`
6. When deleting the cluster, delete first the nodegroup that was created for the EKS cluster using this command => `eksctl delete ng --cluster=<cluster-name> --name=<nodegroup-name>`
7. Delete the control plane using this command => `eksctl delete cluster <cluster-name>`