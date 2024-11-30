### Steps

- Create the `aws_iam_role` along with the `assume_role_policy` block
- Create the `aws_iam_instance_profile` that will attach the role to the EC2 instance
- Create the `aws_iam_role_policy` that will contain the policy associated with the `aws_iam_role`
- Create the `aws_iam_policy_document` that Generates an IAM policy document in JSON format for use with resources that expect policy documents like `aws_iam_role_policy`
- Attach the created role to the ec2 instance using this line => `iam_instance_profile = aws_iam_role.demo_role.name`


### References
- [AWS IAM EC2 Instance Role using Terraform](https://devopslearning.medium.com/aws-iam-ec2-instance-role-using-terraform-fa2b21488536)
- [Resource: aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)
- [Data Source: aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)
- [Resource: aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
