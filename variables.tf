variable "vpc_id" {
  description = "The ID of the VPC in which the endpoint will be used"
  type        = string
}

variable "env" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "project_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "ami" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "ami-005835d578c62050d"
}

variable "instance_type" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "t3.nano"
}

variable "subnet_ids" {
  description = "The ID of the VPC in which the endpoint will be used"
  type        = list(string)
}

variable "ssh_key_bastion" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "sg_ingress" {
  description = "The ID of the VPC in which the endpoint will be used"
  type        = list(string)
  default = null
}

variable "cidr_ingress" {
  description = "The ID of the VPC in which the endpoint will be used"
  type        = list(string)
  default = null
}