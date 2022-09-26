resource "aws_security_group" "tomcat" {
  name        = "allow_tomcat"
  description = "Allow tomcat inbound traffic"
  vpc_id      = "vpc-0a7e281d11f093663"

  ingress {
    description = "ssh from admins"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    description = "ssh from endusers"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.alb.id]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "t-tomcat-sg"
    terraform = "true"
  }
}


resource "aws_instance" "tomcat" {
  ami                    = "ami-0b89f7b3f054b957e"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0d3968836ef6c9d92"
  key_name               = aws_key_pair.demo.id
  vpc_security_group_ids = [aws_security_group.tomcat.id]
  user_data              = <<-EOF
		#! /bin/bash
       yum update -y
       yum install httpd -y
      systemctl enable htppd
      systemctl start httpd 
      hostnamectl set-hostname tomcat             
	    EOF

  tags = {
    Name = "t-tomcat"
  }
}
