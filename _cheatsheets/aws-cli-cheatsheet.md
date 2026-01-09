---
layout: cheatsheet
title: AWS CLI Command Cheatsheet
description: Essential AWS CLI commands for cloud management
---
# AWS CLI Command Cheatsheet

A comprehensive reference for AWS Command Line Interface.

## Installation & Configuration

### Install AWS CLI
```bash
# Linux/macOS
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# macOS (Homebrew)
brew install awscli

# Windows
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
```

### Configure
```bash
aws configure                        # Interactive setup
aws configure --profile prod         # Named profile
aws configure list                   # Show configuration
aws configure get region             # Get specific value
```

### Configuration Files
```bash
# ~/.aws/credentials
[default]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY

[prod]
aws_access_key_id = PROD_ACCESS_KEY
aws_secret_access_key = PROD_SECRET_KEY

# ~/.aws/config
[default]
region = us-east-1
output = json

[profile prod]
region = us-west-2
output = table
```

## EC2 (Elastic Compute Cloud)

### Instances
```bash
# List instances
aws ec2 describe-instances
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType]' --output table

# Start/Stop/Terminate
aws ec2 start-instances --instance-ids i-1234567890abcdef0
aws ec2 stop-instances --instance-ids i-1234567890abcdef0
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
aws ec2 reboot-instances --instance-ids i-1234567890abcdef0

# Launch instance
aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --instance-type t2.micro --key-name MyKeyPair --security-group-ids sg-903004f8 --subnet-id subnet-6e7f829e
```

### AMIs
```bash
# List AMIs
aws ec2 describe-images --owners self
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-*"

# Create AMI
aws ec2 create-image --instance-id i-1234567890abcdef0 --name "My Server" --description "Backup"

# Deregister AMI
aws ec2 deregister-image --image-id ami-1234567890abcdef0
```

### Security Groups
```bash
# List security groups
aws ec2 describe-security-groups
aws ec2 describe-security-groups --group-ids sg-903004f8

# Create security group
aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"

# Add rule
aws ec2 authorize-security-group-ingress --group-id sg-903004f8 --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-903004f8 --protocol tcp --port 80 --cidr 0.0.0.0/0

# Remove rule
aws ec2 revoke-security-group-ingress --group-id sg-903004f8 --protocol tcp --port 22 --cidr 0.0.0.0/0
```

### Key Pairs
```bash
# List key pairs
aws ec2 describe-key-pairs

# Create key pair
aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text > MyKeyPair.pem
chmod 400 MyKeyPair.pem

# Delete key pair
aws ec2 delete-key-pair --key-name MyKeyPair
```

## S3 (Simple Storage Service)

### Buckets
```bash
# List buckets
aws s3 ls
aws s3 ls s3://bucket-name
aws s3 ls s3://bucket-name/path/ --recursive

# Create bucket
aws s3 mb s3://bucket-name
aws s3 mb s3://bucket-name --region us-west-2

# Delete bucket
aws s3 rb s3://bucket-name
aws s3 rb s3://bucket-name --force  # Delete with contents
```

### Objects
```bash
# Upload file
aws s3 cp file.txt s3://bucket-name/
aws s3 cp file.txt s3://bucket-name/path/file.txt
aws s3 cp folder/ s3://bucket-name/folder/ --recursive

# Download file
aws s3 cp s3://bucket-name/file.txt .
aws s3 cp s3://bucket-name/folder/ . --recursive

# Sync
aws s3 sync . s3://bucket-name/
aws s3 sync s3://bucket-name/ .

# Delete
aws s3 rm s3://bucket-name/file.txt
aws s3 rm s3://bucket-name/folder/ --recursive
```

### Bucket Operations
```bash
# Get bucket policy
aws s3api get-bucket-policy --bucket bucket-name

# Set bucket policy
aws s3api put-bucket-policy --bucket bucket-name --policy file://policy.json

# Enable versioning
aws s3api put-bucket-versioning --bucket bucket-name --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption --bucket bucket-name --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
```

## IAM (Identity and Access Management)

### Users
```bash
# List users
aws iam list-users

# Create user
aws iam create-user --user-name john

# Delete user
aws iam delete-user --user-name john

# Create access key
aws iam create-access-key --user-name john

# List access keys
aws iam list-access-keys --user-name john
```

### Groups
```bash
# List groups
aws iam list-groups

# Create group
aws iam create-group --group-name Developers

# Add user to group
aws iam add-user-to-group --user-name john --group-name Developers

# Remove user from group
aws iam remove-user-from-group --user-name john --group-name Developers
```

### Policies
```bash
# List policies
aws iam list-policies --scope Local

# Attach policy to user
aws iam attach-user-policy --user-name john --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess

# Attach policy to group
aws iam attach-group-policy --group-name Developers --policy-arn arn:aws:iam::aws:policy/PowerUserAccess

# Create policy
aws iam create-policy --policy-name MyPolicy --policy-document file://policy.json
```

### Roles
```bash
# List roles
aws iam list-roles

# Create role
aws iam create-role --role-name MyRole --assume-role-policy-document file://trust-policy.json

# Attach policy to role
aws iam attach-role-policy --role-name MyRole --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess
```

## Lambda

### Functions
```bash
# List functions
aws lambda list-functions

# Create function
aws lambda create-function --function-name my-function --runtime python3.9 --role arn:aws:iam::123456789012:role/lambda-role --handler lambda_function.lambda_handler --zip-file fileb://function.zip

# Invoke function
aws lambda invoke --function-name my-function output.txt
aws lambda invoke --function-name my-function --payload '{"key":"value"}' output.txt

# Update function code
aws lambda update-function-code --function-name my-function --zip-file fileb://function.zip

# Delete function
aws lambda delete-function --function-name my-function
```

## RDS (Relational Database Service)

### DB Instances
```bash
# List DB instances
aws rds describe-db-instances

# Create DB instance
aws rds create-db-instance --db-instance-identifier mydb --db-instance-class db.t2.micro --engine mysql --master-username admin --master-user-password password --allocated-storage 20

# Delete DB instance
aws rds delete-db-instance --db-instance-identifier mydb --skip-final-snapshot

# Create snapshot
aws rds create-db-snapshot --db-instance-identifier mydb --db-snapshot-identifier mydb-snapshot

# Restore from snapshot
aws rds restore-db-instance-from-db-snapshot --db-instance-identifier mydb-restored --db-snapshot-identifier mydb-snapshot
```

## CloudFormation

### Stacks
```bash
# List stacks
aws cloudformation list-stacks
aws cloudformation describe-stacks

# Create stack
aws cloudformation create-stack --stack-name my-stack --template-body file://template.yaml
aws cloudformation create-stack --stack-name my-stack --template-url https://s3.amazonaws.com/bucket/template.yaml

# Update stack
aws cloudformation update-stack --stack-name my-stack --template-body file://template.yaml

# Delete stack
aws cloudformation delete-stack --stack-name my-stack

# Validate template
aws cloudformation validate-template --template-body file://template.yaml
```

## CloudWatch

### Logs
```bash
# List log groups
aws logs describe-log-groups

# Get log events
aws logs tail /aws/lambda/my-function --follow
aws logs filter-log-events --log-group-name /aws/lambda/my-function --filter-pattern "ERROR"

# Create log group
aws logs create-log-group --log-group-name my-log-group

# Delete log group
aws logs delete-log-group --log-group-name my-log-group
```

### Metrics
```bash
# List metrics
aws cloudwatch list-metrics

# Get metric statistics
aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --dimensions Name=InstanceId,Value=i-1234567890abcdef0 --start-time 2024-01-01T00:00:00Z --end-time 2024-01-01T23:59:59Z --period 3600 --statistics Average
```

## ECS (Elastic Container Service)

### Clusters
```bash
# List clusters
aws ecs list-clusters

# Create cluster
aws ecs create-cluster --cluster-name my-cluster

# Delete cluster
aws ecs delete-cluster --cluster my-cluster
```

### Tasks
```bash
# List tasks
aws ecs list-tasks --cluster my-cluster

# Run task
aws ecs run-task --cluster my-cluster --task-definition my-task:1

# Stop task
aws ecs stop-task --cluster my-cluster --task arn:aws:ecs:region:account-id:task/task-id
```

## Route 53

### Hosted Zones
```bash
# List hosted zones
aws route53 list-hosted-zones

# Create hosted zone
aws route53 create-hosted-zone --name example.com --caller-reference $(date +%s)

# List record sets
aws route53 list-resource-record-sets --hosted-zone-id Z1234567890ABC
```

## VPC (Virtual Private Cloud)

### VPCs
```bash
# List VPCs
aws ec2 describe-vpcs

# Create VPC
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# Delete VPC
aws ec2 delete-vpc --vpc-id vpc-1234567890abcdef0
```

### Subnets
```bash
# List subnets
aws ec2 describe-subnets

# Create subnet
aws ec2 create-subnet --vpc-id vpc-1234567890abcdef0 --cidr-block 10.0.1.0/24

# Delete subnet
aws ec2 delete-subnet --subnet-id subnet-1234567890abcdef0
```

## Common Options

### Output Formats
```bash
--output json                        # JSON format (default)
--output table                       # Table format
--output text                        # Text format
--output yaml                        # YAML format
```

### Filtering & Querying
```bash
--query 'Reservations[*].Instances[*].[InstanceId,State.Name]'
--filters "Name=instance-state-name,Values=running"
--max-items 10
--page-size 100
```

### Profiles & Regions
```bash
--profile prod                       # Use named profile
--region us-west-2                   # Specify region
```

## Quick Reference

| Service | Command | Description |
|---------|---------|-------------|
| EC2 | `aws ec2 describe-instances` | List instances |
| S3 | `aws s3 ls` | List buckets |
| S3 | `aws s3 cp file s3://bucket/` | Upload file |
| IAM | `aws iam list-users` | List users |
| Lambda | `aws lambda list-functions` | List functions |
| RDS | `aws rds describe-db-instances` | List databases |
| CloudFormation | `aws cloudformation list-stacks` | List stacks |
| CloudWatch | `aws logs tail /log-group` | Tail logs |

## Best Practices

1. **Use IAM roles** instead of access keys when possible
2. **Use named profiles** for multiple accounts
3. **Enable MFA** for sensitive operations
4. **Use --dry-run** for testing commands
5. **Tag resources** for better organization
6. **Use CloudFormation** for infrastructure as code
7. **Enable CloudTrail** for audit logging
8. **Use --query** for filtering output
9. **Set default region** in config
10. **Rotate access keys** regularly

## Resources

- Official Documentation: https://docs.aws.amazon.com/cli/
- AWS CLI Command Reference: https://awscli.amazonaws.com/v2/documentation/api/latest/index.html
- AWS CLI GitHub: https://github.com/aws/aws-cli
- AWS CLI Examples: https://github.com/awsdocs/aws-doc-sdk-examples
