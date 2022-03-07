resource "aws_ebs_volume" "ebs_volume" {
  count             = "${var.cluster_size}"
  availability_zone = "${element(aws_instance.hornet.*.availability_zone, count.index)}"
  size              = "${var.ec2_ebs_volume_size}"
}

resource "aws_volume_attachment" "ebs_volume_attachement" {
  count       = "${var.cluster_size}"
  volume_id   = "${aws_ebs_volume.ebs_volume.*.id[count.index]}"
  device_name = "${var.ebs_mount_point}"
  instance_id = "${element(aws_instance.hornet.*.id, count.index)}"
}