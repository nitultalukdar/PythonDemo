# Use an official Python runtime as a parent image
FROM python:3.6.8-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY djangoproject /app/djangoproject
COPY posts	 /app/posts
COPY manage.py /app
COPY requirements.txt /app



RUN apt-get update && apt-get -y install ca-certificates
ADD https://get.aquasec.com/microscanner /
RUN chmod +x /microscanner
ARG token
RUN /microscanner ${OWIzMTA5NTYwMmE0}
RUN echo "No vulnerabilities!"
CMD sonar-scanner -Dsonar.projectBaseDir=./src 
# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

RUN set -x \
	&& cd /opt \
	&& curl -o sonarqube.zip -fSL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492.zip \
	&& curl -o sonarqube.zip.asc -fSL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492.zip.asc \
	&& gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
	&& unzip sonarqube.zip \
	&& mv sonarqube-$SONAR_VERSION sonarqube \
	&& rm sonarqube.zip* \
	
# Make port 80 available to the world outside this container
EXPOSE 8000

# Define environment variable

# Run app.py when the container launches
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#CMD ["sleep", "45m"]
