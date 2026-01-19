variable "identifier" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "private_subnets" {
  description = "List of private subnet IDs for the database subnet group"
  type        = list(string)  
}

variable "vpc_security_group_ids" {
  type        = list(string)
}