#!/bin/bash
set -e

echo "Starting ClickHouse..."
/usr/bin/clickhouse-server &

echo "Starting NIM Core..."
/usr/bin/nms-core start &

echo "Starting NIM DPM..."
/usr/bin/nms-dpm start &

echo "Starting NIM Ingestion..."
/usr/bin/nms-ingestion start &

echo "Starting NIM Integrations..."
/usr/bin/nms-integrations start &

echo "Starting NIM SM..."
/usr/bin/nms-sm start &

echo "Starting NGINX..."
exec /usr/sbin/nginx -g "daemon off;"

exec nms
