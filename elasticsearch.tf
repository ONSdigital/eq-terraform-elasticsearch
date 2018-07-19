resource "aws_elasticsearch_domain" "suggest" {
  domain_name           = "${var.env}-suggest"
  elasticsearch_version = "6.2"

  cluster_config {
    instance_type  = "${var.instance_type}"
    instance_count = "${var.instance_count}"
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = "${var.ebs_volume_size}"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.env}-suggest/*",
            "Condition": {
                "IpAddress": {"aws:SourceIp": ["${var.access_list}"]}
            }
        }
    ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
    Name        = "${var.env}-suggest"
    Environment = "${var.env}"
  }
}
