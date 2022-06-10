
resource "aws_lb_target_group" "nginx" {
  name     = "knab-nginx-tgp"
  port     = 80
  protocol = "HTTP"
  # interval = 5
  # healthy_threshold = 2
  # unhealthy_threshold = 2
  vpc_id = aws_vpc.vpc-knab.id
}
resource "aws_lb" "nginx" {
  name               = "knab-nginx-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc-lb-web.id]
  subnets            = [aws_subnet.vpc-knab-public-subnet-1.id, aws_subnet.vpc-knab-public-subnet-2.id]
}
# resource "aws_lb_target_group_attachment" "nginx" {
#   target_group_arn = aws_lb_target_group.nginx.arn
#   target_id        = aws_instance.my-ec2-vm.id
#   port             = 80
#   depends_on= [aws_lb.nginx]
# }

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  # protocol          = "HTTPS"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}