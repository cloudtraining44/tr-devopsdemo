#!/bin/bash
yum update –y
amazon-linux-extras install java-openjdk11 -y
yum install maven -y
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.20.0.8-1.amzn2.0.1.x86_64
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

yum install wget -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
#dnf install java-11-amazon-corretto -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins