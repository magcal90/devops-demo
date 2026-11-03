# First stage: Build with Maven
FROM maven:eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

# Second stage: Create slim runtime image
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
ENV PORT=8080
COPY target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]