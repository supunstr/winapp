variable "aws_region" {}
variable "aws_profile" {}
#variable "aws_account_id" {}
#variable "aws_account_name" {}
variable "vpc_id" {}

variable "common_tags" {
  type = map(string)
}

######### Tosca
variable "name_tosca" {}
variable "instance_type_tosca" {}
variable "ami_tosca" {}
variable "volume_tosca" {}
variable "sg_group_tosca" {}
variable "tosca_app_port" {
  type = list(number)
}

######## Qtest
variable "name_qtest" {}
variable "instance_type_qtest" {}
variable "ami_qtest" {}
variable "volume_qtest" {}
variable "sg_group_qtest" {}
variable "qtest_app_port" {
  type = list(number)
}

####### Common variables
variable "subnet" {}
variable "sg_group_name" {}

variable "vdilist" {
  type = list(string)
}
variable "portlist" {
  type = list(number)
}
variable "whitelist" {
  type = list(string)
}

# S3 bucket 
variable "s3_bucket" {}
variable "role_policy" {}
variable "role_name" {}
variable "instance_profile" {}
