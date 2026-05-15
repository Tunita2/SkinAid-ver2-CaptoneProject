data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Tiết kiệm chi phí: Dùng t3.micro cho Backend
resource "aws_instance" "backend_az1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = aws_subnet.private_app_az1.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = { Name = "Backend-EC2-AZ1" }
}

resource "aws_instance" "backend_az2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = aws_subnet.private_app_az2.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = { Name = "Backend-EC2-AZ2" }
}

resource "aws_lb_target_group_attachment" "backend_az1" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = aws_instance.backend_az1.id
  port             = 8000
}

resource "aws_lb_target_group_attachment" "backend_az2" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = aws_instance.backend_az2.id
  port             = 8000
}

# Tiết kiệm chi phí: Dùng t3.small cho AI Service
resource "aws_instance" "ai_service_az1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.small"
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = aws_subnet.private_app_az1.id
  vpc_security_group_ids = [aws_security_group.ai_sg.id]

  tags = { Name = "AI-Service-EC2-AZ1" }
}

resource "aws_instance" "ai_service_az2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.small"
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  subnet_id              = aws_subnet.private_app_az2.id
  vpc_security_group_ids = [aws_security_group.ai_sg.id]

  tags = { Name = "AI-Service-EC2-AZ2" }
}
