#!/bin/bash

apt install unzip -y
apt install git -y
wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip -d /usr/local/bin/

#Installing java
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb
dpkg -i jdk-17_linux-x64_bin.deb
apt install fontconfig -y

#Add repo key to the system & append the Debian package repository address to the server’s sources.list
wget -O /usr/share/keyrings/jenkins-keyring.asc  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

#Run update so the apt uses the new item in the repo
apt-get update -y
apt-get install jenkins -y

systemctl start jenkins

apt install postgresql-client -y

