terraform {
  backend "s3" {
    bucket = "terraform.tfstate-ayimdar"
    key    = "s3/terraform.tfstate"
  }
}


locals {
  bucket_config = {
    dev = {
      first-bucket-ayimdar = {}
    }
    stage = {
      second-bucket-dev = {}
    }
    prod = {
      third-bucket-prod = {}
    }
  }
}




resource "aws_s3_bucket" "buckets" {
  for_each = local.bucket_config[terraform.workspace]
  bucket   = each.key

  tags = {
    Name        = each.key
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "name" {
  for_each = local.bucket_config
  bucket   = aws_s3_bucket.buckets[each.key].id
  versioning_configuration {
    status = lookup(each.value, "versioning", "Enabled")
  }
}


