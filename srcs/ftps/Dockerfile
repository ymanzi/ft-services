#DOC : https://github.com/prapdm/vsftpd-alpine

FROM alpine

ARG USER=user
ARG PASS=password

RUN apk update &&\
	apk upgrade &&\
	apk add openrc --no-cache &&\
	apk add openssl pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

#TELEGRAF
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

#Creation user
RUN mkdir -p /ftps/$USER
RUN adduser -D -g '' --home /ftps/$USER $USER; \
    echo "$USER:$PASS" | chpasswd
RUN chown -R $USER:$USER /ftps/$USER
RUN touch /ftps/$USER/test.txt

#Gen certificat ssl
RUN mkdir -p /etc/ssl/private
RUN openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=BE/ST=Bxl/L=Bruxelles/O=s19/OU=ymanzi/CN=ft_services"
RUN chmod 600 /etc/ssl/private/pure-ftpd.pem
RUN mkdir -p /run/openrc/ && touch /run/openrc/softlevel
RUN touch /run/openrc/softlevel

RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
#RUN telegraf config --output-filter influxdb > /etc/telegraf/telegraf.conf

EXPOSE 21 21100 21101 21102 21103 21104 21105 21106 21107 21108 21109

COPY start.sh .
RUN chmod 755 start.sh

CMD sh start.sh
