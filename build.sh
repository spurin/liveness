# Create a builder and use
docker buildx create --name build_cross --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=10000000 --driver-opt env.BUILDKIT_STEP_LOG_MAX_SPEED=10000000
docker buildx use build_cross

# Using images that match those of registry.k8s.io/pause:3.9 (see https://explore.ggcr.dev/?image=registry.k8s.io%2Fpause%3A3.9) cross-arch build and push
docker buildx build --platform linux/amd64,linux/arm64/v7,linux/arm64,linux/arm64,linux/ppc64le,linux/s390x -t spurin/liveness:latest . --push
