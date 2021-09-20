# Terraform On AWS

### Terraform Fundamendals

- terraform init
- terraform validate
- terraform plan
- terraform apply -auto-approve
- terraform destroy
- terraform destroy -target aws_vpc.myVpc #delete a particular resource
- terraform state list - lists all the current resources
- terraform state show aws_vpc.myVpc - Get all the info

### variables

- Provide default one else it will prompt while applying
- terraform apply -var "vpc_name=myvpc"
- terraform.tfvars - keep variables here
- terraform apply -var-file terraform-dev.tfvars
- export TF_VAR_vpc_name - Define a varibable as env
-
