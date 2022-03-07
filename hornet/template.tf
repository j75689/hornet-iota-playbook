data "template_file" "setup-docker" {
  template = "${file("${path.module}/scripts/setup-docker.sh")}"
}

