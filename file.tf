terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
variable "Instance_variables1" {
  type = string

}
locals {
  service_name = "bulk"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0a8b4cd432b1c3063"
  instance_type = var.Instance_variables1


  tags = {
    Name = "myserver-${local.service_name}"
  }
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}




output "instance_ip_addr" {
  value = aws_instance.app_server.private_ip
}

