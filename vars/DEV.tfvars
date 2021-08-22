aws_profile = "default"
#aws_account_name = "aws-lse-cwscoms-dev"
aws_region = "us-east-1"
#aws_account_id = "sdsd"

common_tags = {
  Application         = "CWS"
  ApplicationName     = "CWS-DEV"
  Environment         = "DEV"
  Regoin              = "us-east-1"
  BusinessCriticality = "-1"
  BusinessDivision    = "CORP"
  BusinessDivision    = "LSE"
  CostCentre          = "CC58419"
  Owner               = "cws-aws-comms-dev@lseg.com"
  ProjectCode         = "40234"
  Terraformed         = "true"
  ApplicationID       = "APP-00063"
  LegalEntity         = "LSE PLC"
  Automation          = "NO_SCHEDULE"
}

vpc_id = "vpc-04d48e1351b450252"
subnet = "subnet-0f240ba8b48f8acd0"

########## Common parameters for EC2s
sg_group_name = "WIN-VDI_sg"
vdilist       = ["10.125.96.0/22", "10.125.108.0/22", "10.125.112.0/22", "10.125.116.0/22", "10.125.144.0/22", "10.104.96.0/22", "10.104.108.0/22", "10.104.112.0/22", "10.104.144.0/22"]
portlist      = [3389, 80]
whitelist     = ["0.0.0.0/0"]

########## ec2 tosca
name_tosca          = "cws_dev_tosca_01_ec2"
instance_type_tosca = "t2.micro"
ami_tosca           = "ami-029bfac3973c1bda1"
volume_tosca        = "30"
sg_group_tosca = "tosca_app_sg"
tosca_app_port = [5001, 500, 600]

########## ec2 qtest
name_qtest          = "cws_dev_qtest_01_ec2"
instance_type_qtest = "t2.micro"
ami_qtest           = "ami-0b0af3577fe5e3532"
volume_qtest        = "30"
sg_group_qtest = "qtest_app_sg"
qtest_app_port = [6001, 800, 700]

########## s3 Bucket
s3_bucket        = "cws-winabc12"
role_policy      = "dev_win_policy"
role_name        = "dev_role"
instance_profile = "dev_profile" 


