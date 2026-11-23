variable "region" {
  description = "AWS Region containing the existing UNLOX project network."
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Prefix used for the resources added by this project."
  type        = string
  default     = "unlox-vpc-project"
}

variable "vpc_id" {
  description = "Existing UNLOX VPC ID."
  type        = string
  default     = "vpc-0382ebb9de9fd682d"
}

variable "public_subnet_id" {
  description = "Existing UNLOX public subnet ID."
  type        = string
  default     = "subnet-0b2bd31cacabaa1fc"
}

variable "private_subnet_id" {
  description = "Existing UNLOX private subnet ID."
  type        = string
  default     = "subnet-07cc5b2525341e0a2"
}

variable "private_route_table_id" {
  description = "Existing UNLOX private route table ID."
  type        = string
}

variable "web_instance_id" {
  description = "Existing running UNLOX web server instance ID."
  type        = string
  default     = "i-0c8f66c26622c32ff"
}

variable "web_security_group_id" {
  description = "Existing web server security group ID; database TCP 3306 is allowed from this group only."
  type        = string
  default     = "sg-0136400a11ab74d69"
}

variable "public_subnet_cidr" {
  description = "CIDR of the existing public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR of the existing private subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "key_name" {
  description = "Existing EC2 key-pair name in ap-southeast-2."
  type        = string
  default     = "UNLOX-EC2-KEY"
}

variable "admin_cidr" {
  description = "Current administrator public IPv4 CIDR for SSH, e.g. 203.0.113.10/32."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_cidr)) && can(regex("/32$", var.admin_cidr))
    error_message = "admin_cidr must be one IPv4 address with a /32 mask."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the bastion and database servers."
  type        = string
  default     = "t3.micro"
}

variable "enable_nat_gateway" {
  description = "Create a NAT Gateway so the private database instance can download packages. This incurs hourly and data-processing charges."
  type        = bool
  default     = true
}
