FROM openjdk:8-jdk-buster
COPY target/java-web-app-docker*.war /usr/local/tomcat/webapps/java-web-app-docker.war
