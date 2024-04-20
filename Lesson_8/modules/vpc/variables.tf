variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "name" {
  default = "ayimdar"
}

variable "public_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidrs" {
  default = []
}
