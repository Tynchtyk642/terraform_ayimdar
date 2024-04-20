terraform {
  backend "s3" {
    bucket = "terraform.tfstate-ayimdar"
    key    = "networking/terraform.tfstate"
  }
}
