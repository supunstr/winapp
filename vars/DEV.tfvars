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

vpc_id = "vpc-08caf13fd4cbfaf85"
subnet = "subnet-02980681149e6bb84"

sg_group_name = "WIN-VDI_sg"
vdilist       = ["10.125.96.0/22", "10.125.108.0/22", "10.125.112.0/22", "10.125.116.0/22", "10.125.144.0/22", "10.104.96.0/22", "10.104.108.0/22", "10.104.112.0/22", "10.104.144.0/22"]
portlist      = [3389, 80]
whitelist     = ["0.0.0.0/0"]

########## ec2 tosca
name_tosca          = "cws_dev_tosca_01_ec2"
instance_type_tosca = "t2.micro"
ami_tosca           = "ami-029bfac3973c1bda1"
volume_tosca        = "30"

########## ec2 qtest
name_qtest          = "cws_dev_qtest_01_ec2"
instance_type_qtest = "t2.micro"
ami_qtest           = "ami-0b0af3577fe5e3532"
volume_qtest        = "30"

########## s3 Bucket
s3_bucket        = "cws-winabcad"
role_policy      = "dev_win_policy"
role_name        = "dev_win_to_s3_role"
instance_profile = "dev_profile" 


