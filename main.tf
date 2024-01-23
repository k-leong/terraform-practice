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
  source = "./ec2-ebs/ec2"
}

module "ebs" {
  source = "./ec2-ebs/ebs"
}

module "vpc" {
  source = "./ec2-ebs/vpc"
}