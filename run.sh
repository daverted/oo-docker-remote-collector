#!/bin/bash

echo "executing run.sh"

# you can add -l to write collector logs to stdout instead of file
(/opt/takipi/bin/takipi-service -nfd &) && (tail -F /opt/takipi/log/bugtale_service.log)