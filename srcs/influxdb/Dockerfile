#doc: https://github.com/container-examples/alpine-influxdb/blob/master/Dockerfile

FROM alpine:latest

# Installing packages
RUN apk update
RUN apk add influxdb --no-cache
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Coping scripts
COPY start.sh .
COPY influxdb.conf /etc/influxdb.conf

#Open port
EXPOSE 8086

#telegraf
RUN mkdir -p /etc/telegraf
#RUN /etc/telegraf/
#RUN telegraf config --output-filter influxdb > /etc/telegraf/telegraf.conf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

ENTRYPOINT [ "./start.sh" ]
