variable "identifier" {
  type        = string
}

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
