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

module "ec2" {
  source = "./ec2"
}

module "vpc" {
  source = "./vpc"
}

module "ebs" {
  source = "./ebs"

  instance = module.ec2.ec2_instance_id
  az = module.ec2.ec2_instance_az
}
