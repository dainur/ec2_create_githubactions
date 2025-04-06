# Провайдер AWS
provider "aws" {
  region = var.region
}

# Група безпеки (дозволяє SSH з будь-якої IP-адреси — за потреби обмеж)
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg-${timestamp()}"  # Add a timestamp for uniqueness
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 інстанс
resource "aws_instance" "my_ec2" {
  ami             = "ami-03250b0e01c28d196"
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "GitHubActionsEC2"
  }
}

# Змінна для регіону
variable "region" {
  default = "eu-central-1"
}

# Змінна для ключа SSH
variable "key_name" {
  description = "Назва існуючого SSH ключа у AWS"
  default     = "myacademykey.pem"
}
