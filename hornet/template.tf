data "template_file" "setup-docker" {
  template = "${file("${path.module}/../scripts/setup-docker.sh")}"
  vars = {
    ssh_username="${var.ssh_username}"
  }
}

data "template_file" "docker-compose" {
  count    = length(var.letsencrypt_domain)
  template = "${file("${path.module}/../scripts/docker-compose.yaml")}"
  vars = {
    hornet_image="${var.iota_hornet_image}"
    enable_proxy="${var.enable_proxy}"
    traefik_image="${var.traefik_image}"
    acme_email="${var.letsencrypt_acme_email}"
    domain="${element(var.letsencrypt_domain, count.index)}"
    enable_logging="${var.enable_logging}"
    awslogs_region="${var.awslogs_region}"
    awslogs_group="${var.awslogs_group}"
    awslogs_create_group="${var.awslogs_create_group}"
  }
}

data "template_file" "config" {
  template = "${file("${path.module}/../scripts/config.json")}"
  vars = {
    dashboard_username="${var.dashboard_username}"
    dashboard_password_hash="${var.dashboard_password_hash}"
    dashboard_password_salt="${var.dashboard_password_salt}"
  }
}

data "template_file" "profiles" {
  template = "${file("${path.module}/../scripts/profiles.json")}"
}

data "template_file" "peering" {
  template = "${file("${path.module}/../scripts/peering.json")}"
}