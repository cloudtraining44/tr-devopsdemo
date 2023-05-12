#EC2 instance using UserData
resource "aws_instance" "demo-instance" {
  ami                    = "ami-0889a44b331db0194"
  instance_type          = "t2.micro"
  key_name               = "0511demokp"
#  vpc_security_group_ids = [aws_security_group.allow_port80.id]
  user_data              = "${file("userdata.sh")}"
  tags = {
    Name = "from jenkins"
    Owner = "Terraform"
  }
}