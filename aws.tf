terraform {
  backend "s3" {
    bucket = "eq-terraform-state"
    region = "eu-west-1"
  }
}

provider "aws" {
  allowed_account_ids = ["${var.aws_account_id}"]

  assume_role {
    role_arn = "${var.aws_assume_role_arn}"
  }

  region = "eu-west-1"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
