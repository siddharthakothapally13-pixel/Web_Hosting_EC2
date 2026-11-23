variable "region" {
  description = "AWS Region for the project."
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Prefix used for resource names and tags."
  type        = string
  default     = "unlox-vpc-project"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for both project subnets."
  type        = string
  default     = "ap-southeast-2a"
}

variable "key_name" {
  description = "Existing EC2 key-pair name in the selected Region."
  type        = string
}

variable "admin_cidr" {
  description = "Current administrator public IPv4 CIDR for SSH, for example 203.0.113.10/32."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.admin_cidr)) && can(regex("/32$", var.admin_cidr))
    error_message = "admin_cidr must be one IPv4 address with a /32 mask."
  }
}

variable "instance_type" {
  description = "EC2 instance type for the web, bastion, and database servers."
  type        = string
  default     = "t3.micro"
}

variable "enable_nat_gateway" {
  description = "Create a NAT Gateway so private-subnet instances can download OS packages. This incurs hourly and data-processing charges."
  type        = bool
  default     = true
}
