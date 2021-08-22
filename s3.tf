resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket
  acl    = "private"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

  tags = {
    Name        = "CWS-DEV-WIN-APP-Backup"
    Environment = "Dev"
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role_policy" "win_policy" {
  name = var.role_policy
  role = aws_iam_role.win_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowS3WinBackup",
        "Effect" : "Allow",
        "Action" : "s3:*",
        "Resource": [
            "arn:aws:s3:::${var.s3_bucket}",
            "arn:aws:s3:::${var.s3_bucket}/*"
            ]
      }
    ]
  })
}

resource "aws_iam_role" "win_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = var.instance_profile
  role = aws_iam_role.win_role.name
}