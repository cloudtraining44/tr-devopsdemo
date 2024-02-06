#!/bin/bash
yum update –y
yum install git wget unzip -y

###########   Begin Java Installation ###############
amazon-linux-extras install java-openjdk11 -y
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.21.0.9-1.amzn2.0.1.x86_64
#================ END Java Installations ================#

###########   Begin Gradle Installation ###############
wget -O ~/gradle-4.7-bin.zip https://services.gradle.org/distributions/gradle-4.7-bin.zip
yum -y install unzip java-1.8.0-openjdk
mkdir /opt/gradle
unzip -d /opt/gradle/ ~/gradle-4.7-bin.zip

cat <<EOF >> /etc/profile.d/gradle.sh
export PATH=$PATH:/opt/gradle/gradle-4.7/bin
EOF

chmod 755 /etc/profile.d/gradle.sh

