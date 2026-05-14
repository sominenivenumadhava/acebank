# ─────────────────────────────────────────────────────────────
# Stage 1 — BUILD: Compile and package the WAR using Maven
# ─────────────────────────────────────────────────────────────
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy only dependency manifests first for layer caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy full source and build
COPY src ./src
RUN mvn clean package -DskipTests -B


# ─────────────────────────────────────────────────────────────
# Stage 2 — RUN: Deploy WAR on Apache Tomcat 9
# ─────────────────────────────────────────────────────────────
FROM tomcat:9.0-jdk21-temurin

# Remove Tomcat's default sample webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR as ROOT.war so the app runs at /
COPY --from=builder /app/target/LaceBank.war /usr/local/tomcat/webapps/ROOT.war

# App runs on 8080 by default in Tomcat
EXPOSE 8080

CMD ["catalina.sh", "run"]
