# Frontend Dockerfile per Railway.app
FROM nginx:alpine

# Install curl for health checks
RUN apk add --no-cache curl

# Copy static files
COPY . /usr/share/nginx/html

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Create non-root user
RUN addgroup -g 1001 -S nginx-group
RUN adduser -S nginx-user -u 1001 -G nginx-group

# Change ownership
RUN chown -R nginx-user:nginx-group /usr/share/nginx/html
RUN chown -R nginx-user:nginx-group /var/cache/nginx
RUN chown -R nginx-user:nginx-group /var/log/nginx
RUN chown -R nginx-user:nginx-group /etc/nginx/conf.d

# Create PID directory
RUN mkdir -p /var/run/nginx && chown -R nginx-user:nginx-group /var/run/nginx

# Switch to non-root user
USER nginx-user

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:80/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
