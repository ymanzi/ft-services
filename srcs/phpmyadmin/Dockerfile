FROM	alpine:latest

COPY	config.inc.php \
		default.conf \
		supervisor.ini \
		/

RUN	apk	add openssl openssh\
		nginx \
		openrc \
		openssl \
		php7 \
		php7-fpm \
		php7-iconv \
		php7-json \
		php7-mbstring \
		php7-mysqli \
		php7-phar \
		php7-session \
		supervisor \
		telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache \
	&&	rc-update add php-fpm7 default &&\
#Install PhpMyAdmin
	wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.zip -O phpmyadmin.zip &&\
    unzip phpmyadmin.zip &&\
    rm -rf phpmyadmin.zip &&\
    mv phpMyAdmin-4.9.5-all-languages phpmyadmin \
&& mkdir /phpmyadmin/tmp \
&&	chmod 777 /phpmyadmin/tmp \
&&	mkdir	/etc/supervisor.d \
			/run/nginx \
			/var/run/php \
&&	mv /config.inc.php /phpmyadmin/ \
&&	mv /default.conf /etc/nginx/conf.d/default.conf \
&&	mv /supervisor.ini /etc/supervisor.d/

#config ssl
RUN adduser -D user &&\
    echo "user:password" | chpasswd &&\
    mkdir /etc/nginx/ssl &&\
    ssh-keygen -A &&\
    openssl req -x509 -nodes -days 7300 -subj "/C=BE/ST=Brussels/O=20/OU=ymanzi/CN=www.localhost" -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

#Telegraf
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 5000 443

ENTRYPOINT	/usr/bin/supervisord
