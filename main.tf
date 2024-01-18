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
  source = "./aws-resources/vpc"
}

module "rds" {
  source = "./aws-resources/rds"

  db_private_subnet1 = module.vpc.private1_subnet
  db_private_subnet2 = module.vpc.private2_subnet
}