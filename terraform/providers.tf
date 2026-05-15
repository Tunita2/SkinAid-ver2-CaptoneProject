terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region              = var.aws_region
  allowed_account_ids = ["994899741781"] # Account mới không bị giới hạn

  default_tags {
    tags = {
      Project   = "SkinAid-v2"
      ManagedBy = "Terraform"
    }
  }
}
