FROM	alpine:latest

COPY	wp-config.php \
		default.conf \
		supervisor.ini \
		/

RUN	apk	add \
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
#Install Wordpress
	wget https://wordpress.org/latest.zip -O wordpress.zip &&\
    unzip wordpress.zip &&\
    rm -rf wordpress.zip\
&&	mkdir	/etc/supervisor.d \
			/run/nginx \
			/var/run/php \
&&	mv /default.conf /etc/nginx/conf.d/default.conf \
&&	mv /supervisor.ini /etc/supervisor.d/ \
&&	mv /wp-config.php /wordpress/

#Telegraf
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE	5050

ENTRYPOINT	/usr/bin/supervisord
