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

variable "access_list" {
  description = "IP Whitelist"
}
