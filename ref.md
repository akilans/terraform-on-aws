### Reference

```
<block> (parameter){
    (arguments)
    key1=value1
    key2=value2
}


resource "aws_instance" "demoec2" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  user_data     = file("${path.module}/install.sh")
}

resource - block name
aws_instance - provider_resource (resource type)
demoec2 - resource name
```

```
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
terraform show - shows all the attributes of created resources
terraform destroy
terraform apply --auto-approve
terraform output - shows all the ouput values
```

### Types of provider

- Offical - supported by hashicorp
- Partner - verified by hashicorp
- Community - Added by community

### Multiple providers

- local, aws, oci etc can be added in a single .tf file

### Variables

- Define variables in variables.tf
- terraform apply -var "myname=Akilan" or -var-file- High Priority
- \*.auto.tfvars - myname = "Inba" - 2nd priority
- \*.tfvars - myname = "Iniya" - 3rd priority
- TF_VAR_myname - env varible last priority
