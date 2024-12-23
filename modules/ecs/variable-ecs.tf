variable "cluster_name" {
    type = string
    default = "time"  
}

variable "family" {
    type = string
    default = "service"  
}

variable "cpu" {
    type = number
    default = 1024
} 

variable "memory" {
    type = number
    default = 2048  
}

variable "image_url" {
    type = string
    default = assign-time-api
  }
variable "subnets" {
    type = number
    default = 3  
}
variable "security_groups" {
    type = string
    default = "time-SG"  
}

variable "desired_count" {
    type = number
    default = 3
}


