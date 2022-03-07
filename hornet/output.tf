output "public_ips" {
    value = "${aws_instance.hornet.*.public_ip}"
}

output "private_ips" {
    value = "${aws_instance.hornet.*.private_ip}"
}