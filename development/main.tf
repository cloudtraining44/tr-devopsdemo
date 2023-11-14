#EC2 instance using UserData

resource "aws_instance" "tomcat-instance" {
  ami                    = "ami-0889a44b331db0194"
  instance_type          = "t2.micro"
  key_name               = "demokp0512"
  vpc_security_group_ids = [aws_security_group.tomcat-sg-01.id]
  user_data              = "${file("userdata_tomcat.sh")}"
  tags = {
    Name  = "Tomcat"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "tomcat-sg-01" {
  name        = "tomcat-SG-01"
  description = "tomcat-SG-01"

  ingress {
    description      = "Port 80 from Everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  #  ipv6_cidr_blocks = ["::/0"]
  }

    ingress {
    description      = "ssh from Everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  #  ipv6_cidr_blocks = ["::/0"]
  }

    ingress {
    description      = "Port 443 from Everywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  #  ipv6_cidr_blocks = ["::/0"]
  }

    ingress {
    description      = "Port 8090 from Everywhere"
    from_port        = 8090
    to_port          = 8090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  #  ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  # ipv6_cidr_blocks = ["::/0"]
  }
}

output "public_ip" {
  value = aws_instance.tomcat-instance.public_ip
}