resource "aws_iam_user_group_membership" "S3Support" {
  user = aws_iam_user.user1.name
  groups = [
    aws_iam_group.s3_support.id
  ]
}
resource "aws_iam_user_group_membership" "EC2Support" {
  user = aws_iam_user.user2.name
  groups = [
    aws_iam_group.ec2_support.id
  ]
}
resource "aws_iam_user_group_membership" "EC2Admin" {
  user = aws_iam_user.user3.name
  groups = [
    aws_iam_group.ec2_admin.id
  ]
}
