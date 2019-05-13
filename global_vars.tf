variable "env" {
  description = "The environment you wish to use"
}

variable "aws_account_id" {
  description = "Amazon Web Service Account ID"
}

variable "aws_assume_role_arn" {
  description = "IAM Role to assume on AWS"
}

variable "instance_type" {
  description = "Instance type to use for the nodes"
  default     = "t2.medium.elasticsearch"
}

variable "instance_count" {
  description = "Number of Instances to use in the cluster"
  default     = "2"
}

variable "ebs_volume_size" {
  description = "Volume size for each EBS volume"
  default     = "10"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_cidrs" {
  type        = "list"
  description = "CIDR blocks for public subnets"
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "database_cidrs" {
  type        = "list"
  description = "CIDR blocks for database subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "application_cidrs" {
  type        = "list"
  description = "CIDR blocks for application subnets"
  default     = ["10.0.64.0/18", "10.0.128.0/18", "10.0.192.0/18"]
}

variable "certificate_arn" {
  description = "ARN of the IAM loaded TLS certificate for public ELB"
}

variable "access_ips" {
  description = "List of IP's or IP ranges to allow access the service"
  type        = "list"
}

variable "elasticsearch_provisioner_ip" {
  description = "The IP of the provisioner of elasticsearch"
}

// Alerting
variable "slack_webhook_path" {
  description = "Slack Webhook path for the alert. Obtained via, https://api.slack.com/incoming-webhooks"
}

# DNS
variable "dns_zone_name" {
  description = "Amazon Route53 DNS zone name"
  default     = "dev.eq.ons.digital"
}

variable "docker_registry" {
  description = "The docker repository for the image"
  default     = "onsdigital"
}

variable "lookup_api_tag" {
  description = "The tag for the Lookup API image to run"
  default     = "support-multi-language-lookups"
}
