# Terraform

### What is Terraform?
- Terraform is a vendor-agnostic IAC `"infrastructure as a code"` tool.
- There are many providers for almost any infrastructure we need to setup for ex: `aws, gcp, azure, ....`.
- Terraform uses **HCL** which is `Hashicorp configuration language` which is a declarative language to define the infrastructure resources to be provisioned as blocks of code.
- **Terraform** have 2 states: the current state & the desired state.
- It will take care of what is required to go from the current state to the desired state.
- **Terraform** works on three phases: `Init`, `Plan` & `Apply`.
- Every object terraform manages, is called a `Resource`.
- `Resource` can be a compute instance, database server, virtual server on the cloud or a physical server on-premises that terraform manages.
- **Terraform** manages the lifecycle of the resources from provisioning to configuration to decommissioning.
- **Terraform** can ensure that the entire infrastructure is always in the defined state at all times.


### HCL (Hashicorp Configuration Language)
- Sample of the HCL for terraform configuration:
```hcl
<block> <parameters> {
    key1 = value1
    key2 = value2
}
```
  

### Providers
- Providers are a logical abstraction of an upstream API. They are responsible for understanding API interactions and exposing resources.
- **Providers** have 3 tiers: `Official`, `Partner` & `Community`
  - `Official`: Official providers are owned and maintained by HashiCorp.
  - `Partner`: Partner providers are owned and maintained by a technology company that has gone through our partner onboarding process and maintain a direct partnership with HashiCorp. Partner providers are actively supported by the publishing organization.
  - `Community`: Community providers are published and maintained by individual contributors of our ecosystem.
- **Terraform** supports the use of multiple providers in the same configuration file.


### Terraform Variables
- Variable Definition Precedence:
  1. `Environment Variables`
  2. `terraform.tfvars` will override the variables from the environment variables
  3. `*.auto.tfvars` will override the variables from above
  4. `-var or -var-file (command-line flags)` have the highest precedence
- To use environment variables as terraform variables: `export TF_VAR_<variable_name>`
- If we have a custom variable file named other than the default variable file name '`terraform.tfvars`' we need to use this command: `terraform apply -var-file <variables-file-name>.tfvars`


### Terraform resource attributes
- to reuse some values from another resource into my specific resource => `${resource_type.resource_name.attribute}`.
- Ex: `${random_pet.my-pet.id}`


### Output variables
- Ex of the output variable in terraform:
```hcl
  output "<variable_name>" {
    value = "<variable_value>"
    <arguments>
  }
```
- To check the output values run this command => `terraform output` or `terraform output <output_name>`

### Terraform Commands
- `terraform validate` => validate if the terraform configuration files are correct
- `terraform fmt` => format the configuration files of terraform
- `terraform show` => prints the current state of the resources in the infrastructure as seen by terraform
- `terraform show -json` => same as the above command but in a json format
- `terraform providers` => to see a list of all providers used in the configuration directory
- `terraform refresh` => used to sync terraform with real world infrastructure. This command will not modify any infrastructure resource, instead it will modify the state file.
- `terraform graph` => visualize dependencies between resources

### Lifecycle rules
```hcl
lifecycle {
  create_before_destroy = true/false
  prevent_destroy = true/false
  ignore_changes = ['arguments here!']
}
```

### Providers Versions
```hcl
terraform{
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.0.0" # version here must equals to 2.0.0
      version = "!= 2.0.0" # version here must not equal to 2.0.0
      version = "< 2.0.0" # version here must be less than 2.0.0
      version = "> 2.0.0" # version here must be greater than 2.0.0
      version = "< 2.0.0, < 1.4.0, != 1.6.0" # version here must be less than 2.0.0 & greater than 1.4.0 & != 1.6.0
    }
  }
}
```