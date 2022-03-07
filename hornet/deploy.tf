resource "null_resource" "nodes" {
  count = "${length(aws_instance.hornet)}"
  connection {
    host = "${element(aws_instance.hornet.*.public_ip, count.index)}"
    user = "${var.ssh_username}"
    private_key = "${file(var.ssh_key_file)}"
  }
  provisioner "file" {
    content = "${data.template_file.setup-docker.rendered}"
    destination = "/tmp/setup-docker.sh"
  }

  provisioner "file" {
    content = "${data.template_file.docker-compose.rendered}"
    destination = "/tmp/docker-compose.yaml"
  }

  provisioner "file" {
    content = "${data.template_file.config.rendered}"
    destination = "/tmp/config.json"
  }

  provisioner "file" {
    content = "${data.template_file.profiles.rendered}"
    destination = "/tmp/profiles.json"
  }

  provisioner "file" {
    content = "${data.template_file.peering.rendered}"
    destination = "/tmp/peering.json"
  }

  provisioner "remote-exec" {
    inline = [
        # mount ebs
        "sudo mkfs -t xfs ${var.ebs_mount_point}",
        "sudo mkdir -p /server",
        "sudo mount ${var.ebs_mount_point} /server",
        # install docker, docker-compose
        "sudo bash /tmp/setup-docker.sh",
        # setup hornet
        "sudo mkdir -p /server/hornet",
        "sudo mv /tmp/docker-compose.yaml /server/hornet/docker-compose.yaml",
        "sudo mv /tmp/config.json /server/hornet/config.json",
        "sudo mv /tmp/profiles.json /server/hornet/profiles.json",
        "sudo mv /tmp/peering.json /server/hornet/peering.json",
        "sleep 5", # wait a bit
        "sudo docker-compose -f /server/hornet/docker-compose.yaml up -d"
    ]
  }
}