provider "aws" {
  region = var.region
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-03250b0e01c28d196"
  instance_type = "t2.micro"

  tags = {
    Name = "GitHubActionsEC2"
  }
}

variable "region" {
  default = "eu-central-1"
}
