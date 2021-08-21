provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

locals {
  start = var.portlist # from_ports
  end   = var.portlist # to_ports
}

# Creating Tosca EC2 instance
resource "aws_instance" "tosca" {
  instance_type   = var.instance_type_tosca
  ami             = var.ami_tosca
  subnet_id       = var.subnet
  vpc_security_group_ids = [aws_security_group.winappsg.id]

  root_block_device {
    volume_size = var.volume_tosca
  }

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
  instance_type   = var.instance_type_qtest
  ami             = var.ami_qtest
  subnet_id       = var.subnet
  vpc_security_group_ids = [aws_security_group.winappsg.id]

  root_block_device {
    volume_size = var.volume_qtest
  }

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

# Creating SG
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