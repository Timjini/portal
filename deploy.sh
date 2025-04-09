#!/bin/bash
echo "Pulling latest code..."
git pull origin main

echo "Shutting down existing containers..."
docker-compose down

echo "Building and restarting containers..."
docker-compose up --build -d

echo "Deployment completed!"
