terraform {
  backend "s3" {
    bucket         = "hcl-bayer-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hcl-bayer-terraform-lock"
    encrypt        = true
  }
}
