#!/bin/bash

yum update –y

yum install wget git -y # Install wget and git.

###########   Begin Java Installation ###############
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
yum -y install ./jdk-17_linux-x64_bin.rpm
rm jdk-17_linux-x64_bin.rpm
#yum install java-1.8.0-openjdk-devel
#alternatives --config java
#================ END Java Installations ================#

###########   Begin Jenkins Installations ###############
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
# Add required dependencies for the jenkins package
yum install fontconfig -y
yum install jenkins -y
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
#systemctl status jenkins
#================ END Jenkins Installations ================#

#Change the jenkins port to 8090 by editing /etc/systemd/system/multi-user.target.wants/jenkins.service

