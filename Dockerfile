FROM ubuntu

# Install dependencies
#======================
RUN apt-get update && apt-get install -y
RUN apt install openjdk-17-jre-headless -y
RUN apt install maven -y

# Set the working directory
COPY ./src /app/src
COPY ./pom.xml /app

# Build the application
RUN mvn -f /app/pom.xml clean package -DskipTests

# Copy the built JAR file to the container
COPY ./target/*.jar /app/app.jar


EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]