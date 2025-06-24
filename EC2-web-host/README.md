
# 🚀 DevOps Assignment — Hosting with Docker Compose on AWS EC2

This guide explains how to host this application using Docker Compose on an AWS EC2 instance.(with my github folder for the you just need to creaet one instance by yourself and go through the below steps )

---

## 📝 **Steps to deploy**

### 1️⃣ **Launch EC2 instance**
- Login to your AWS console → EC2 → Launch Instance  
- Choose **Ubuntu** (20.04 or 22.04 LTS recommended)  
- Choose instance type (e.g., `t2.micro` for free tier)  
- Create or select an SSH key pair  

---

### 2️⃣ **Configure Security Group**
✅ Add inbound rules:
```
Type: SSH   | Port: 22   | Source: your IP or 0.0.0.0/0
Type: HTTP  | Port: 80   | Source: 0.0.0.0/0
Type: Custom| Port: 8080 | Source: 0.0.0.0/0
```
👉 This allows SSH, HTTP, and custom app traffic.

---

### 3️⃣ **SSH into your instance**
```bash
ssh -i /path/to/your-key.pem ubuntu@<your-ec2-ip>
```

---

### 4️⃣ **Create and run `install.sh`**
Create `install.sh` and paste the provided script (installs Docker, Git, clones repo, builds and runs the app).
```bash
#!/bin/bash

set -e  # Stop if any command fails

echo "➡ Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "➡ Installing Git..."
sudo apt-get install -y git

echo "➡ Installing Docker dependencies..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    lsb-release

echo "➡ Adding Docker GPG key and repository..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository \
   "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"

echo "➡ Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "➡ Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "➡ Adding current user to docker group..."
sudo usermod -aG docker $USER

# Apply group change immediately
echo "➡ Applying Docker group membership..."
newgrp docker <<EONG

echo "➡ Cloning your repository..."
git clone https://github.com/Ankithv007/DevOps_Assignment-.git

echo "✅ All setup done!"
echo "➡ Your project is in: DevOps_Assignment-"
echo "➡ Run: cd DevOps_Assignment- && docker compose up --build"

EONG

```
```bash
chmod +x install.sh
./install.sh
```

---

### 5️⃣ **Verify the application**
✅ Open your browser:
```
http://<your-ec2-ip>:8080/service2/hello
```
or
```
http://<your-ec2-ip>:8080/service1/
```

---

### ⚡ **Docker auto-restart**
Your `docker-compose.yml` should include `restart: always` for each service to ensure auto-restart on crash or reboot.

---

### ⚠ **Optional: Cron job for Docker monitoring**
Not recommended because Docker handles restarts, but you can add a cron job with a `check_docker.sh` script if desired.

---
- http://3.111.41.165:8080/service1/hello
- http://3.111.41.165:8080/service1/ping
- http://3.111.41.165:8080/service2/hello
- http://3.111.41.165:8080/service2/ping

- http://3.111.41.165:9090/    ( Prometheus)
 - up 
 - up{job="service1"}
 - scrape_samples_scraped

- http://3.111.41.165:3000/  (Grafana)

```bash
Component	Requirement	
Service 1  ---> 	Go + REST + Docker + Multi-stage
Service 2  --->	    Flask + REST + Docker	
Nginx	   --->     Reverse Proxy + URL Path Routing	
Docker Compose -->	Single command to run  all services
```
---
# Project - 2: Micro-Services CRUD Application

This is my personal project where I built a CRUD (Create, Read, Update, Delete) application using:
- **Frontend:** React + TypeScript
- **Backend:** Node.js + TypeScript
- **Database:** MySQL

The application follows a micro-services architecture with separate files and services for each component.

---

## 🖥️ Live Demo
You can access the deployed application here:
- [http://3.111.41.165:3030/](http://3.111.41.165:3030/)

---

## 📂 Source Code
The full source code is available on GitHub:
- [https://github.com/Ankithv007/micro-services.git](https://github.com/Ankithv007/micro-services.git)

---

##  Features
- Micro-services architecture
- React frontend served via Nginx
- Node.js backend with REST API
- MySQL database for data persistence
- Dockerized setup for easy deployment

---

##  Running the project

1️⃣ Clone the repository:
```bash
git clone https://github.com/Ankithv007/micro-services.git
cd micro-services
