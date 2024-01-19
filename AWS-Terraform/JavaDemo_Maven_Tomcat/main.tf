#EC2 instance using UserData

resource "aws_instance" "demo-instance" {
  ami                    = "ami-0759f51a90924c166"
#  ami                   = "ami-0c7217cdde317cfec" //Ubuntu
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.web-sg-01.id]
  user_data              = "${file("userdata_web.sh")}"
  tags = {
    Name  = "${var.Env}-WebServer"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "web-sg-01" {
  name        = "${var.Env}-Web-SG"
  description = "${var.Env}-Web-SG"

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

output "public_ip" {
  value = aws_instance.demo-instance.public_ip
}