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

variable "cidr_block"{
  type = number
  description = "number of cidr blocks"
  default = 3 
}

variable "public_subnets_count"{
    type = number
    description = "number of public subnets"
    default = "3"
}

variable "public_subnets" {
    type = number
    description = "number of subnet"
    default = "3"
  }


