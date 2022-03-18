resource "aws_iam_group" "s3_support" {
  name = "s3_support"
}
resource "aws_iam_group" "ec2_support" {
  name = "ec2_support"
}
resource "aws_iam_group" "ec2_admin" {
  name = "ec2_admin"
}

