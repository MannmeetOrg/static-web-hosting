# Static Web Hosting

output "website_endpoint" {
  description = "URL of the S3 Static Website"
  value       = aws_s3_bucket.static_website.website_endpoint
}

output "bucket_name" {
  description = "Name of the S3 bucket created"
  value       = aws_s3_bucket.static_website.bucket
}