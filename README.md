# My Docker App 🐳

A production-ready Docker image served by Nginx.

## Features
- Multi-stage build
- Non-root user
- Labels (author, version, description)
- Exposed port 8080
- Optimized Alpine-based image

## Run the app
```bash
docker pull yourdockerhubusername/my-docker-app:latest
docker run -p 8080:8080 yourdockerhubusername/my-docker-app:latest