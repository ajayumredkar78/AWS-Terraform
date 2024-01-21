resource "aws_instance" "webserver" {
  ami                         = "ami-0c0b74d29acd0cd97" # Replace with your desired AMI
  instance_type               = "t2.micro"              # Replace with your desired instance type
  key_name                    = "terrakey"              # Replace with your SSH key pair name
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [aws_security_group.LAB_web_SG.id]
  subnet_id                   = aws_subnet.LAB_public_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "WebServerInstance"
  }

  user_data = <<-EOF
              #!/bin/bash -ex
              yum -y update
              yum -y install httpd php mysql php-mysql
              chkconfig httpd on
              service httpd start
              cd /var/www/html
              wget https://us-west-2-aws-training.s3.amazonaws.com/courses/spl-13/v4.2.27.prod-ca751432/scripts/app.tgz
              tar xvfz app.tgz
              chown apache:root /var/www/html/rds.conf.php
              EOF
}