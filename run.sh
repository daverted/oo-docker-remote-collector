#!/bin/bash

# you can add -l to write collector logs to stdout instead of file
(/opt/takipi/bin/takipi-service -nfd &) && (tail --retry -f -n +1 /opt/takipi/log/bugtale_service.log)