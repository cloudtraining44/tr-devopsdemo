#EC2 instance using UserData
provider "aws" {
  region = "us-east-2"
}

variable "port" {
  type = list
  default = [22,80,443,5432,8080]
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

resource "aws_instance" "demo-instance" {
#  ami                    = data.aws_ami.amazon-linux-2.id
  ami = "ami-0d77c9d87c7e619f9"
  instance_type          = "t2.medium"
  vpc_security_group_ids = ["sg-02f96867771382289"]
  user_data              = "${file("userdata_Centos_Jenkins.sh")}"
  key_name = "demokp"
  root_block_device {
    volume_size = "30"
  }
  tags = {
    Name  = "Jenkins01"
    Owner = "Terraform"
  }
}
/*
#Security Group Resource to open port 80 
resource "aws_security_group" "JenkinsSG" {
  name        = "Jenkins-SG"
  description = "Jenkins-SG"
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
*/
output "public_ip" {
  value = aws_instance.demo-instance.public_ip
}