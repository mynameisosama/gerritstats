# Usage: sudo docker build -t osamatoor/gerritstats .
FROM ubuntu:16.04

# Install hosting dependencies
RUN apt-get update && apt-get install -y curl openssh-server

# Install stats dependencies
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y openjdk-8-jdk nodejs build-essential

# Copy source code to container
COPY stats /stats

# Build Application
WORKDIR /stats
RUN ./gradlew assemble

# Setup SSH configuration
RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no " > /root/.ssh/config

# Copy start-up script
COPY generate_stats.sh /generate_stats.sh

# Set start-up script
ENTRYPOINT ["/generate_stats.sh"]
