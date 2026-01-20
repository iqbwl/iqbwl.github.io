---
layout: cheatsheet
title: Terraform Command Cheatsheet
description: Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services.
---


Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services.


## Basic Commands

### Initialize
```bash
terraform init                       # Initialize directory
terraform init -upgrade              # Upgrade providers
terraform init -reconfigure          # Reconfigure backend
```

### Plan
```bash
terraform plan                       # Show execution plan
terraform plan -out=plan.tfplan      # Save plan
terraform plan -destroy              # Plan destroy
terraform plan -target=resource      # Target specific resource
```

### Apply
```bash
terraform apply                      # Apply changes
terraform apply plan.tfplan          # Apply saved plan
terraform apply -auto-approve        # Skip confirmation
terraform apply -target=resource     # Apply specific resource
```

### Destroy
```bash
terraform destroy                    # Destroy infrastructure
terraform destroy -auto-approve      # Skip confirmation
terraform destroy -target=resource   # Destroy specific resource
```

### Other Commands
```bash
terraform validate                   # Validate configuration
terraform fmt                        # Format code
terraform show                       # Show current state
terraform output                     # Show outputs
terraform refresh                    # Refresh state
terraform graph                      # Generate dependency graph
```

## State Management

### State Commands
```bash
terraform state list                 # List resources
terraform state show resource        # Show resource
terraform state mv source dest       # Move resource
terraform state rm resource          # Remove from state
terraform state pull                 # Pull remote state
terraform state push                 # Push state
```

### Workspace
```bash
terraform workspace list             # List workspaces
terraform workspace new dev          # Create workspace
terraform workspace select dev       # Switch workspace
terraform workspace delete dev       # Delete workspace
```

## Configuration Syntax

### Provider
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### Resource
```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = "WebServer"
  }
}
```

### Variables
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
```

### Outputs
```hcl
output "instance_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of instance"
}
```

### Data Sources
```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
```

### Locals
```hcl
locals {
  common_tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

## Modules

### Use Module
```hcl
module "vpc" {
  source = "./modules/vpc"
  
  cidr_block = "10.0.0.0/16"
  name       = "main-vpc"
}
```

### Module Output
```hcl
output "vpc_id" {
  value = module.vpc.vpc_id
}
```

## Backend Configuration

### S3 Backend
```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}
```

## Common Patterns

### Count
```hcl
resource "aws_instance" "server" {
  count         = 3
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = "Server-${count.index}"
  }
}
```

### For_each
```hcl
resource "aws_instance" "server" {
  for_each = toset(["web", "app", "db"])
  
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = each.key
  }
}
```

### Conditional
```hcl
resource "aws_instance" "server" {
  count = var.create_instance ? 1 : 0
  
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

### Dynamic Blocks
```hcl
resource "aws_security_group" "example" {
  name = "example"
  
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
```

## Functions

### Common Functions
```hcl
# String functions
upper("hello")
lower("HELLO")
title("hello world")
format("Hello, %s", var.name)

# Numeric functions
min(1, 2, 3)
max(1, 2, 3)
ceil(5.1)
floor(5.9)

# Collection functions
length(var.list)
concat(list1, list2)
merge(map1, map2)
lookup(map, "key", "default")

# Type conversion
tostring(123)
tonumber("123")
tolist(set)
toset(list)
```

## Import Existing Resources

### Import
```bash
terraform import aws_instance.web i-1234567890abcdef0
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize |
| `terraform plan` | Show plan |
| `terraform apply` | Apply changes |
| `terraform destroy` | Destroy all |
| `terraform validate` | Validate config |
| `terraform fmt` | Format code |
| `terraform state list` | List resources |
| `terraform output` | Show outputs |

## Best Practices

1. **Use version control**
2. **Use remote state** (S3, Terraform Cloud)
3. **Use modules** for reusability
4. **Use variables** for flexibility
5. **Use workspaces** for environments
6. **Run terraform fmt** regularly
7. **Use terraform validate** before apply
8. **Use -target sparingly**
9. **Document your code**
10. **Use consistent naming**

## Resources

- Official Documentation: https://www.terraform.io/docs/
- Terraform Registry: https://registry.terraform.io/
- Best Practices: https://www.terraform-best-practices.com/
- Learn Terraform: https://learn.hashicorp.com/terraform
