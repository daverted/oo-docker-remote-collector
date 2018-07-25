FROM timveil/oo-docker-base

LABEL maintainer="tjveil@gmail.com"

ARG SECRET_KEY=S3875#YAFwDEGg5oSIU+TM#G0G7VATLOqJIKtAMy1MObfFINaQmVT5hGYLQ+cpPuq4=#87a1
ARG COLLECTOR_PORT=6060
ARG MACHINE_NAME=collector-container

RUN curl -sSL http://get.takipi.com/takipi-t4c-installer | bash /dev/stdin -i \
    --sk=$SECRET_KEY \
    --listen_on_port=$COLLECTOR_PORT \
    --machine_name=$MACHINE_NAME \
    && rm -rf /opt/takipi/installation.key

# you can add -l to write collector logs to stdout instead of file
ENTRYPOINT /opt/takipi/bin/takipi-service -nfd