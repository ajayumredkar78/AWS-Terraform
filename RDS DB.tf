# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "enable mysql/aurora access on port 3306"
  vpc_id      = aws_vpc.LAB_VPC.id

  ingress {
    description     = "mysql/aurora access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.LAB_web_SG.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database_SG"
  }
}


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name = "database_subnet_group"
  # subnet_ids  = [aws_default_subnet.subnet_az1.id, aws_default_subnet.subnet_az2.id]
  subnet_ids  = [aws_subnet.LAB_private_subnet-1.id, aws_subnet.LAB_private_subnet-2.id]
  description = "Subnets for Database Instance"

  tags = {
    Name = "database_subnet_group"
  }
}


# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                 = "mysql"
  engine_version         = "8.0.31"
  multi_az               = false
  identifier             = "dev-rds-instance"
  username               = "admin"
  password               = "Pasword123"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  availability_zone      = "us-east-1a"
  db_name                = "applicationdb"
  skip_final_snapshot    = true
}
