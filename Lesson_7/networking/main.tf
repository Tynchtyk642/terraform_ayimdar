locals {
  name = "ayimdar"
  private_subnets = {
    "private-subnet-1" = {
      cidr_block = "10.0.1.0/24"
      env        = "dev"
    }
    "test-subnet-2" = {
      cidr_block = "10.0.1.0/24"
      env        = "prod"
    }
    "public-subnet-3" = {
      cidr_block = "10.0.1.0/24"
      env        = "stage"
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "${local.name}-vpc"
  }
}

resource "aws_subnet" "private" {
  for_each   = local.private_subnets
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value

  tags = {
    "Name" = each.key
  }
}

