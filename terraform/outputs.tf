output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "cloudfront_domain_name" {
  description = "CloudFront Domain Name cho Frontend"
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "internal_alb_dns_name" {
  description = "DNS của Internal ALB (Backend API)"
  value       = aws_lb.internal.dns_name
}

output "rds_endpoint" {
  description = "Endpoint kết nối Database PostgreSQL"
  value       = aws_db_instance.postgres.endpoint
}

output "static_s3_bucket" {
  description = "Tên Bucket S3 chứa file Frontend"
  value       = aws_s3_bucket.static_frontend.id
}

output "image_store_s3_bucket" {
  description = "Tên Bucket S3 lưu trữ hình ảnh da"
  value       = aws_s3_bucket.image_store.id
}
