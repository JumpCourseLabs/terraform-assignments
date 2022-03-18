variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "ec2_image_ami" {
  description = "AMI id"
  type = string
  default = "ami-0c02fb55956c7d316"
}

variable "ec2_instance_count" {
  description = "Scalable Number of EC2 Instances"
  type        = string
  default     = 1
}

variable "ec2_availability_zones" {
  description = "AZs for VPC/Subnets"
  type        = string
  default     = "us-east-1a"
}

variable "ec2_instance_type" {
  description = "Instance Type"
  type = string
  default = "t2.micro" 
}

variable "ec2_instance_key" {
  description = "SSH Key"
  type = string
  default = "terraform-key" 
}
