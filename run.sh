#!/bin/bash

# you can add -l to write collector logs to stdout instead of file
(/opt/takipi/bin/takipi-service -nfd &) && (tail -fq /opt/takipi/log/bugtale_service.log /opt/takipi/log/bugtale_service_poco.log /opt/takipi/log/agents/bugtale_agent.* --retry)


# && (multitail --retry-all --mergeall /opt/takipi/log/bugtale_service.log /opt/takipi/log/agents/bugtale_agent.*.log /opt/takipi/log/bugtale_service_poco.log)