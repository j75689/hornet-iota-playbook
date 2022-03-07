resource "aws_security_group" "monitor" {
  name        = "monitor_security_group"
  description = "Allow monitor traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.ssh_inbound_block}"
  }

  // node exporter
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = "${var.cluster_network_cidr}"
  }

  // proxy
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.inbound_network_cidr}"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.inbound_network_cidr}"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "Allow all outbound traffic"
  }

  tags = {
    Name = "monitor_security_group"
  }
}