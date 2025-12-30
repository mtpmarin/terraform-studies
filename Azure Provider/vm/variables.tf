variable "name_of_resource_group" {
    type = string
    default = "funny_name"
    description = "Name of my resource group"
}

variable "default_location" {
    type = string
    default = "Brazil Southeast"
    description = "Is where i live" 
}

variable "nic_name" {
    type = string
    default = "funny_nic_name"
    description = "Name of the network interface"
} 

variable "subnet_name" {
    type = string
    default = "funny_subnet_name"
    description = "Name of the subnet" 
}

variable "ip_name" {
    type = string
    default = "funny_ip_name"
    description = "Name of the public IP"
}

variable "admin_password" {
    type = string
    description = "The admin password for the VM"
    sensitive = true
}