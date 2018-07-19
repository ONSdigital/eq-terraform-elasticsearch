variable "env" {
  description = "The environment you wish to use"
}

variable "aws_secret_key" {
  description = "Amazon Web Service Secret Key"
}

variable "aws_access_key" {
  description = "Amazon Web Service Access Key"
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
