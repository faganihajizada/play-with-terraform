// get instance ID

output "ec2_instance_id" {
  value = "${aws_instance.apache.id}"
}

// get public IP of ec2 instance

output "ec2_global_ips" {
  value = "${aws_instance.apache.*.public_ip}"
}


