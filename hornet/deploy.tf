resource "null_resource" "nodes" {
  count = "${length(aws_instance.hornet)}"
  triggers = {
    zookeeper_id = "${element(aws_instance.hornet.*.id, count.index)}"
  }
  connection {
    host = "${element(aws_instance.hornet.*.public_ip, count.index)}"
    user = "${var.ssh_username}"
    private_key = "${file(var.ssh_key_file)}"
  }
  provisioner "file" {
    content = "${data.template_file.setup-docker.rendered}"
    destination = "/tmp/setup-docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
        // mount ebs
        "sudo mkfs -t xfs /dev/xvdf",
        "sudo mkdir -p /server",
        "sudo mount /dev/xvdf /server",
        // install docker, docker-compose
        "chmod +x /tmp/setup-docker.sh",
        "sudo /tmp/setup-docker.sh"
    ]
  }
}