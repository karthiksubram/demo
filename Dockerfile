#FROM openjdk:17-jdk-alpine
#MAINTAINER welcome.com
#COPY target/demo-0.0.1-SNAPSHOT.jar demo-0.0.1-SNAPSHOT.jar
#ENTRYPOINT ["java","-jar","/demo-0.0.1-SNAPSHOT.jar"]

# Stage 1 (to create a "build" image, ~360MB)
FROM maven:3.8.3-openjdk-17 AS builder
# smoke test to verify if java is available
RUN java -version

COPY . /usr/src/myapp/
WORKDIR /usr/src/myapp/
RUN mvn package

FROM openjdk:17-jdk-alpine
MAINTAINER welcome.com
COPY --from=builder /usr/src/myapp/target/demo-0.0.1-SNAPSHOT.jar demo-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/demo-0.0.1-SNAPSHOT.jar"]