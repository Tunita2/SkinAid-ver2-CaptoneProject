resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "skinaid-db-subnet-group"
  subnet_ids = [aws_subnet.private_db_az1.id, aws_subnet.private_db_az2.id]

  tags = { Name = "skinaid-db-subnet-group" }
}

resource "aws_db_instance" "postgres" {
  identifier             = "skinaid-postgres-primary"
  engine                 = "postgres"
  engine_version         = "15.18"
  instance_class         = "db.t3.micro" # Tiết kiệm chi phí: Dùng t3.micro (Free Tier Eligible)
  allocated_storage      = 20
  max_allocated_storage  = 100
  storage_type           = "gp3"
  
  db_name                = "skinaid_db"
  username               = "dbadmin"
  password               = var.db_password
  
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
  multi_az               = false # Tiết kiệm chi phí: Tắt Multi-AZ (Chỉ chạy 1 instance, không có Standby)
  
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = { Name = "PostgreSQL-SingleAZ" }
}
