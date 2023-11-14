#EC2 instance using UserData

resource "aws_instance" "demo-instance" {
  ami                    = "ami-0bb4c991fa89d4b9b"
  instance_type          = "t2.medium"
  key_name               = "demokp0512"
  vpc_security_group_ids = [aws_security_group.JenkinsSG.id]
  user_data              = "${file("userdata_jenkins.sh")}"
  root_block_device {
    volume_size = "30"
  }
  tags = {
    Name  = "Jenkins01"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "JenkinsSG" {
  name        = "Jenkins-SG"
  description = "Jenkins-SG"

  ingress {
    description      = "Port 80 from Everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Port 8080 from Everywhere"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "Port 22 from Everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "Port 8090 from Everywhere"
    from_port        = 8090
    to_port          = 8090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.demo-instance.public_ip
}