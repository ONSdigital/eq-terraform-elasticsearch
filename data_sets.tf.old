resource "null_resource" "countries" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/load-countries.sh https://${aws_elasticsearch_domain.suggest.endpoint}"
  }
}

resource "null_resource" "occupations" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/load-occupations.sh https://${aws_elasticsearch_domain.suggest.endpoint}"
  }
}

resource "null_resource" "industries" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/load-industries.sh https://${aws_elasticsearch_domain.suggest.endpoint}"
  }
}
