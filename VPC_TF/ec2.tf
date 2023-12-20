#EC2 instance using UserData

resource "aws_instance" "demo-instance" {
  ami                    = "ami-0759f51a90924c166"
  instance_type          = "t2.micro"
  key_name               = "demokp"
  vpc_security_group_ids = [aws_security_group.web-sg-01.id]
#  user_data              = "${file("userdata_web.sh")}"
  subnet_id              = "subnet-04dfa3acb690ea855"
  tags = {
    Name  = "Web-02"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "web-sg-01" {
  name        = "Web-SG-01"
  description = "Web-SG-01"
  vpc_id      = "vpc-07105041fcd581e03"

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
    description      = "Port 80 from Everywhere"
    from_port        = 443
    to_port          = 443
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
  value = aws_instance.demo-instance.public_ip
}