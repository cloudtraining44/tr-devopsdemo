#!/bin/bash

yum update –y
yum install wget -y

###########   Begin Java Installation for Amazon Linux ###############
yum install java-21-amazon-corretto -y
#================ END Java Installations ================#

###########   Begin tomcat Installations ###############

wget https://downloads.apache.org/tomcat/tomcat-11/v11.0.0-M16/bin/apache-tomcat-11.0.0-M16.tar.gz
mkdir /etc/tomcat
tar -xzvf apache-tomcat-11.0.0-M16.tar.gz
mv apache-tomcat-11.0.0-M16/* /etc/tomcat
chmod +x /etc/tomcat/bin/*.sh

cat <<EOF >> /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat 11 servlet container
After=network.target

[Service]
Type=forking

User=root
Group=root

Environment="JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto.x86_64"

Environment="CATALINA_BASE=/etc/tomcat"
Environment="CATALINA_HOME=/etc/tomcat"
Environment="CATALINA_PID=/etc/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/etc/tomcat/bin/startup.sh
ExecStop=/etc/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start tomcat

###########   Begin Maven Installations ###############
yum install maven -y
#================ END Maven Installations ================#

mvn archetype:generate -DgroupId=com.app.example -DartifactId=java-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false