terraform {
  backend "s3" {
    bucket = "terraform.tfstate-ayimdar"
    key    = "ec2/terraform.tfstate"
  }
}

locals {
  name = "ayimdar"
}

resource "aws_instance" "instance" {
  ami             = data.aws_ami.ami.id
  instance_type   = "t3.micro"
  subnet_id       = data.terraform_remote_state.networking.outputs.subnet
  security_groups = ["sg-0756105e1c43b6dac"]

  tags = {
    "Name" = "${local.name}-instance"
  }
}

resource "aws_security_group" "sg" {
  vpc_id = data.terraform_remote_state.networking.outputs.vpc
}


