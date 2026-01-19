variable "alb_name" {
    type        = string
    }

variable "security_group_ids" {
    description = "A list of security group IDs to associate with the ALB"
    type        = list(string)
    }

variable "subnet_ids" {
    description = "A list of subnet IDs to attach to the ALB"
    type        = list(string)  
  
}

variable "vpc_id" {
    type = string
    }

