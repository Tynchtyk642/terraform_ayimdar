resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = merge({
    "Name" = "${var.name}-vpc"
  }, var.vpc_tags)
}


resource "aws_subnet" "public_subnets" {
  for_each = toset(var.public_cidrs)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.key

  tags = {
    "Name" = "${var.name}-public-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  count  = var.public_cidrs != [] ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "${var.name}-igw"
  }
}


resource "aws_route_table" "public" {
  count = var.public_cidrs != [] ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[count.index].id
  }
}

resource "aws_route_table_association" "public" {
  for_each       = toset(var.public_cidrs)
  route_table_id = aws_route_table.public[0].id
  subnet_id      = aws_subnet.public_subnets[each.key].id

}

resource "aws_subnet" "private_subnets" {
  for_each = toset(var.private_cidrs)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.key

  tags = {
    "Name" = "${var.name}-private-subnet-${each.key}"
  }
}

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.vpc.id

#   route = [{
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }]
# }

# resource "aws_route_table_association" "private" {
#   for_each       = toset(var.private_cidrs)
#   route_table_id = aws_route_table.private.id
#   subnet_id      = aws_subnet.private_subnets[each.key].id

# }
