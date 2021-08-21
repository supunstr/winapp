variable "aws_region" {}
variable "aws_profile" {}
#variable "aws_account_id" {}
#variable "aws_account_name" {}
variable "vpc_id" {}

variable "common_tags" {
  type = map(string)
}
variable "name_tosca" {}
variable "instance_type_tosca" {}
variable "ami_tosca" {}
variable "volume_tosca" {}

variable "name_qtest" {}
variable "instance_type_qtest" {}
variable "ami_qtest" {}
variable "volume_qtest" {}

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
