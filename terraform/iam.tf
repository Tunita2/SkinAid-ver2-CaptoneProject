# Tạo IAM Role cho phép EC2 dùng AWS Systems Manager (SSM)
resource "aws_iam_role" "ec2_ssm_role" {
  name = "skinaid-ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Đính kèm Policy do AWS quản lý cho SSM
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Tạo Instance Profile để gắn vào EC2
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "skinaid-ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}
