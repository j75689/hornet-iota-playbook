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

resource "aws_instance" "hornet" {
  count = "${var.cluster_size}"
  ami = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.hornet.id}"]
  subnet_id = "${var.subnet_id}"
  key_name = "${var.ssh_key_name}"
  tags = {
    key                 = "Name"
    value               = "${var.project}-hornet"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}