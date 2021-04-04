terraform {
  backend "s3" {
    bucket = "iac-demo-terraform"
    key    = "iac-101-cf.tfstate"
    region = "ap-southeast-1"
  }
}