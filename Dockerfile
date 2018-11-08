FROM timveil/oo-docker-base:latest

LABEL maintainer="tjveil@gmail.com"

ARG COLLECTOR_PORT=6060
ARG MACHINE_NAME=collector-container
ARG TAKIPI_TMP_DIR=/tmp/takipi

ENV TAKIPI_COLLECTOR_HOME=/opt/takipi

RUN mkdir -pv $TAKIPI_TMP_DIR \
    && curl -fSL https://s3.amazonaws.com/app-takipi-com/deploy/linux/takipi-latest.tar.gz -o /tmp/takipi-collector.tar.gz \
    && tar -xvf /tmp/takipi-collector.tar.gz -C $TAKIPI_TMP_DIR --strip-components=1 \
    && mv -v $TAKIPI_TMP_DIR /opt \
    && rm -rfv /tmp/takipi-collector.tar.gz \
    && rm -rfv $TAKIPI_COLLECTOR_HOME/agent.properties.example \
    && mv $TAKIPI_COLLECTOR_HOME/collector.properties.example $TAKIPI_COLLECTOR_HOME/collector.properties \
    && sed -i "/^#/d" $TAKIPI_COLLECTOR_HOME/collector.properties \
    && sed -i "/^libraryPath/d" $TAKIPI_COLLECTOR_HOME/collector.properties \
    && sed -i "/^takipi.storage.test.url/d" $TAKIPI_COLLECTOR_HOME/collector.properties \
    && sed -i "/^$/d" $TAKIPI_COLLECTOR_HOME/collector.properties \
    && sed -i "s/\(takipi\.listen\.port=\).*\$/\1${COLLECTOR_PORT}/" $TAKIPI_COLLECTOR_HOME/collector.properties \
    && sed -i "s/\(takipi\.server\.name=\).*\$/\1${MACHINE_NAME}/" $TAKIPI_COLLECTOR_HOME/collector.properties \
    && echo "takipi.jvm.lib.file=${JAVA_HOME}/jre/lib/amd64/server/libjvm.so" >> $TAKIPI_COLLECTOR_HOME/collector.properties \
    && echo "libraryPath=${TAKIPI_COLLECTOR_HOME}/lib" >> $TAKIPI_COLLECTOR_HOME/collector.properties

EXPOSE 6060

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]