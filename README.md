# eq-terraform-elasticsearch

This repository contains a Terraform module that deploys an ElasticSearch cluster with static lookup data.

Below is an example how to to use this module.

```
module "elasticsearch" {
  source                          = "github.com/ONSdigital/eq-terraform-elasticsearch"
  env                             = "${var.env}"
  aws_access_key                  = "${var.aws_access_key}"
  aws_secret_key                  = "${var.aws_secret_key}"
  access_list                     = ["0.0.0.0/0"]
}
```