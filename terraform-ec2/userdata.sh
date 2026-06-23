#!/bin/bash
# Update package database
sudo apt-get update -y

# Install prerequisites
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker and ensure it runs on boot
sudo systemctl start docker
sudo systemctl enable docker

# Add the default 'ubuntu' user to the docker group so you don't need 'sudo' during SSH deployment
sudo usermod -aG docker ubuntu

# Force reload group membership for the active shell profile
newgrp docker

# 7. Configure host reverse-proxy environment, image housekeeping, and log out
 sudo apt update && sudo apt install -y nginx