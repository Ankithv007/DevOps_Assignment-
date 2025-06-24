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
