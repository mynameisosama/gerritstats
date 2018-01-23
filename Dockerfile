# Usage: sudo docker build -t osamatoor/gerritstats .
FROM ubuntu:16.04

# Install hosting dependencies
RUN apt-get update && apt-get install -y nginx cron curl openssh-server

# Install stats dependencies
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y openjdk-8-jdk nodejs build-essential

# Setup CRON job
COPY gerrit_stats.sh /etc/cron.hourly/gerrit_stats.sh
RUN echo "0 * * * * /etc/cron.hourly/gerrit_stats.sh >> /var/log/stats.log 2>&1" > stats_cron_job
RUN crontab stats_cron_job
RUN rm stats_cron_job

# Copy source code to container
COPY stats /stats

# Build Application
WORKDIR /stats
RUN ./gradlew assemble

# Setup SSH configuration
RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no " > /root/.ssh/config

# Setup NGINX and start CRON & NGINX
RUN sed -i "s#root /var/www/html;#root /stats/out-html;#" /etc/nginx/sites-enabled/default
CMD cron; nginx -g 'daemon off;'

# Expose port 80 for NGINX
EXPOSE 80

# Run: docker run -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -e GERRIT_USER=${gerrit_username} --restart=always --name stats -p 80:80 -itd --add-host=${gerrit hostname}:${gerrit ip} osamatoor/gerritstats