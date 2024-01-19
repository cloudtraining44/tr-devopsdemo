#!/bin/bash

yum update –y
yum install wget git -y

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

###########   Begin Maven Build for Sample Hello-World java app ###############

mvn archetype:generate -DgroupId=com.app.example -DartifactId=java-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

cd java-app

cat <<EOF > pom.xml
<?xml version = "1.0" encoding = "UTF-8"?>
<project xmlns = "http://maven.apache.org/POM/4.0.0" 
   xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"

xsi:schemaLocation = "http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
<modelVersion>4.0.0</modelVersion>

   <groupId>com.tutorialspoint</groupId>
   <artifactId>hello-world</artifactId>
   <version>1</version>
   <packaging>war</packaging>
   
   <parent>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-parent</artifactId>
      <version>2.3.0.RELEASE</version>
      <relativePath/> 
   </parent>

   <properties>
      <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
      <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
      <java.version>1.8</java.version>
      <tomcat.version>9.0.37</tomcat.version>
   </properties>

   <dependencies>
      <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-web</artifactId>
      </dependency>
      <dependency>  
         <groupId>org.springframework.boot</groupId>  
	 <artifactId>spring-boot-starter-tomcat</artifactId>  
	 <scope>provided</scope>  
      </dependency>   
      <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-test</artifactId>
         <scope>test</scope>
      </dependency>
   </dependencies>

   <build>
      <plugins>
         <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
         </plugin>
      </plugins>
   </build>
   
</project>
EOF


cat <<EOF > src/main/java/com/app/example/App.java
package com.app.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class App extends SpringBootServletInitializer {
   @Override
   protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
      return application.sources(App.class);
   }
   public static void main(String[] args) {
      SpringApplication.run(App.class, args);
   }

   @RequestMapping(value = "/")
   public String hello() {
      return "<center>Hello World Aahhh Mantaapp</center>";
   }
}
EOF

mvn clean package

cp target/hello-world-1.war /etc/tomcat/webapps/

systemctl restart tomcat
#================ END Maven Build for Sample Hello-World java app ================#