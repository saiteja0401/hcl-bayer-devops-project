bucket         = "hcl-bayer-terraform-state"
key            = "dev/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "hcl-bayer-terraform-lock"
encrypt        = true
