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

  main_vpc_id = module.vpc.vpc_id
  peer_vpc_id = module.peer.vpc_id
}

module "rt" {
  source = "./rt"

  main_vpc_id = module.vpc.vpc_id
  main_cidr   = module.vpc.vpc_cidr
  main_subnet = module.vpc.public_subnet_ids[0]

  peering_cx_id = module.peering_connection.pcx_id

  peer_vpc_id = module.peer.vpc_id
  peer_cidr   = module.peer.vpc_cidr
  peer_subnet = module.peer.peer_subnet_id

}

module "ec2" {
  source = "./ec2"

  peer_subnet_id = module.peer.peer_subnet_id
  peer_sg_id     = module.sg.peer_sg_id

  subnet_id = module.vpc.public_subnet_ids[0]
  sg_id     = module.sg.sg_id
}

module "sg" {
  source = "./sg"

  vpc_id      = module.vpc.vpc_id
  peer_vpc_id = module.peer.vpc_id
}