# SSH Traffic Traffic
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Ec-2 security group for SSH"
  vpc_id      = aws_vpc.vpc-knab.id
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outboun"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "knab-ssh"
  }
}

# Web Traffic
resource "aws_security_group" "vpc-ec2" {
  name        = "vpc-ec2"
  description = "Ec-2 security group for traffic from lb"
  vpc_id      = aws_vpc.vpc-knab.id
  ingress {
    description     = "Allow Port 80"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc-lb-web.id]
  }

  ingress {
    description     = "Allow Port 443"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc-lb-web.id]
  }

  ingress {
    description = "All traffic from self"
    from_port   = 0
    to_port     = 65530
    protocol    = "tcp"
    self        = true
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_security_group.vpc-lb-web]
  tags = {
    Name = "knab-ec2"
  }
}

resource "aws_security_group" "vpc-lb-web" {
  name        = "vpc-lb-web"
  description = "load balancer security group"
  vpc_id      = aws_vpc.vpc-knab.id
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "knab-lb-web"
  }
}