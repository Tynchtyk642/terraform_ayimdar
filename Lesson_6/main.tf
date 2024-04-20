terraform {
  backend "s3" {
    bucket               = "terraform.tfstate-ayimdar"
    key                  = "lesson_6/terraform.tfstate"
    workspace_key_prefix = "env"
    kms_key_id           = "alias/terraform.tfstate"
    encrypt              = true
    dynamodb_endpoint = ""
  }
}

locals {
  env  = var.env
  name = "${local.env}-vpc"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

  tags = {
    "Name" = "${terraform.workspace}-vpc"
  }
}

resource "aws_subnet" "private" {
  count  = terraform.workspace == "prod" ? 10 : 3
  vpc_id = aws_vpc.vpc.id

  cidr_block = "10.0.${count.index + 1}.0/24"
}
