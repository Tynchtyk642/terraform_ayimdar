output "publics" {
  value = { for i, v in aws_subnet.public_subnets : i => v.id }
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
