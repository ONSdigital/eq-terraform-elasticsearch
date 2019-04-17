module "lookup-vpc" {
  source              = "github.com/ONSdigital/eq-terraform?ref=23.0.0/survey-runner-vpc"
  env                 = "${var.env}-lookup"
  aws_account_id      = "${var.aws_account_id}"
  aws_assume_role_arn = "${var.aws_assume_role_arn}"
  vpc_name            = "eq-lookup"
  vpc_cidr_block      = "${var.vpc_cidr_block}"
  database_cidrs      = "${var.database_cidrs}"
}

module "routing" {
  source              = "github.com/ONSdigital/eq-terraform/survey-runner-routing"
  env                 = "${var.env}-lookup"
  aws_account_id      = "${var.aws_account_id}"
  aws_assume_role_arn = "${var.aws_assume_role_arn}"
  public_cidrs        = "${var.public_cidrs}"
  vpc_id              = "${module.lookup-vpc.vpc_id}"
  internet_gateway_id = "${module.lookup-vpc.internet_gateway_id}"
  database_subnet_ids = "${module.lookup-vpc.database_subnet_ids}"
}

module "eq-alerting" {
  source              = "github.com/ONSdigital/eq-terraform/survey-runner-alerting"
  env                 = "${var.env}-lookup"
  aws_account_id      = "${var.aws_account_id}"
  aws_assume_role_arn = "${var.aws_assume_role_arn}"
  slack_webhook_path  = "${var.slack_webhook_path}"
  slack_channel       = "eq-${var.env}-alerts"
}

module "eq-lookup-ecs" {
  source                  = "github.com/ONSdigital/eq-terraform-ecs?ref=v7.2"
  env                     = "${var.env}-lookup"
  ecs_cluster_name        = "api"
  aws_account_id          = "${var.aws_account_id}"
  aws_assume_role_arn     = "${var.aws_assume_role_arn}"
  certificate_arn         = "${var.certificate_arn}"
  vpc_id                  = "${module.lookup-vpc.vpc_id}"
  public_subnet_ids       = "${module.routing.public_subnet_ids}"
  ecs_application_cidrs   = "${var.application_cidrs}"
  private_route_table_ids = "${module.routing.private_route_table_ids}"
  ecs_cluster_min_size    = 0
  ecs_cluster_max_size    = 0
  ons_access_ips          = "${var.access_ips}"
  gateway_ips             = ["${module.routing.nat_gateway_ips}"]
  create_internal_elb     = false
  create_external_elb     = true
}

module "eq-lookup" {
  source                 = "github.com/ONSdigital/eq-ecs-deploy?ref=v4.0"
  env                    = "${var.env}-lookup"
  aws_account_id         = "${var.aws_account_id}"
  aws_assume_role_arn    = "${var.aws_assume_role_arn}"
  vpc_id                 = "${module.lookup-vpc.vpc_id}"
  dns_zone_name          = "${var.dns_zone_name}"
  ecs_cluster_name       = "${module.eq-lookup-ecs.ecs_cluster_name}"
  aws_alb_arn            = "${module.eq-lookup-ecs.aws_external_alb_arn}"
  aws_alb_listener_arn   = "${module.eq-lookup-ecs.aws_external_alb_listener_arn}"
  service_name           = "lookup"
  listener_rule_priority = 200
  docker_registry        = "${var.docker_registry}"
  container_name         = "eq-lookup-api"
  container_port         = 5000
  healthcheck_path       = "/status"
  container_tag          = "${var.lookup_api_tag}"
  application_min_tasks  = "1"
  slack_alert_sns_arn    = "${module.eq-alerting.slack_alert_sns_arn}"
  ecs_subnet_ids         = "${module.eq-lookup-ecs.ecs_subnet_ids}"
  ecs_alb_security_group = ["${module.eq-lookup-ecs.ecs_alb_security_group}"]
  launch_type            = "FARGATE"

  container_environment_variables = <<EOF
      {
        "name": "LOOKUP_URL",
        "value": "https://${aws_elasticsearch_domain.suggest.endpoint}"
      }
  EOF
}
