FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
copy src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jre-alpine

RUN addgroup  --system spring &&  adduser --system --ingroup spring spring

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar
RUN chown spring:spring app.jar

USER spring:spring
EXPOSE 9090
ENTRYPOINT [ "java" "-jar" "app.jar" ]