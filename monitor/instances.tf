data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "monitor" {
  count = "${var.cluster_size}"
  ami = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.monitor.id}"]
  subnet_id = "${var.subnet_id}"
  key_name = "${var.ssh_key_name}"
  tags = {
    key                 = "Name"
    value               = "${var.project}-monitor"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}