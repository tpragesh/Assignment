resource "aws_autoscaling_group" "knab-asg" {
  vpc_zone_identifier = [aws_subnet.vpc-knab-private-subnet-1.id, aws_subnet.vpc-knab-private-subnet-2.id]
  desired_capacity    = var.desired
  max_size            = var.max
  min_size            = var.min
  target_group_arns   = aws_lb_target_group.nginx[*].arn
  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }
  depends_on = [aws_lb_target_group.nginx]
}
resource "aws_launch_template" "web_launch_template" {
  name = "web_launch_template"
  iam_instance_profile {
    name = aws_iam_instance_profile.dev-resources-iam-profile.name
  }
  monitoring {
    enabled = true
  }
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-ec2.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Docker-nginx"
    }
  }
  user_data = filebase64("docker-install.sh")
}