# ---------- Stage 1: Build ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

#RUN chmod +x mvnw
# Copy source code
COPY . .


# Build project
RUN mvn clean package -DskipTests

# ---------- Stage 2: Run ----------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy JAR từ stage 1
COPY --from=builder /app/target/*.jar app.jar

# Expose cổng 8080
EXPOSE 8081

# Lệnh chạy Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
