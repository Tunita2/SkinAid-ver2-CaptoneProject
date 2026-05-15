variable "aws_region" {
  description = "AWS Region to deploy to"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
  default     = "SuperSecretPassword123!" # Thay đổi trong thực tế
}
