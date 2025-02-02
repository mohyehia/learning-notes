## Terraform Script
### The script is creating the below resources:
- AWS VPC
- 2 Public Subnets
- 2 Private Subnets
- AWS internet Gateway
- An Elastic IP Address
- NAT Gateway & allocate the elastic IP address to it
- Public route table and create a route for the network gateway from this route table
- Private route table and create a route for the nat gateway from this route table
- Define the Public & Private Route Table Associations by linking the public subnets with the public route table and same for private subnets

## Concise AWS VPC, Subnet, IGW, and Route Table Creation Checklist

This checklist outlines the main steps for creating a VPC, subnets, internet gateway, and route tables in the correct order.

**I. VPC Creation:**

* [ ] Define VPC resource (CIDR block, DNS settings, tags).
* [ ] Verify VPC creation.

**II. Subnet Creation:**

* [ ] Define public subnet resources (CIDR blocks, AZs, `map_public_ip_on_launch` as needed, tags).
* [ ] Define private subnet resources (CIDR blocks, AZs, `map_public_ip_on_launch = false`, tags).
* [ ] Verify subnet creation.

**III. Internet Gateway Creation:**

* [ ] Define Internet Gateway resource.
* [ ] Attach Internet Gateway to VPC.
* [ ] Verify Internet Gateway attachment.

**IV. Route Table Creation and Association:**

* [ ] Define public route table resource.
* [ ] Associate public subnets with public route table.
* [ ] Add route to Internet Gateway in public route table (0.0.0.0/0).
* [ ] Define private route table resource (no internet gateway route).
* [ ] Associate private subnets with private route table.
* [ ] Verify route table creation and associations.

**V. Verification and Testing (Optional):**

* [ ] Launch test instances.
* [ ] Test internet connectivity (public subnets).
* [ ] Test internal connectivity.
* [ ] Test security groups (if configured).

**VI. Documentation:**

* [ ] Document configuration (CIDR blocks, AZs, routing).
* [ ] Store infrastructure-as-code (e.g., Terraform).


## NAT Gateway
- A NAT Gateway (Network Address Translation Gateway) is a managed service provided by AWS that allows instances in your private subnets to connect to the internet or other AWS services without exposing those instances to the public internet.
- It's a crucial component for security and managing access to and from your private subnets.

### How NAT Gateway Works (Simplified):
1. An instance in a private subnet wants to connect to the internet.
2. The traffic is routed to the NAT Gateway.
3. The NAT Gateway translates the private IP address of the instance to a public IP address (managed by the NAT Gateway).
4. The traffic is sent to the internet.
5. When the response comes back, the NAT Gateway translates the public IP address back to the private IP address of the instance and forwards the traffic accordingly.