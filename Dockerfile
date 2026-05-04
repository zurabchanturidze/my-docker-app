FROM node:18-alpine AS builder
WORKDIR /app
COPY index.html .

RUN echo "Build stage complete" && ls -la

FROM nginx:alpine

LABEL author="YourName" \
      version="1.0.0" \
      description="A production-ready Docker app served by Nginx" \
      org.opencontainers.image.source="https://gitlab.com/yourusername/my-docker-app"


COPY --from=builder /app/index.html /usr/share/nginx/html/index.html


RUN printf 'server {\n\
    listen 8080;\n\
    server_name localhost;\n\
    location / {\n\
        root /usr/share/nginx/html;\n\
        index index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf


RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /usr/share/nginx/html && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown appuser:appgroup /var/run/nginx.pid

USER appuser


EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
