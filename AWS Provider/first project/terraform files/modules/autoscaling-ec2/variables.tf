variable "name_prefix" {
  description = "Prefix for the launch template name"
  type        = string
  default     = "web"
}

variable "image_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0fb0b230890ccd1e6"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}


variable "autoscaling_name" {
  description = "Name of the autoscaling group"
  type        = string
}

variable "desired_capacity" {
  type    = number
  default = 1
}

variable "max" {
  type    = number
  default = 3
}

variable "min" {
  type    = number
  default = 1
}

variable "subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  description = "The ARN of the target group to attach to the autoscaling group"
  type        = string
}

variable "security_group_id" {
  type = string
}