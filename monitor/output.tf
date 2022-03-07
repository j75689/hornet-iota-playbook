output "public_ips" {
    value = "${aws_instance.monitor.*.public_ip}"
}

output "private_ips" {
    value = "${aws_instance.monitor.*.private_ip}"
}