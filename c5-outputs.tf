# Define Output Values

# output "ec2_instance_publicip" {
#   description = "EC2 Instance Public IP"
#   value = aws_instance.my-ec2-vm.public_ip
# }

# output "ec2_publicdns" {
#   description = "Public DNS URL of an EC2 Instance"
#   value = aws_instance.my-ec2-vm.public_dns
# }

output "front-end-url" {
  description = "Public dns using which the server is availability_zone"
  value       = aws_lb.nginx.dns_name
}