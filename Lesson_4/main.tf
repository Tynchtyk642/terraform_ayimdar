terraform {
  backend "s3" {
    bucket            = "aiymdar-tfstate"
    key               = "dev/terraform.tfstate"
    dynamodb_endpoint = "terraform-state-lock-dynamo"
    encrypt           = true
    kms_key_id        = "alias/kms"
  }
}

locals {
  vpc_id = aws_vpc.vpc.id
  name   = "aiymdar"
}


resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "${local.name}-vpc"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id = local.vpc_id

  cidr_block              = "10.0.1.0/28"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "${local.name}-public-subnet"
  }

  lifecycle {
    ignore_changes = [cidr_block, tags["Name"]]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    "Name" = "${local.name}-igw"
  }
}

resource "aws_route_table" "rtb-public" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "name" {
  route_table_id = aws_route_table.rtb-public.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_subnet" "private_subnet" {
  vpc_id = local.vpc_id

  cidr_block = "10.0.2.0/28"

  tags = {
    "Name" = "${local.name}-private-subnet"
  }
}


resource "aws_security_group" "sg" {
  vpc_id = "vpc-0ac55c47221ec109e"
  lifecycle {
    create_before_destroy = true
  }
}
