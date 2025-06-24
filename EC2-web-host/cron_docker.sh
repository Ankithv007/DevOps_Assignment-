#!/bin/bash

if ! systemctl is-active --quiet docker; then
  echo "Docker is not running. Starting Docker..."
  sudo systemctl start docker
  cd /home/ubuntu/DevOps_Assignment-  # Adjust path if needed
  docker compose up -d
fi
