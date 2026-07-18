### AWS CloudShell
- AWS CloudShell is a browser-based shell that gives you command-line access to your AWS resources in the selected AWS region.
- AWS CloudShell comes pre-installed with popular tools for resource management and creation.
- You have the same credentials as you used to log in to the console.

### IAM Credentials Report
- The credentials report lists all your IAM users in this account and the status of their various credentials.
- After a report is created, it is stored for up to four hours.

### IAM Access Advisor
- Access Advisor shows the services that this user can access and when those services were last accessed.

### Placement Groups
- `Placement groups` gives you control over the EC2 instances placement strategy.
- When you create a placement group, you specify one of the following strategies for the group:
  - `Clsuter` => clusters instances into a low-latency group in a single Availability Zone
  - `Spread` => spreads instances across underlying hardware (max 7 instances per group per AZ)
  - `Partition` => spreads instances across many different partitions (which rely on different sets of racks) within an AZ. Scales to 100s of EC2 instances per group (Hadoop, Cassandra, Kafka).


### Creating VPC steps
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
* [ ] Add route to Internet Gateway in public route table (0.0.0.0/0).
* [ ] Define private route table resource (no internet gateway route).
* [ ] Associate public subnets with public route table.
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
