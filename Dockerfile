FROM ubuntu

# Install dependencies
#======================
RUN apt-get update && apt-get install -y
RUN apt install openjdk-17-jre-headless -y
RUN apt install maven -y

# Set the working directory
WORKDIR /app

# Set the working directory
COPY ./src /app/src
COPY ./pom.xml /app

# Build the application
RUN mvn -f /app/pom.xml clean package -DskipTests

# Copy the generated JAR
RUN cp /app/target/*.jar /app/app.jar

# Expose the application port
EXPOSE 8080

# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "/app/app.jar"]