variable "master" {
    description = "Count master node"
    type = number
    default = 1
}

variable "worker" {
    description = "Count worker node"
    type = number
    default = 1
}

variable "srv" {
  description = "Count srv server"
  type = number
  default = 1
}

variable "vpc_subnet_id" {
    description = "VPC subnet network id"
    type = string
}

variable "Instance_family_image" {
    description = "Instance image"
    type = string
    default = "fd8v0s6adqu3ui3rsuap"
}