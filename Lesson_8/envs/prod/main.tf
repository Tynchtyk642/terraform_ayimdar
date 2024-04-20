locals {
  ingresses = {
    22 = "10.0.0.0/16",
    80 = "0.0.0.0/0"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  public_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

  vpc_tags = {

  }
}

module "asg" {
  source = "../../modules/asg"

  name_prefix    = "ayimdar"
  instance_type  = "t3.micro"
  desired_size   = 2
  max_size       = 3
  min_size       = 1
  sg             = [aws_security_group.sg.id]
  public_subnets = [module.vpc.publics["10.0.1.0/24"], module.vpc.publics["10.0.2.0/24"]]
}


resource "aws_security_group" "sg" {
  vpc_id = module.vpc.vpc_id


  dynamic "ingress" {
    for_each = local.ingresses
    content {
      to_port     = ingress.key
      from_port   = ingress.key
      cidr_blocks = [ingress.value]
      protocol    = "tcp"
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


module "monitoring" {
  source = "../../modules/asg"

  name_prefix    = "ayimdar"
  instance_type  = "t3.micro"
  desired_size   = 2
  max_size       = 3
  min_size       = 1
  sg             = [aws_security_group.sg.id]
  public_subnets = [module.vpc.publics["10.0.1.0/24"], module.vpc.publics["10.0.2.0/24"]]
}
