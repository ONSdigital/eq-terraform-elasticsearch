resource "null_resource" "load-data" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/load_data.sh https://${aws_elasticsearch_domain.suggest.endpoint}"
  }
}
