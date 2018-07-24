output "elb_name" {
  value = "${aws_elb.elb.dns_name}"
}

output "bastion_ip" {
  value = "${aws_eip.ip.public_ip}"
}
