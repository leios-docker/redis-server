#!/bin/sh
if [ ! -f /etc/redis/redis.conf ]
then
    mkdir -p /etc/redis
    cp -R /etc/redis.default/* /etc/redis/
fi

/usr/bin/redis-server /etc/redis/redis.conf
