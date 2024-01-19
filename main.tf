terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "./ec2-rds-web-architecture/vpc"
}

resource "random_shuffle" "subnet" {
  input = module.vpc.public_subnets
}

module "ec2" {
  source = "./ec2-rds-web-architecture/ec2"

  subnet = random_shuffle.subnet.result
}

# module "rds" {
#   source = "./ec2-rds-web-architecture/rds"

#   db_private_subnet1 = module.vpc.private1_subnet
#   db_private_subnet2 = module.vpc.private2_subnet
# }