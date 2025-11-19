resource "aws_s3_bucket" "snowflake_cur_reports" {
  bucket = "${var.org_name}-cur-reports"

  tags = {
    Name        = "${var.org_name}-cur-reports"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

# IAM user for Snowflake
resource "aws_iam_user" "snowflake_writer" {
  name = "${var.org_name}-snowflake-s3-writer"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}


# Policy: allow this user to read/write objects in the bucket
resource "aws_iam_user_policy" "snowflake_s3_rw" {
  name = "${var.org_name}-snowflake-s3-rw"
  user = aws_iam_user.snowflake_writer.name

  policy = jsonencode({
    # Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.snowflake_cur_reports.arn,
          "${aws_s3_bucket.snowflake_cur_reports.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_access_key" "snowflake_rw_key" {
  user = aws_iam_user.snowflake_writer.name
}

resource "aws_iam_role" "cloudsibyl_read_role" {
  name = "${var.org_name}-cloudsibyl-s3-readonly-role"

  assume_role_policy = jsonencode({
    # Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.cloudsibyl_account_id}:root"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = var.cloudsibyl_external_id
          }
        }
      }
    ]
  })

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_policy" "cloudsibyl_s3_readonly" {
  name = "${var.org_name}-cloudsibyl-s3-readonly-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.snowflake_cur_reports.arn
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.snowflake_cur_reports.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudsibyl_read_attach" {
  role       = aws_iam_role.cloudsibyl_read_role.name
  policy_arn = aws_iam_policy.cloudsibyl_s3_readonly.arn
}
