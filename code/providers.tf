terraform {
  backend "s3" {
    bucket = "kyotocomics3bucket123" #change this
    key    = "terraform.tfstate"
    region = "eu-north-1"
    #dynamodb_table = "my-lock-table" # optional (Only if you created the DynamoDB table in step 4) 
  }
}

