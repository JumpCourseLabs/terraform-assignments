# Create Start/Stop/Reboot EC2 Instance for EC2-Admin role
# No AWS Managed policy is present

resource "aws_iam_policy" "start-stop-reboot-ec2" {
  name        = "ec2-power-operations"
  description = "Start/Stop/Reboot EC2 Instances"
  policy      = "${file("policy.json")}"
}

