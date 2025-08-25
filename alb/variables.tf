# environment variables
variable "project_name" {}
variable "environment" {}

# alb variables
variable "alb_security_group_id" {}
variable "public_subnet_az1a_id" {}
variable "public_subnet_az1b_id" {}
variable "vpc_id" {}
variable "certificate_arn" {}
variable "target_type" {}