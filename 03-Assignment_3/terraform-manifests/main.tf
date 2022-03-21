terraform {
  required_version = "> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " ~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"

}

module "new_s3_bucket" {
  source      = "./modules/create_s3_bucket"
  bucket_name = var.s3_bucket
  tags        = var.s3_tags
}

data "aws_lambda_invocation" "upload" {
  function_name = "arn:aws:lambda:us-east-1:336898993714:function:upload-to-s3"
  input = jsonencode(
    {
      "bucket_name" : "${var.s3_bucket}"
      "file_name" : "new_log.txt"
      "file_content" : "This is the upload"
  })
  depends_on = [
    module.new_s3_bucket
  ]

}
