### Infrastructure ###

variable "ssh_key_name" {
  default = null
}

variable "ssh_username" {
  default = "ec2-user"
}

variable "ssh_key_file" {
  default = null
}

variable "project" {
  default = "iota-aws"
}

variable "region" {
  default = "ap-northeast-1"
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
  default = null
}

variable "vpc_id" {
  default = null
}

variable "ssh_inbound_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "cluster_network_cidr" {
  type    = list(string)
  default = ["172.31.0.0/16"]
}

### Application ###

variable "iota_hornet_image" {
  default     = "gohornet/hornet:latest"
}

variable "dashboard_username" {
  default     = "admin"
}

variable "dashboard_password_hash" {
  default     = "0000000000000000000000000000000000000000000000000000000000000000"
}

variable "dashboard_password_salt" {
  default     = "0000000000000000000000000000000000000000000000000000000000000000"
}

### Proxy ###

variable "traefik_image" {
  default     = "traefik:latest"
}

variable "letsencrypt_acme_email" {
  default     = ""
}

variable "letsencrypt_domain" {
  default     = ""
}