resource "null_resource" "nodes" {
  count = "${length(aws_instance.monitor)}"
  connection {
    host = "${element(aws_instance.monitor.*.public_ip, count.index)}"
    user = "${var.ssh_username}"
    private_key = "${file(var.ssh_key_file)}"
  }
  provisioner "file" {
    content = "${data.template_file.setup-docker.rendered}"
    destination = "/tmp/setup-docker.sh"
  }

  provisioner "file" {
    content = "${data.template_file.prometheus.rendered}"
    destination = "/tmp/prometheus.yml"
  }

  provisioner "file" {
    content = "${data.template_file.monitor.rendered}"
    destination = "/tmp/monitor.yaml"
  }

  provisioner "remote-exec" {
    inline = [
        # mount ebs
        "sudo mkfs -t xfs ${var.ebs_mount_point}",
        "sudo mkdir -p /server",
        "sudo mount ${var.ebs_mount_point} /server",
        # install docker, docker-compose
        "sudo bash /tmp/setup-docker.sh",
        # setup mointor
        "sudo mkdir -p /server/prometheus/data",
        "sudo mkdir -p /server/grafana/data",
        "sudo mv /tmp/monitor.yaml /server/monitor.yaml",
        "sudo mv /tmp/prometheus.yml /server/prometheus/prometheus.yml",
        "sleep 5", # wait a bit
        "sudo docker-compose -f /server/monitor.yaml up -d"
    ]
  }
}