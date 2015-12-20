# Pull base image.
FROM ubuntu:14.04

RUN locale-gen ko_KR.UTF-8
RUN update-locale LANG=ko_KR.UTF-8
RUN dpkg-reconfigure locales

ENV LANG ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

# Install Nginx
RUN \
    sed -ri 's/archive\.ubuntu\.com/kr\.archive\.ubuntu\.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y redis-server psmisc && \
    sed -ri 's/daemonize yes/daemonize no/g' /etc/redis/redis.conf && \
    sed -ri 's/bind 127\.0\.0\.1/bind 0\.0\.0\.0/g' /etc/redis/redis.conf && \
    sed -ri 's/logfile/#logfile/g' /etc/redis/redis.conf && \
    cp -R /etc/redis /etc/redis.default && \
    rm -rf /var/lib/apt/lists/*

COPY files/init.sh /init.sh

# Define default command.
CMD ["/init.sh"]

# Define working directory.
WORKDIR /

# Expose ports.
EXPOSE 6379
