# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = "aws-cloudtrail-logs-solvo-demo"
}

data "aws_iam_policy_document" "cloudtrail_bucket_policy_doc" {
  statement {
    sid = "AWSCloudTrail"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.cloudtrail_bucket.arn,
      "${aws_s3_bucket.cloudtrail_bucket.arn}/*",
    ]
  }
  statement {
    sid = "Allow-main-account-read"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
//
    actions = [
      "s3:Get*" 
    ]

    resources = [
      aws_s3_bucket.cloudtrail_bucket.arn,
      "${aws_s3_bucket.cloudtrail_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "cloudtrail_bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id
  policy = data.aws_iam_policy_document.cloudtrail_bucket_policy_doc.json
}
