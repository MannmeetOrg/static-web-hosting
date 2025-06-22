# IAM Role for Terraform S3 State Bucket Access

resource "aws_iam_role" "terraform_s3_state" {
  name = "terraform-s3-state-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "terraform_s3_state_policy" {
  name        = "TerraformS3StatePolicy"
  description = "Policy to allow access to terraform state bucket and dynamodb table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:GetBucketVersioning",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.terraform_state_bucket}",
          "arn:aws:s3:::${var.terraform_state_bucket}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:UpdateItem"
        ]
        Resource = "arn:aws:dynamodb:${var.aws_region}:*:table/${var.terraform_lock_table}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.terraform_s3_state.name
  policy_arn = aws_iam_policy.terraform_s3_state_policy.arn
}