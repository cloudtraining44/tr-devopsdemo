locals {
  name   = "toyota-demo"
  region = "us-east-2"
}

data "aws_ami" "amazon-linux-2" {
 most_recent = true
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

data "aws_subnet" "app-sn" {
  tags = {
    Name = "${local.name}-app-sn"
  }
}

resource "aws_instance" "app-instance" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data              = "${file("userdata_gradle.sh")}"
  subnet_id              = data.aws_subnet.app-sn.id

  tags = {
    Name = "${local.name}-app-Server"
    resource = "toyota-demo"
  }
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "toyota-demo-vpc"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "web-sg" {
 name_prefix       = "${local.name}-app-SG"
 description       = "${local.name}-app-SG"
 vpc_id            = data.aws_vpc.vpc.id
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

  tags = {
    Name = "${local.name}-app-SG"
    resource = "toyota-demo"
  }
}

output "public_ip" {
  value = aws_instance.app-instance.public_ip
}