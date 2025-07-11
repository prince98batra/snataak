terraform {
  backend "s3" {
    bucket         = "snaatak-p14-tfstatefile"
    key            = "env/dev/modules/standaloneVM/notification/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "snaatak-p14-tf-statelock"
  }
}