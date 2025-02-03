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


### How to Establish a VPC Peering Connection (High-Level):

1. **Requesting VPC (Requester):** One VPC initiates the peering connection request. This is called the "requester" VPC.
2. **Accepting VPC (Accepter):** The other VPC receives the request and must accept it. This is the "accepter" VPC.
3. **Route Table Updates:** Crucially, after the peering connection is established, you must update the route tables in both VPCs to direct traffic to the other VPC's CIDR block via the peering connection. This tells each VPC how to reach the other.
4. **Security Groups (If Applicable):** If you are using Security Groups, ensure that the rules allow traffic between the instances in the peered VPCs.

#### Example (Conceptual):

Let's say you have two VPCs:

* VPC A: 10.0.0.0/16 (Web servers)
* VPC B: 172.16.0.0/16 (Database servers)
You want web servers in VPC A to access databases in VPC B.

1. VPC A requests a peering connection with VPC B.
2. VPC B accepts the peering connection.
3. In VPC A's route table, you add a route: Destination: 172.16.0.0/16, Target: Peering Connection (the ID of the peering connection).
4. In VPC B's route table, you add a route: Destination: 10.0.0.0/16, Target: Peering Connection (the same peering connection ID).
5. Security groups in both VPCs must allow the necessary traffic (e.g., allowing web servers to connect to the database port).

#### Important Considerations:

* Transitive Peering: VPC peering is not transitive. If VPC A is peered with VPC B, and VPC B is peered with VPC C, it does not automatically mean that VPC A can communicate with VPC C. You would need a separate peering connection between A and C.
* Overlapping CIDR Blocks: You cannot peer VPCs that have overlapping CIDR blocks.
* Security: Even with peering, it's still important to use security groups and other security measures to control access between the VPCs.