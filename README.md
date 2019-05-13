# eq-terraform-elasticsearch

This Terraform creates a standalone environment that runs an elastic search cluster with the lookup lists deployed and the `eq-lookup-api` to query the lists

## Setup

Copy `terraform.tfvars.example` to `terraform.tfvars` filling in the required values

## Running

  - Run `terraform init` to import the different modules and set up remote state. When asked to provide a name for the state file choose the same name as the `env` value in your `terraform.tfvars`

  - Run `terraform plan` to check the output of terraform

  - Run `terraform apply` to create your infrastructure environment

  - Run `terraform destroy` to destroy your infrastructure environment