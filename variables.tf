#Importante vars
variable "access_key" {}
variable "secret_key" {}
variable "alarms_email" {}

variable "key_pair_name" {}
variable "key_file_path" {}

# # Define SSH key pair for our instances
# resource "aws_key_pair" "default" {
#   key_name = "${var.key_pair_name}"
#   public_key = "${file(var.key_file_path)}"
# }

#config for region
variable "aws_region" {
  default = "us-east-1"
}

#config for VPC
variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}


#config for Subnets
variable "public_subnet_cidrs" {
  description = "CIDR for the public subnets"
  type = "list"
  default = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  description = "CIDR for the private subnets"
  type = "list"
  default = ["10.0.3.0/24","10.0.4.0/24"]
}


#config security groups
# variable "sg-public" {}
# variable "sg-private" {}
# variable "sg-databass" {}
# variable "sg-alb-internet" {}
# variable "sg-alb-internel" {}

#config for EC2 instances
variable "ami" {
  description = "Amazon Linux AMI for Instances"
  default = "ami-0b69ea66ff7391e80"
}

variable "inst_type" {
  description = "instance type free tier"
  default = "t2.micro"
}