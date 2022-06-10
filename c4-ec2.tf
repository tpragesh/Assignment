# # Create EC2 Instance - Amazon Linux
# resource "aws_instance" "my-ec2-vm" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.ec2_instance_type
#   subnet_id     = aws_subnet.vpc-knab-private-subnet-1.id
#   iam_instance_profile = aws_iam_instance_profile.dev-resources-iam-profile.name
#   # count        = var.ec2_instance_count
#   #key_name      = "Graphana"
# 	user_data = file("docker-install.sh")  
#   vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-ec2.id]
#   tags = {
#     "Name" = "Docker-nginx"
#   }
#   depends_on= [aws_nat_gateway.vpc-knab-nat]
# }




