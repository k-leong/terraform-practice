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
  source = "./vpc"
}

module "sg" {
  source = "./sg"

  vpc_id = module.vpc.vpc_id
}

resource "random_shuffle" "subnet" {
  input = module.vpc.public_subnet_ids
}

module "ec2" {
  source = "./ec2"

  subnet             = random_shuffle.subnet.result
  ec2_security_group = module.sg.ec2_rds_id
}

module "rds" {
  source = "./rds"

  db_private_subnets = module.vpc.private_subnet_ids
  db_security_group  = module.sg.rds_ec2_id
}