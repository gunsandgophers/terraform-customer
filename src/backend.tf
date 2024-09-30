terraform {
  backend "s3" {
    bucket = "tech-challenge-fase-3-terraform-customer-state"
    region = "us-east-1"
    key    = "customer/terraform.tfstate"
  }
}
