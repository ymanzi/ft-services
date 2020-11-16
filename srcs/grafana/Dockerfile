FROM alpine:latest

ENV GRAFANA_VERSION=6.7.2

#Get apk
RUN apk -U update
RUN apk add wget && apk add --no-cache --upgrade bash
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

#Get grafana
RUN wget https://dl.grafana.com/oss/release/grafana-6.7.2.linux-amd64.tar.gz &&\ 
	tar -zxvf grafana-6.7.2.linux-amd64.tar.gz &&\
	apk add --repository http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat

#Put Grafana in file grafana
RUN	rm -f grafana-"$GRAFANA_VERSION".linux-amd64.tar.gz &&\
	mv grafana-"$GRAFANA_VERSION"/ grafana/ &&\
	mv grafana/bin/* /usr/local/bin/ 

RUN mkdir -p /etc/telegraf

COPY grafana.db ./grafana/data/
COPY run.sh .

EXPOSE 3000

#telegraf
RUN mkdir -p /etc/telegraf
#RUN chmod 755 /etc/telegraf
#RUN /etc/telegraf/
#RUN telegraf config --output-filter influxdb > /etc/telegraf/telegraf.conf

COPY ./telegraf.conf /etc/telegraf/telegraf.conf

CMD sh run.sh
