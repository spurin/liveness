# First stage: build the application
FROM golang:alpine AS builder

# Set the Working Directory inside the container
WORKDIR /app

# Copy main.go - Based on https://raw.githubusercontent.com/kubernetes/kubernetes/master/test/images/agnhost/liveness/server.go
COPY main.go .

# Build the Go app without specifying GOOS and GOARCH to make it architecture-agnostic
# This will compile the application for the builder's native architecture
RUN CGO_ENABLED=0 go build -o liveness main.go

# Set execute permissions on the binary
RUN chmod +x liveness

# Second stage: create the runtime image
FROM scratch

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/liveness /liveness

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["/liveness"]
