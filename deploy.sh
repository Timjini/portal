#!/bin/bash
# must run these commands 
# chmod +x /home/ubuntu/portal/deploy.sh
# chmod +r docker-compose.yml
echo "stash any changes.."
git stash

echo "Pulling latest code..."
git pull origin main

echo "Shutting down existing containers..."
sudo docker-compose down

echo "Building and restarting containers..."
sudo docker-compose up --build -d

echo "Connection nginx to docker..."
sudo docker network connect nginx-server_default portal-production-app

echo "Deployment completed!"
