resource "aws_iam_group_policy_attachment" "s3_support" {
  group      = aws_iam_group.s3_support.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "ec2_support" {
  group      = aws_iam_group.ec2_support.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

resource "aws_iam_group_policy_attachment" "ec2_admin" {
  group      = aws_iam_group.ec2_admin.name
  policy_arn = aws_iam_policy.start-stop-reboot-ec2.arn
}
