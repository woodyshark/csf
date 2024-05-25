FROM tomcat:9.0
LABEL maintainer="how2coding@gmail.com"


RUN mkdir /usr/local/tomcat/webapps/ROOT


COPY csf/ /usr/local/tomcat/webapps/ROOT


#COPY lib/mysql-connector-java-5.1.6-bin.jar /usr/local/tomcat/lib/mysql-connector-java-5.1.6-bin.jar


EXPOSE 8086

CMD ["catalina.sh", "run"]


