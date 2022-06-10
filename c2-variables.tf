# Input Variables
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "ap-south-1"
}
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.medium"
}
variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}

variable "Pub1-subnet_cidr" {
  description = "Public subnet for the vpc"
  default     = "10.0.1.0/24"
}

variable "Pr1-subnet_cidr" {
  description = "Private subnet for the vpc"
  default     = "10.0.2.0/24"
}

variable "Pub2-subnet_cidr" {
  description = "Public subnet for the vpc"
  default     = "10.0.3.0/24"
}

variable "Pr2-subnet_cidr" {
  description = "Private subnet for the vpc"
  default     = "10.0.4.0/24"
}

variable "desired" {
  description = "Desired capacity for asg"
  default     = 2
}

variable "max" {
  description = "maximum capacity for asg"
  default     = 2
}

variable "min" {
  description = "minimum capacity for asg"
  default     = 1
}

