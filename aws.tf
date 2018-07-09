terraform {
  backend "s3" {
    region = "eu-west-1"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
