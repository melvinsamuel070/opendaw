terraform {
required_version = ">= 1.6"

required_providers {
aws = {
source  = "hashicorp/aws"
version = "~> 6.0"
}
}

backend "s3" {
bucket  = "my-unique-marzban-tf-state-bucket"
key     = "state/terraform.tfstate"
region  = "us-east-1"
encrypt = true
}
}

provider "aws" {
region = var.aws_region

default_tags {
tags = {
ManagedBy   = "Terraform"
Environment = "dev"
Project     = "Marzban"
}
}
}
