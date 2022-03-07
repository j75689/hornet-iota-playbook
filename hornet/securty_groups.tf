resource "aws_security_group" "hornet" {
  name        = "hornet_security_group"
  description = "Allow hornet traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.ssh_inbound_block}"
  }

  // prometheus
  ingress {
    from_port   = 9311
    to_port     = 9311
    protocol    = "tcp"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  // profiling
  ingress {
    from_port   = 6060
    to_port     = 6060
    protocol    = "tcp"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  // mqtt,ws
  ingress {
    from_port   = 1888
    to_port     = 1888
    protocol    = "tcp"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  // rest api
  ingress {
    from_port   = 14265
    to_port     = 14265
    protocol    = "tcp"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  // p2p
  ingress {
    from_port   = 15600
    to_port     = 15600
    protocol    = "tcp"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  // auto peering
  ingress {
    from_port   = 14626
    to_port     = 14626
    protocol    = "tcp"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hornet_security_group"
  }
}