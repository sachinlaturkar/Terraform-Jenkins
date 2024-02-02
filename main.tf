terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.35.0"
      region = "us-east-1"  
    }
  }
resource "aws_instance" "foo" {
  ami           = "ami-05fa00d4c63e32376" # us-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
