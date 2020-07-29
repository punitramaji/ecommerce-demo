FROM openjdk:8-jdk-alpine
#maintainer
MAINTAINER punitramaji@gmail.com
COPY target/ecommerce-0.1.0.jar /ecommerce-0.1.0.jar
#expose port 8080
EXPOSE 8080

#default command
CMD java -jar /ecommerce-0.1.0.jar
