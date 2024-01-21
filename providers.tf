terraform {
  backend "s3" {
    bucket = "kyotocomics3bucket123"
    key    = "terraform.tfstate"
    region = "eu-north-1"
  }
}

