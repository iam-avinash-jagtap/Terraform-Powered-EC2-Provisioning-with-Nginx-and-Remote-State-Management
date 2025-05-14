# Terraform-Powered EC2 Provisioning with Nginx and Remote State Management
This project you are going to automate the Terraform  setup of two EC2 instances on AWS with custom SSH keys, security groups, and Nginx installed. The state is securely stored in an S3 bucket for remote management. It includes basic infrastructure like a default VPC and custom security rules. The Nginx welcome page can be accessed using the public IP of each instance, making it a great hands-on learning experience for managing cloud resources with Terraform.

## Project Structure 
### EC2 Instance
```bash
├── main.tf              # EC2, VPC, SG, KeyPair configuration
├── provider.tf          # AWS Provider
├── terraform.tf         # S3 Backend definition
├── variable.tf          # All input variables
├── output.tf            # Public IP/DNS outputs
├── nginx.sh             # User data script to install Nginx
├── terra-ec2-key.pub    # Public key for SSH

```
### Remote State
```bash
├── s3.tf            # Create S3 bucket for remote state
├── provider.tf      # Define AWS provider region
├── terraform.tf     # Configure backend with S3
├── dynamodb.tf      # Create DynamoDB table for state locking
```
## 📦 Project Features
- Two EC2 instances with user-defined instance types.

- Custom SSH key for secure access.

- Nginx installation via user_data.

- Security Group with HTTP, Flask (8000), and SSH access.

- Conditional root volume size based on environment.

- Remote Terraform state management using S3

- Outputs: Public IP, DNS, and Private IP of EC2 instances.

- State locking enabled with DynamoDB LockID to avoid conflicts during parallel runs


## 📝 Prerequisites
### 🛠️ Tools Required
- **AWS Account** – To create and manage cloud resources

- **EC2 Instance** – To run Terraform CLI

- **IAM Role with Admin Access** – To allow the EC2 instance to perform actions in AWS

- **SSH Key Pair** – For secure access to EC2 instances

- **Git** – To clone project files from a repository

- **Terraform Installed** – Infrastructure as Code tool

### ✅ Knowledge Required
- Basic AWS Knowledge

    - EC2, VPC, Security Groups, IAM, S3, DynamoDB (Beginner level is enough)

- Basic Terraform Skills

    - Understanding of resources, variables, outputs, and remote state (Entry to Intermediate level)

- Linux Command Line

    - Comfort using shell commands and editing files (Beginner level)

- SSH & Key Management

    - Know how to generate and use SSH keys to connect to instances


## 🔑 SSH Key Generation
_Generate an SSH key pair to securely access EC2 instances via terminal._
```bash
ssh-keygen -t rsa -f terra-ec2-key
# Upload `terra-ec2-key.pub` in the project directory

```

# 🚀 Step-by-Step Setup

## 1️⃣ Launch EC2 Instance
Launch a base EC2 instance (e.g., Amazon Linux 2) where Terraform will be installed.

[EC2_Instance_Launch_Steps](https://github.com/iam-avinash-jagtap/Linux-Server-Deployment-on-AWS-E2)

## 🔐 2️⃣ Attach IAM Role with Administrator Access
1. Go to the IAM Console
    - Open the AWS Management Console.

    - Navigate to IAM → Roles from the left-hand menu.
2. Create a New IAM Role
    - Click "Create role".

    - Select "AWS service" as the trusted entity type.

    - Choose "EC2" as the use case.

    - Click Next. 
3. Attach AdministratorAccess Policy
    - In the permissions step, search for AdministratorAccess.

    - Select the checkbox next to it (you can also choose a custom policy with limited access to EC2, VPC, and S3 if preferred).

    - Click Next. 
4. Name and Create the Role
    - Give your role a name like TerraformEC2AdminRole.

    - Click Create Role. 
5. Attach the Role to the EC2 Instance
    - Go to the EC2 Dashboard → Instances.

    - Select your EC2 instance where Terraform is installed.

    - Click Actions → Security → Modify IAM Role.

    - Choose the role you just created (TerraformEC2AdminRole).

    -  Click Update IAM Role.
## 3️⃣ Install Terraform
_Install Terraform CLI on the EC2 instance to manage and deploy AWS infrastructure using code._
```bash
# Update Packages
sudo yum install -y yum-utils

# Add the HashiCorp Repo
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo yum install terraform -y 

# Re-Update Packages
sudo yum update -y 

# Verify Terraform Installed
terraform --version 

```
## 4️⃣ Install Git
_Install Git to clone the Terraform project files from a remote GitHub repository._
```bash
# Install Git to Clone Code from GitHub
sudo yum install git -y 

# Verify Git Installed 
git --version 
```
## 5️⃣ Clone This Repository
_Clone the Terraform project repository to your EC2 instance using Git._
```bash
# Clone Code from Github
git clone https://github.com/iam-avinash-jagtap/Terraform-Powered-EC2-Provisioning-with-Nginx-and-Remote-State-Management.git
# Redirect to your project directory
cd Terraform-Powered-EC2-Provisioning-with-Nginx-and-Remote-State-Management/EC2_Instance_with_Nginx
# Verify Files - ec2.tf     provider.tf     terraform.tf        variable.tf     output.tf       nginx.sh
```
## 6️⃣ Initialize Terraform
_Initialize the Terraform working directory and download required provider plugins using:-_
```bash
terraform init
```
- Initialize Terraform Envoirenment for AWS 
## 7️⃣ Validate Configuration
_Validate the Terraform configuration files to ensure syntax and structure are correct using:-_
```bash
terraform validate 
```
## 8️⃣ Preview Infrastructure Plan
_Preview the planned infrastructure changes to be applied by Terraform using:-_
```bash
terraform plan
```
- Check your infrastructure preview

## 9️⃣ Apply Configuration to Launch EC2 Instances
_Apply the Terraform configuration to create and launch the EC2 instances and other resources by running:-_
```bash
terraform apply
# Type 'yes' when prompted
```
- It will create the following resources
    - Key-Pair
    - Use Default VPC
    - Security Group 
    - 2 EC2 Instances

## 🌐 Access Nginx Servers
_After applying, use the public IPs to access Nginx in your browser:_
```cpp
http://<public-ip-1>
http://<public-ip-2>
```
### Expected Output:
```html
Welcome to nginx _ By Tech_aj Using Terraform
```
# 🧾 Terraform State Management
```bash
# Redirect to your project directory
cd Terraform-Powered-EC2-Provisioning-with-Nginx-and-Remote-State-Management/Terraform_Remote_State
# Verify Files - s3.tf     provider.tf     terraform.tf        dynamodb.tf
```
## 1️⃣0️⃣ Initialize Terraform
_Initialize the Terraform working directory and download required provider plugins using:-_
```bash
terraform init
```
## 1️⃣1️⃣  Apply Configuration to Launch EC2 Instances
_Apply the Terraform configuration to create and launch the EC2 instances and other resources by running:-_
```bash
terraform apply
# Type 'yes' when prompted
```
- It will Create following recources
    - S3 bucket 
    -  DynamoDB table with LockID

## 🔒 S3 State Backend
The state is stored securely in s3 bucket:
- Edit terraform.tf file in - EC2_Instance  file
- Add - Backend Block 
```hcl
  backend "s3" {
    bucket = "terra-remote-bucket--004"
    region = "us-east-1"
    key = "terraform.tfstate"
    dynamodb_table = "Terra-Remote-DB-table--004"
  }
```
- Reinit Terraform 
- Change - Resource Block - aws_instance
- Add One more Instance Count
- Apply terraform using
```bash
terraform apply
# # Type 'yes' when prompted
```
### What will happen after this ?
1. Update your infrastructure 
2. Launch 3 Instances 
3. Nginx Installed on all 3 
4. terraform.tfstate - File Stored in S3 bucket
5. DynamoDB table LockID with your Current Terminal 

## 🗑️ Delete Local State File
_Your .tfstate file is stored in remote backend, now you can delete .tfstate and backup file from your Terra-server._
```bash
rm -f terraform.tfstate terraform.tfstate.backup
``` 
### You have sucessfully stored your .tfstate file securely on remote backend.
## 📜 Terraform State Commands
_This is an Optional Step, but you can perform some terraform state operations._
```bash
terraform state list           # List all resources
terraform state show <name>   # Show specific resource details
terraform state rm <name>     # Remove resource from state
terraform import <addr> <id>  # Import existing resource into Terraform
```

## 🧹 Clean Up Resources
To destroy all created infrastructure:
```bash
terraform destroy
# Type 'yes' when prompted
```
# Summary 
This project demonstrates how to use Terraform to automate the deployment of two EC2 instances in AWS. It covers the complete setup, including creating a custom SSH key pair, launching instances in a default VPC, and attaching a security group that allows HTTP (port 80), SSH (port 22), and Flask (port 8000) access. A shell script (nginx.sh) is used to automatically install and start the Nginx web server on each instance during launch.

The EC2 instances are created with a custom root volume size, which is conditionally defined based on the environment (e.g., 15 GB for production). The Terraform state file is not stored locally—instead, it’s securely saved in an S3 bucket (terraform-bucket-backend-004) with a specific key (terraform.tfstate) in the us-east-1 region. To prevent concurrent modifications of the state file during team operations, a DynamoDB table is configured to manage state locking using a LockID. This ensures safe, consistent, and collaborative infrastructure deployments.

In addition, an IAM role with AdministratorAccess is attached to the EC2 instance running Terraform, giving it the necessary permissions to create and manage AWS resources. The project includes essential Terraform commands like init, validate, plan, and apply for deployment, and uses output blocks to display the public and private IPs and DNS of the instances.

This setup is ideal for beginners and intermediate DevOps learners who want hands-on experience with infrastructure as code, EC2 provisioning, remote state management using S3 and DynamoDB, and automated configuration using user data scripts.