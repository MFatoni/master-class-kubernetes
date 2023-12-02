# Build image
docker build -t master-class-kubernetes/nodejs-env .

# Push container
docker push master-class-kubernetes/nodejs-env

# Create container
docker container create --name nodejs-env master-class-kubernetes/nodejs-env

# Start container
docker container start nodejs-env

# See container logs
docker container logs -f nodejs-env

# Stop container
docker container stop nodejs-env

# Remove container
docker container rm nodejs-env
