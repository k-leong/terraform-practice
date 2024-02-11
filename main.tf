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

module "peer" {
  source = "./peer_vpc"
}

module "peering_connection" {
  source = "./peering_connection"

  vpc_id      = module.vpc.vpc_id
  peer_vpc_id = module.peer.vpc_id
}
