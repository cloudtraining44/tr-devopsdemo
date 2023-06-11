#EC2 instance using UserData

resource "aws_instance" "demo-instance" {
  ami                    = "ami-0889a44b331db0194"
  instance_type          = "t2.micro"
  key_name               = "demokp0512"
  vpc_security_group_ids = [aws_security_group.allow_port80.id]
  user_data              = "${file("userdata_jenkins.sh")}"
  tags = {
    Name  = "Jenkins-VM"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "allow_port80" {
  name        = "Web-SG"
  description = "Web-SG"

  ingress {
    description      = "Port 80 from Everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  #  ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Port 8080 from Everywhere"
    from_port        = 8080
    to_port          = 8080
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