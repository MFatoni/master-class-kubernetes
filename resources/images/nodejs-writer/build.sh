# Build image
docker build -t master-class-kubernetes/nodejs-writer .

# Push image
docker push master-class-kubernetes/nodejs-writer

# Create container
docker container create --name nodejs-writer master-class-kubernetes/nodejs-writer

# Start container
docker container start nodejs-writer

# See container logs
docker container logs -f nodejs-writer

# Stop container
docker container stop nodejs-writer

# Remove container
docker container rm nodejs-writer
