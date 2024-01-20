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

module "sg" {
  source = "./ec2-rds-web-architecture/sg"

  vpc_id = module.vpc.vpc_id
}

resource "random_shuffle" "subnet" {
  input = module.vpc.public_subnets
}

module "ec2" {
  source = "./ec2-rds-web-architecture/ec2"

  subnet             = random_shuffle.subnet.result
  ec2_security_group = module.sg.ec2_rds_id
}

module "rds" {
  source = "./ec2-rds-web-architecture/rds"

  db_private_subnets = module.vpc.private_subnets
  db_security_group  = module.sg.rds_ec2_id
}