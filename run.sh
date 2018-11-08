#!/bin/bash

# you can add -l to write collector logs to stdout instead of file
(${TAKIPI_COLLECTOR_HOME}/bin/takipi-service -nfd &) && (tail -fq ${TAKIPI_COLLECTOR_HOME}log/bugtale_service.log ${TAKIPI_COLLECTOR_HOME}/log/bugtale_service_poco.log ${TAKIPI_COLLECTOR_HOME}/log/agents/bugtale_agent.* --retry)