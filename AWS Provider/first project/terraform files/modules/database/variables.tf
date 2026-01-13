variable "instance_type" {
  type        = string
}

variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive = true
}

variable "backend_subnet_name" {
  type        = string
}

variable "backend_subnet_ids" {
  type = list(string)
}