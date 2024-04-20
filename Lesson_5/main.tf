terraform {
  backend "s3" {
    bucket               = "terraform.tfstate-ayimdar"
    key                  = "lesson_5/terraform.tfstate"
    workspace_key_prefix = "env"
    kms_key_id           = "alias/terraform.tfstate"
    encrypt              = true
  }
}


locals {
  azs = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

data "aws_subnet" "name" {
  filter {
    name   = "tag:Name"
    values = ["test"]
  }
}


resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "test"
    env  = "dev"
  }
}



