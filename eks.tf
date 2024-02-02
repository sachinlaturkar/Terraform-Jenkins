provider "aws" {
  region = "us-west-2"  # Update with your desired AWS region
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

      key_name        = "your-key-pair-name"
      instance_type   = "t2.small"
      key_name        = "your-key-pair-name"
      additional_security_group_ids = ["sg-09655465483b499e2"]
    }
  }

  node_groups_defaults = {
    key_name      = "your-key-pair-name"
    additional_security_group_ids = ["sg-09655465483b499e2"]
  }
}
