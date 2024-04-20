resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }

  depends_on = [aws_instance.web]
}

resource "aws_subnet" "subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.main.id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  provider      = aws.aiymdar
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = var.name
    env  = "dev"
  }
}

resource "aws_instance" "http" {
  provider      = aws.terraform
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = var.name
    env  = "dev"
  }
}
