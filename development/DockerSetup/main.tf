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

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"   # Specify the name of your key pair
  public_key = file("~/.ssh/id_rsa.pub")  # Specify the path to your public key file

  tags = {
    Name = "MyKeyPair"
  }
}

resource "aws_instance" "demo-instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.UbuntuSG.id]
  user_data              = "${file("userdata_docker.sh")}"
  key_name = "my-key-pair"
  root_block_device {
    volume_size = "30"
  }
  tags = {
    Name  = "${var.Env}-VM"
    Owner = "Terraform"
  }
}

#Security Group Resource to open port 80 
resource "aws_security_group" "UbuntuSG" {
  name        = "Ubuntu-SG"
  description = "Ubuntu-SG"
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
    Name  = "${var.Env}-SG"
    Owner = "Terraform"
  }
}

output "public_ip" {
  value = aws_instance.demo-instance.public_ip
}

output "key_pair_name" {
  value = aws_key_pair.my_key_pair.key_name
}