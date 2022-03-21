variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"
}


variable "s3_bucket" {
  description = "name of bucket"
  type        = string
  default     = "terraform-assignment-3-mp-backups"
}


variable "s3_tags" {
  description = "Setting some tags"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
    CreatedBy   = "Mike"
    ExtraTags   = "tags"
  }
}
