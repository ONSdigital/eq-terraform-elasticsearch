output "suggest-endpoint" {
  value = "${aws_elasticsearch_domain.suggest.endpoint}"
}

output "service_address" {
  value = "${module.eq-lookup.service_address}"
}
