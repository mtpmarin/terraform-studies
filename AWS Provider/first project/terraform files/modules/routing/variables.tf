variable "vpc_id" {
  type = string
}

variable "frontend_subnet_id" {
  type = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the security group"
  type        = list(string)
}

