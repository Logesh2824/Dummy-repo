FROM ubuntu:22.04

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libstdc++6 libgcc-s1 ca-certificates curl openssl tzdata net-tools && \
    rm -rf /var/lib/apt/lists/*

# Create required system directories
RUN mkdir -p /etc/nms /etc/nginx /var/log/nms /etc/ssl/nginx
# Ensure required nginx directories exist
RUN mkdir -p /var/cache/nginx/client_temp /var/log/nginx && \
    chown -R www-data:www-data /var/cache/nginx /var/log/nginx


# Copy NIM and NGINX configuration
COPY nms/ /etc/nms/
COPY nginx/ /etc/nginx/
COPY ssl-nginx/ /etc/ssl/nginx/

# Copy NIM binaries (adjust paths if needed)
COPY nms-binaries/nms-sm /usr/bin/nms-sm
COPY nms-binaries/nms-core /usr/bin/nms-core
COPY nms-binaries/nms-dpm /usr/bin/nms-dpm
COPY nms-binaries/nms-ingestion /usr/bin/nms-ingestion
COPY nms-binaries/nms-integrations /usr/bin/nms-integrations

# Copy NGINX binary
COPY nms-binaries/nginx /usr/sbin/nginx

# Copy ClickHouse binaries
COPY clickhouse-binaries/clickhouse-server /usr/bin/clickhouse-server
COPY clickhouse-binaries/clickhouse-client /usr/bin/clickhouse-client

# Copy the startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose HTTPS port for NIM dashboard
EXPOSE 443 80

# Start everything
CMD ["/start.sh"]

