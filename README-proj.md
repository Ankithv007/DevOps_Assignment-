
# DevOps Assignment: Docker + Nginx + Reverse Proxy

## Project Walkthrough

### 1. Created Dockerfiles (Single-stage and Multi-stage) for Each Service

For both `service_1` (Go) and `service_2` (Python Flask), I created:

- Single-stage Dockerfiles that are simple and straightforward for initial builds.
- A multi-stage Dockerfile for the Go service, where the application is compiled in a builder image and then copied into a smaller runtime image.

This approach helps reduce image size and ensures cleaner, production-ready deployments.

### 2. Tested Services Individually Before Integration

I manually built and ran each service to verify functionality before integrating with Nginx:

```
docker build -t service1 ./service_1
docker run -p 8001:8001 service1

docker build -t service2 ./service_2
docker run -p 8002:8002 service2
```

I confirmed that both services responded correctly at:

- http://localhost:8001/ping
- http://localhost:8002/ping

### 3. Created Nginx Setup for Reverse Proxy

I added an `nginx/` directory containing:

- `nginx.conf` to define routing rules.
- A Dockerfile to build the Nginx container.

In the Nginx configuration, I set up path-based routing:

- Requests to `/service1/` are routed to the Go service.
- Requests to `/service2/` are routed to the Flask service.

### 4. Role of Nginx

Nginx is used as a reverse proxy to provide:

- Centralized access at `localhost:8080`.
- Routing requests to the correct service based on the path prefix.
- The option to add load balancing in the future if needed.

This setup simplifies service access and allows for easier scaling.

### 5. Dockerized Nginx with Logging and Routing

I built a custom `nginx.conf` that handles:

- Path-based routing for both services.
- A custom logging format to capture request details, including:
  - Client IP
  - Timestamp
  - Request path
  - Response status

Example log entry:

```
172.19.0.1 [24/Jun/2025:11:23:14 +0000] "GET /service1/hello HTTP/1.1" 200
```

### 6. Combined All Services Using Docker Compose

I used `docker-compose.yml` to bring up the full stack:

- service1 (Go)
- service2 (Python Flask)
- nginx-proxy (Nginx reverse proxy)

All services are connected via a custom Docker bridge network. The setup includes:

- Health checks for both services.
- Automatic container restart on failure.
- Internal DNS-based service discovery for clean communication between containers.

### 7. Health Checks for Stability

Both services expose a `/ping` endpoint, which is checked by Docker health checks. Nginx starts only after both services report as healthy, ensuring stable routing.

### 8. Bonus: Logging, Health, and Automation

- Nginx access logging is enabled using the custom format.
- Each service has a `/ping` endpoint for health monitoring.
- I wrote a `test.sh` script to automate endpoint testing:

```
#!/bin/bash

echo "Testing service1..."
curl -s http://localhost:8080/service1/ping | grep '"service":"1"'
curl -s http://localhost:8080/service1/hello | grep 'Hello'

echo "Testing service2..."
curl -s http://localhost:8080/service2/ping | grep '"service":"2"'
curl -s http://localhost:8080/service2/hello | grep 'Hello'

echo "All tests passed."
```

## EC2 Deployment with Monitoring (Bonus)

### EC2 Deployment

I deployed the complete Dockerized setup (Go, Python, Nginx) on an AWS EC2 instance. The services are accessible through the EC2 public IP. All configuration and deployment instructions are included in the `EC2-web-host/` folder.

### Integrated Monitoring with Prometheus and Grafana

- Prometheus is configured to scrape metrics from both services (via `/metrics`) and Nginx if the exporter is enabled.
- Grafana dashboards are set up to visualize metrics such as:
  - Request counts
  - Uptime
  - Nginx metrics

Prometheus is configured via `prometheus.yml` in the `EC2-web-host/` directory.

## Folder: EC2-web-host

This folder contains:

- `docker-compose.yml` (with services, Nginx, Prometheus, Grafana)
- `prometheus.yml` scrape configuration
- Dashboard setup instructions
- Public IP information for testing (example: http://3.111.41.165:8080/service1/hello)
