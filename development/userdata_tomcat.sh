#!/bin/bash
yum update -y

#Installing Tomcat Server
cd /opt
sudo wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.93/bin/apache-tomcat-8.5.93.tar.gz
sudo tar -xvzf apache-tomcat-8.5.93.tar.gz
sudo mv apache-tomcat-8.5.93 tomcat
