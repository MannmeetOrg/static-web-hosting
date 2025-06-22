# Outputs
output "website_url" {
  description = "S3 Website URL"
  value       = aws_s3_bucket.static_website.website_endpoint
}