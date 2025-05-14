# Create Key-Pair
resource "aws_key_pair" "terraform_key" {
    key_name = "terra-ec2-key"
    public_key = file("terra-ec2-key.pub")
}

# Create Default VPC
resource "aws_default_vpc" "Default" {
  tags = {
    Name = "Default VPC"
  }
}

# Create Security Group
resource "aws_security_group" "terra-sg" {
  name = "Terra-sg"
  description = "Allows HTTP,Flask,SSH"
  vpc_id = aws_default_vpc.Default.id
  tags = {
    Name = "Terra-sg"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    description = "HTTP open"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    description = "SSH open"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    description = "Flask Open"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance 
resource "aws_instance" "Terra-Server" {
    for_each = tomap({
      Terra_instance-1 = "t2.micro"
      Terra_instance-2 = "t2.micro"
    })
    ami = var.ami
    key_name = aws_key_pair.terraform_key.key_name
    security_groups = [aws_security_group.terra-sg.name]
    instance_type = each.value
    user_data = file("nginx.sh")
    tags = {
      Name = each.key
    }
    root_block_device {
      volume_size = var.env == "production" ? 15 : var.ec2_default_root_block_device
      volume_type = "gp3"
    }
} 