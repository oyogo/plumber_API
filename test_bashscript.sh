#!/bin/bash
LOG_LOCATION=/path/to/plumber_API/logs/
exec > $LOG_LOCATION/test_bashscriptlogs.log 2>&1 

dt=$(date '+%d/%m/%Y %H:%M:%S');

echo "Pushed at: $dt"
