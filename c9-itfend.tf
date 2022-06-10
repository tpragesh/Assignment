# using Interpolation - com.amazonaws.${var.aws_region}.ssm
resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.vpc-knab.id
  service_name      = "com.amazonaws.${var.aws_region}.ec2"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-ec2.id,
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.vpc-knab.id
  service_name      = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-ec2.id,
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm-messages" {
  vpc_id            = aws_vpc.vpc-knab.id
  service_name      = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-ec2.id,
  ]

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id            = aws_vpc.vpc-knab.id
  service_name      = "com.amazonaws.${var.aws_region}.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc-ec2.id,
  ]

  private_dns_enabled = true
}


resource "aws_vpc_endpoint_subnet_association" "sn_ec2" {
  vpc_endpoint_id = aws_vpc_endpoint.ec2.id
  subnet_id       = aws_subnet.vpc-knab-private-subnet-1.id
}

resource "aws_vpc_endpoint_subnet_association" "sn_ssm" {
  vpc_endpoint_id = aws_vpc_endpoint.ssm.id
  subnet_id       = aws_subnet.vpc-knab-private-subnet-1.id
}

resource "aws_vpc_endpoint_subnet_association" "sn_ssmmessages" {
  vpc_endpoint_id = aws_vpc_endpoint.ssm-messages.id
  subnet_id       = aws_subnet.vpc-knab-private-subnet-1.id
}

resource "aws_vpc_endpoint_subnet_association" "cloudwatch_logs" {
  vpc_endpoint_id = aws_vpc_endpoint.cloudwatch_logs.id
  subnet_id       = aws_subnet.vpc-knab-private-subnet-1.id
}
