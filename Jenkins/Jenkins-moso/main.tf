#EC2 instance using UserData
provider "aws" {
  region = "us-east-1"
}

variable "port" {
  type = list
  default = [22,80,443,5432,8080]
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"   # Specify the name of your key pair
  public_key = file("~/.ssh/id_rsa.pub")  # Specify the path to your public key file

  tags = {
    Name = "MyKeyPair"
  }
}

resource "aws_instance" "Jenkins" {
  ami                    = "ami-010d7d37120487add"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  key_name               = "my-key-pair"

  root_block_device {
    volume_size = "30"
  }
  tags = {
    Name  = "Web-01"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "jenkins-sg"

  dynamic ingress {
    for_each = var.port

    content {
    description      = "from Everywhere"
    from_port        = ingress.value
    to_port          = ingress.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
 }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "public_ip_Jenkins" {
  value = aws_instance.Jenkins.public_ip
}