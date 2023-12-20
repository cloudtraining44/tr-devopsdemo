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
#


###########   Begin Tomcat Installation ###############
yum install tomcat -y
cat <<EOF >> /usr/share/tomcat/conf/tomcat-users.xml
<tomcat-users>
<!--
  NOTE:  By default, no user is included in the "manager-gui" role required
  to operate the "/manager/html" web application.  If you wish to use this app,
  you must define such a user - the username and password are arbitrary. It is
  strongly recommended that you do NOT use one of the users in the commented out
  section below since they are intended for use with the examples web
  application.
-->
  Installing : jakarta-taglibs-standard-1.1.2-14.el7_1.noarch                                                                      1/3 
  Installing : tomcat-webapps-7.0.76-16.el7_9.noarch                                                                               2/3 
  Installing : tomcat-admin-webapps-7.0.76-16.el7_9.noarch                                                                         3/3 
  Verifying  : tomcat-webapps-7.0.76-16.el7_9.noarch                                                                               1/3 
  examples web application. They are wrapped in a comment and thus are ignored
  when reading this file. If you wish to configure these users for use with the
  examples web application, do not forget to remove the <!.. ..> that surrounds
  them. You will also need to set the passwords to something appropriate.
-->
<!--
  <role rolename="tomcat"/>
  <role rolename="role1"/>
  <user username="tomcat" password="<must-be-changed>" roles="tomcat"/>
  <user username="both" password="<must-be-changed>" roles="tomcat,role1"/>
  <user username="role1" password="<must-be-changed>" roles="role1"/>
-->

<!-- <role rolename="admin"/> -->
<!-- <role rolename="admin-gui"/> -->
<!-- <role rolename="admin-script"/> -->
<!-- <role rolename="manager"/> -->
<!-- <role rolename="manager-gui"/> -->
<!-- <role rolename="manager-script"/> -->
<!-- <role rolename="manager-jmx"/> -->
<!-- <role rolename="manager-status"/> -->
<!-- <user name="admin" password="adminadmin" roles="admin,manager,admin-gui,admin-script,manager-gui,manager-script,manager-jmx,manager-status" /> -->
<user username="testadmin" password="password" roles="manager-gui,admin-gui"/>
</tomcat-users>
EOF

cat <<EOF >> /usr/share/tomcat/conf/tomcat.conf
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx256m -XX:MaxPermSize=128m -XX:+UseConcMarkSweepGC"
EOF

systemctl daemon-reload 
systemctl start tomcat
#================ END Tomcat Installations ================#