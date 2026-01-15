variable "db_username" { 
    type = string
    default = "admin"
}


variable "db_password" { 
    type = string
    sensitive = true
}

variable "backend_subnet_name" {
    type = string
    default = "web-app-backend-subnet"
}

variable "frontend_subnet_name" {
    type = string
    default = "web-app-frontend-subnet"
}