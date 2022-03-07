resource "aws_iam_instance_profile" "hornet_profile" {
    name = "hornet_profile"
    role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name = "hornet_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


resource "aws_instance" "hornet" {
  count = "${var.cluster_size}"
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.hornet.id}"]
  subnet_id = "${var.subnet_id}"
  iam_instance_profile = "${aws_iam_instance_profile.hornet_profile.id}"
  key_name = "${var.ssh_key_name}"
  tags = {
    key                 = "Name"
    value               = "${var.project}-hornet-hornet"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}