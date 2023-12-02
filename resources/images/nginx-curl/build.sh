# Build image
docker build -t master-class-kubernetes/nginx-curl .

# Push image
docker push master-class-kubernetes/nginx-curl

# Create container
docker container create --name nginx-curl master-class-kubernetes/nginx-curl

# Start container
docker container start nginx-curl

# See container logs
docker container logs -f nginx-curl

# Stop container
docker container stop nginx-curl

# Remove container
docker container rm nginx-curl
