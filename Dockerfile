# Etapa 1: Build com Maven 3.9.13 e Java 23 (Oracle)
FROM maven:3.9.13-oraclelinux8 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa 2: Runtime com JDK leve
FROM container-registry.oracle.com/java/jdk:23
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]