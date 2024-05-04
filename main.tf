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

module "rds" {
  source = "./rds"

  db_private_subnets = module.vpc.private_subnet_ids
  db_security_group  = module.sg.rds_ec2_id

  depends_on = [module.vpc]
}

module "elb" {
  source = "./elb"

  subnets = module.vpc.public_subnet_ids
  vpc     = module.vpc.vpc_id
  asg     = module.autoscaling.asg
}

module "autoscaling" {
  source = "./autoscaling"

  elb          = module.elb.elb
  vpc_subnets  = module.vpc.public_subnet_ids
  target_group = module.elb.target_group.arn
  instance_sg  = module.sg.ec2_rds_id
}