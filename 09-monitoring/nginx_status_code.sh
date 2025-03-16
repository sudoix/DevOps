#!/bin/bash

# Define variables
PUSHGATEWAY_URL="192.168.178.14:9091"
JOB_NAME="nginx_status_code"
INSTANCE="nginx_server_instance"
LOG_FILE="/var/log/nginx/access.log"

# Extract and count lines with status code 200
count=$(grep ' 200 ' "$LOG_FILE" | wc -l)

# Prepare the metrics data in the Prometheus text-based format
metrics_data="nginx_http_status_200_total $count"

# Push the metrics to Pushgateway
echo "$metrics_data" | curl --data-binary @- "http://$PUSHGATEWAY_URL/metrics/job/$JOB_NAME/instance/$INSTANCE"

echo "Pushed metrics to Pushgateway: $metrics_data"
