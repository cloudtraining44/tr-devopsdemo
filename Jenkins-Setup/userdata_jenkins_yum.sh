#!/bin/bash
yum update –y
yum install git wget unzip -y

###########   Begin Java Installation ###############
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
yum -y install ./jdk-17_linux-x64_bin.rpm
rm jdk-17_linux-x64_bin.rpm
#================ END Java Installations ================#

###########   Begin Terraform Installation ###############
wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip -d /usr/local/bin/
#================ END Terraform Installations ================#

###########   Begin Jenkins Installation ###############
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
yum install fontconfig -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins
#================ END Jenkins Installations ================#