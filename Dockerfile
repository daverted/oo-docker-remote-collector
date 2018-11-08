FROM timveil/oo-docker-base:alpine-musl

LABEL maintainer="tjveil@gmail.com"

ARG SECRET_KEY=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1
ARG COLLECTOR_PORT=6060
ARG MACHINE_NAME=collector-container

RUN curl -sSL http://get.takipi.com/takipi-t4c-installer | bash /dev/stdin -i \
    --sk=$SECRET_KEY \
    --listen_on_port=$COLLECTOR_PORT \
    --machine_name=$MACHINE_NAME \
    && rm -rf /opt/takipi/installation.key

EXPOSE 6060

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]