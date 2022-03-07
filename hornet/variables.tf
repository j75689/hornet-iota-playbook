variable "ssh_key_name" {
  default = "iota"
}

variable "ssh_username" {
  default = "ec2-user"
}

variable "ssh_key_file" {
  default = "../iota.pem"
}

variable "project" {
  default = "iota-aws"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "iota_hornet_version" {
  description = "The IOTA hornet version"
  default     = "https://github.com/gohornet/hornet/releases/download/v1.1.3/HORNET-1.1.3_Linux_x86_64.tar.gz"
}

variable "instance_type" {
  default = "c5.xlarge"
}

variable "cluster_size" {
  default = "1"
}

variable "ec2_ebs_volume_size" {
  description = "GB"
  default = 10
}

variable "ebs_mount_point" {
  default = "/dev/sdf"
}

variable "subnet_id" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

variable "ssh_inbound_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "cluster_network_cidr" {
  type    = list(string)
  default = ["172.31.0.0/16"]
}