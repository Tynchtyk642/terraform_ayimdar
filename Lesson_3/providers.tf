provider "aws" {
}

provider "aws" {
  alias  = "aiymdar"
  region = "us-west-2"
}

provider "aws" {
  alias  = "terraform"
  region = "us-west-1"
}
