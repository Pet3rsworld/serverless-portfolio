terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "serverless-portfolio-peter-333"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "serverless-portfolio-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "portfolio" { #type and nickname
  bucket = "serverless-portfolio-designed-by-peter-333"
}
resource "aws_s3_bucket_website_configuration" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id #type and nickname    

  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_bucket_public_access_block" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "portfolio" {
  bucket     = aws_s3_bucket.portfolio.id
  depends_on = [aws_s3_bucket_public_access_block.portfolio]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.portfolio.arn}/*"
      }
    ]
  })
}
resource "aws_cloudfront_distribution" "portfolio" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket_website_configuration.portfolio.website_endpoint
    origin_id   = "S3-Website"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-Website"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.portfolio.domain_name}"
}

