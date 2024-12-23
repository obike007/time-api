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
