terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0, < 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Update with your desired AWS region
}

resource "aws_instance" "foo" {
  ami           = "ami-05fa00d4c63e32376"  # Update with your desired AMI
  instance_type = "t2.micro"
  tags = {
    Name = "TF-Instance"
  }
}

module "eks_cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  subnets         = ["subnet-08dfee3119a892f18", "subnet-06ff6888921e74051", "subnet-0edd2e1e62e37a6b6"]
  vpc_id          = "vpc-054bdd0e00e957bce"
  cluster_version = "1.21"

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      key_name        = "AWS_ACCESS_KEY_ID"  # Update with your key pair name
      instance_type   = "t2.small"
      additional_security_group_ids = ["sg-09655465483b499e2"]
    }
  }

  node_groups_defaults = {
    key_name      = "AWS_ACCESS_KEY_ID"  # Update with your key pair name
    additional_security_group_ids = ["sg-09655465483b499e2"]
  }
}
