variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "cidr_block_ingress" {
  description =  "CIDR block for ingress"
  type = list(string)
} 