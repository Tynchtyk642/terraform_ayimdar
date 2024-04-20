output "vpc" {
  value = aws_vpc.vpc.id
}

output "subnet" {
  value = aws_subnet.private.id
}

output "sg_id" {
  value = aws_security_group.sg.id
}
