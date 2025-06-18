variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.micro"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "nomad-server"
}