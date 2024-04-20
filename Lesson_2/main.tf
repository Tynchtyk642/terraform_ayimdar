resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_tip
  subnet_id     = data.aws_subnets.default_subnet.ids[1]
  user_data     = var.userdata

  tags = {
    "Name" = var.instance_name
  }
}



# resource "google_compute_instance" "name" {
#   name     = var.instance_name
#   userdata = var.userdata
# }
