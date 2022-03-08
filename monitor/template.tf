data "template_file" "setup-docker" {
  template = "${file("${path.module}/../scripts/setup-docker.sh")}"
  vars = {
    ssh_username="${var.ssh_username}"
  }
}

data "template_file" "monitor" {
  template = "${file("${path.module}/../scripts/monitor.yaml")}"
  vars = {
    enable_proxy="${var.enable_proxy}"
    traefik_image="${var.traefik_image}"
    acme_email="${var.letsencrypt_acme_email}"
    domain="${var.letsencrypt_domain}"
  }
}

data "template_file" "prometheus" {
  template = "${file("${path.module}/../scripts/prometheus.yml")}"
  vars = {
    node_exporter="${join(", ", var.node_exporter)}"
    hornet_exporter="${join(", ", var.hornet_exporter)}"
  }
}