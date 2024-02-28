#!/bin/bash
yum update –y
yum install git wget unzip -y

###########   Begin Java Installation ###############
amazon-linux-extras install java-openjdk11 -y
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.21.0.9-1.amzn2.0.1.x86_64
#================ END Java Installations ================#

###########   Begin Docker Installation ###############
groupadd docker

apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update && sudo apt-get install -y docker-ce docker-ce-cli

usermod -aG docker ubuntu

#================ END Docker Installations ================#