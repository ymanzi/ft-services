#get linux Alpine
FROM alpine:latest

#init
RUN apk -U upgrade

#install nginx/php
RUN apk add vim mysql mysql-client
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

#Expose PORT
EXPOSE 3306

COPY my.cnf /etc/
COPY start.sh .

#COPY wordpress .
COPY init.sql .

#telegraf
RUN mkdir -p /etc/telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf

CMD /bin/sh /start.sh
