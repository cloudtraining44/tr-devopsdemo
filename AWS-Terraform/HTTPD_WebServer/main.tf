#EC2 instance using UserData
provider "aws" {
  region = "us-east-1"
}

variable "port" {
  type = list
  default = [22,80,443,5432,8080]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"] # Canonical

}


resource "aws_instance" "httpd-01" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data              = "${file("userdata_01.sh")}"

  root_block_device {
    volume_size = "30"
  }
  tags = {
    Name  = "Web-01"
    Owner = "Terraform"
  }
}

resource "aws_instance" "httpd-02" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data              = "${file("userdata_02.sh")}"

  root_block_device {
    volume_size = "30"
  }
  tags = {
    Name  = "Web-02"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "web-sg" {
  name        = "Web-SG"
  description = "Web-SG"

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

output "public_ip_httpd-01" {
  value = aws_instance.httpd-01.public_ip
}

output "public_ip_httpd-02" {
  value = aws_instance.httpd-02.public_ip
}