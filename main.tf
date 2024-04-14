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

module "ec2" {
  source = "./ec2"

  subnet             = module.vpc.public_subnet_ids[0]
  ec2_security_group = module.sg.ec2_rds_id
}

module "rds" {
  source = "./rds"

  db_private_subnets = module.vpc.private_subnet_ids
  db_security_group  = module.sg.rds_ec2_id
}

module "elb" {
  source = "./elb"

  subnets = module.vpc.public_subnet_ids
}

module "autoscaling" {
  source = "./autoscaling"

  ami           = module.ec2.ec2_ami
  instance_type = module.ec2.ec2_instance_type
  user_data     = module.ec2.ec2_user_data
  elb           = module.elb.elb
}