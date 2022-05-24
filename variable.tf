
# variables for the project
variable "VPC-cidr" {
  type        = string
  description = "name of vpc cidre"
  default     = "10.0.0.0/16"
}

variable "public-sub1-cidr" {
  type        = string
  description = "name of public-sub1 cidr"
  default     = "10.0.1.0/24"
}

variable "public-sub2-cidr" {
  type        = string
  description = "name of public-sub2 cidr"
  default     = "10.0.2.0/24"
}

variable "public-sub3-cidr" {
  type        = string
  description = "name of public-sub2 cidr"
  default     = "10.0.3.0/24"
}

variable "private-sub1-cidr" {
  type        = string
  description = "name of privat-sub1 cidr"
  default     = "10.0.4.0/24"
}

variable "private-sub2-cidr" {
  type        = string
  description = "name of private-sub2 cidr"
  default     = "10.0.5.0/24"
}

variable "AZ1" {
  type        = string
  description = "name of availability zone 1"
  default     = "eu-west-2a"
}

variable "AZ2" {
  type        = string
  description = "name of availability zone 2"
  default     = "eu-west-2b"
}

variable "Region-name" {
  type        = string
  description = "name of region"
  default     = "eu-west-2"

}

