FROM ubuntu

# Install dependencies
RUN apt-get update && apt-get install -y openjdk-17-jre-headless maven

# Set the working directory
WORKDIR /app

# Copy application files
COPY .env /app/src/main/resources/.env
COPY ./src /app/src
COPY ./pom.xml /app/pom.xml

# Build the application
RUN mvn -f /app/pom.xml clean package

# Copy the generated JAR
RUN cp /app/target/*.jar /app/app.jar

# Expose the application ports
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]