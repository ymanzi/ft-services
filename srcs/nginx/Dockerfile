#get linux Alpine
FROM alpine:latest

#init
RUN apk -U upgrade

COPY default.conf \
	 telegraf.conf \
	 supervisor.ini \
	 /

COPY html /html

#install nginx/php/openssl/openssh
RUN apk add vim \
			nginx \
			telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache \
			openssl \
			openssh \
			openrc \
			supervisor

#php
RUN apk add php7 \
			php7-fpm \
			php7-json \
			php7-mysqli

#user
RUN adduser -D -g 'www' www;

#PERMISSION
RUN mkdir /www &&\
	chown -R www:www /var/lib/nginx &&\
	chown -R www:www /www 

#config ssl
RUN adduser -D user &&\
	echo "user:password" | chpasswd &&\
	mkdir /etc/nginx/ssl &&\
	ssh-keygen -A &&\
	openssl req -x509 -nodes -days 7300 -subj "/C=BE/ST=Brussels/O=20/OU=ymanzi/CN=www.localhost" -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

#telegraf
RUN mkdir -p /etc/telegraf &&\
	chmod 600 /etc/telegraf &&\
	mv telegraf.conf /etc/telegraf/telegraf.conf
#RUN telegraf config --output-filter influxdb > /etc/telegraf/telegraf.conf

#config Nginx conf file
RUN mv default.conf /etc/nginx/conf.d/default.conf &&\
	mkdir	/etc/supervisor.d \
			/run/nginx \
			/var/run/sshd \
			/var/run/php &&\
#copy https certificates and nginx page
	mv html /var/www/html &&\
	mv supervisor.ini /etc/supervisor.d/

#expose Port
EXPOSE 22
EXPOSE 80
EXPOSE 443

CMD /usr/bin/supervisord
