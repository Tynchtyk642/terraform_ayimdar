
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "Aiymdar"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"


  tags = {
    Name = "Main"
  }
}

resource "aws_instance" "web-test" {
  ami                         = "ami-051f8a213df8bc089"
  instance_type               = "t3.medium"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"

  tags = {
    Name = "Aimdar"
    env  = "dev"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}
