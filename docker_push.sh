IMAGE_NAME=${IMAGE_NAME}
DOCKER_USERNAME=${DOCKER_USERNAME}
TAG=${TAG}

echo "Building Docker image..."
docker build -t $IMAGE_NAME .

if [ $? -ne 0 ]; then
    echo "Error: Failed to build the Docker image."
    exit 1
fi

echo "Tagging Docker image..."
docker tag $IMAGE_NAME $DOCKER_USERNAME/$IMAGE_NAME:$TAG

if [ $? -ne 0 ]; then
    echo "Error: Failed to tag the Docker image."
    exit 1
fi

echo "Pushing Docker image to Docker Hub..."
docker push $DOCKER_USERNAME/$IMAGE_NAME:$TAG

if [ $? -ne 0 ]; then
    echo "Error: Failed to push the Docker image to Docker Hub."
    exit 1
fi

echo "Docker image successfully pushed to Docker Hub as $DOCKER_USERNAME/$IMAGE_NAME:$TAG"
