provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

locals {
  start      = var.portlist       # from_ports
  end        = var.portlist       # to_ports
  tosca_from = var.tosca_app_port # from_ports
  tosca_to   = var.tosca_app_port # to_ports
  qtest_from = var.qtest_app_port # from_ports
  qtest_to   = var.qtest_app_port # to_ports
}

# Creating Tosca EC2 instance
resource "aws_instance" "tosca" {
  instance_type          = var.instance_type_tosca
  ami                    = var.ami_tosca
  subnet_id              = var.subnet
  vpc_security_group_ids = [aws_security_group.winappsg.id, aws_security_group.tosca_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.profile.id
  key_name               = "vmtest"

  root_block_device {
    volume_size = var.volume_tosca
  }

  depends_on = [aws_s3_bucket.bucket]

  tags = merge(
    var.common_tags,
    {
      "Name" = var.name_tosca
    },

    {
      "vpc_id" = var.vpc_id
    }
  )
}

# Creating Qtest EC2 instance
resource "aws_instance" "qtest" {
  instance_type          = var.instance_type_qtest
  ami                    = var.ami_qtest
  subnet_id              = var.subnet
  vpc_security_group_ids = [aws_security_group.winappsg.id]
  iam_instance_profile   = aws_iam_instance_profile.profile.id
  key_name               = "vmtest"

  root_block_device {
    volume_size = var.volume_qtest
  }

  depends_on = [aws_s3_bucket.bucket]

  tags = merge(
    var.common_tags,
    {
      "Name" = var.name_qtest
    },

    {
      "vpc_id" = var.vpc_id
    }
  )
}

# Creating Common SG
resource "aws_security_group" "winappsg" {
  name        = var.sg_group_name
  description = "Allow VDI and other inbound and everything outbound"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.start
    content {
      from_port   = ingress.value
      to_port     = element(local.end, index(local.start, ingress.value))
      protocol    = "tcp"
      cidr_blocks = var.vdilist
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.whitelist
  }

  tags = {
    Name : var.sg_group_name
    Terraform : "true"
  }
}

# Creating SG for Tosca app
resource "aws_security_group" "tosca_sg" {
  name        = var.sg_group_tosca
  description = "Allow tosca app ports from  VDIs"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.tosca_from
    content {
      from_port   = ingress.value
      to_port     = element(local.tosca_to, index(local.tosca_from, ingress.value))
      protocol    = "tcp"
      cidr_blocks = var.vdilist
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.whitelist
  }

  tags = {
    Name : var.sg_group_tosca
    Terraform : "true"
  }
}

# Creating SG for Qtest app
resource "aws_security_group" "qtest_sg" {
  name        = var.sg_group_qtest
  description = "Allow qtest app ports from  VDIs"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.qtest_from
    content {
      from_port   = ingress.value
      to_port     = element(local.qtest_to, index(local.qtest_from, ingress.value))
      protocol    = "tcp"
      cidr_blocks = var.vdilist
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.whitelist
  }

  tags = {
    Name : var.sg_group_qtest
    Terraform : "true"
  }
}