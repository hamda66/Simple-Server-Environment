
variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "UK South"
  
}

variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "simple-server-env-rg"      
  
}

variable "vnetIP" {

    description = "IP of Vnet"
    type = set(string)
  
}

variable "subnet_IP" {
  description = "subnet IP"
  type = set(string)
}

