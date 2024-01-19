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

###########   Begin Maven Installations ###############
yum install maven -y
#export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.20.0.8-1.amzn2.0.1.x86_64
export JAVA_HOME=/usr/lib/jvm/jdk-17-oracle-x64/bin/java
export PATH=$PATH:$JAVA_HOME/bin/

mkdir -p /usr/local/apache-maven/
cd /usr/local/apache-maven/
wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
gzip -d apache-maven-3.9.5-bin.tar.gz
tar -xvf apache-maven-3.9.5-bin.tar

echo "export M2_HOME=/usr/local/apache-maven/apache-maven-3.9.5" >> ~/.bash_profile 
echo "export M2=$M2_HOME/bin" >> ~/.bash_profile
echo "export MAVEN_OPTS=-Xmx512m" >> ~/.bash_profile
echo "export PATH=$M2:$PATH" >> ~/.bash_profile

source ~/.bash_profile
#================ END Maven Installations ================#

