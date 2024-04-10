# Liveness Container Image

The Liveness Container Image provides a lightweight HTTP server designed to simulate liveness probes and responses, modeled after the Kubernetes agnhost image's liveness server.go available as follows - https://raw.githubusercontent.com/kubernetes/kubernetes/master/test/images/agnhost/liveness/server.go

At the time of writing, that code was last updated in 2014 and the image at registry.k8s.io/liveness is only available for amd64.

This project serves as a compatible open source implementation, providing similar functionality for educational, testing, and development purposes with multi-arch availability as standard via Docker Hub.

## Background

In Kubernetes, liveness probes are used to determine the health of a container. If a container fails its liveness probe, it will be restarted, helping to ensure that services self-recover from failures. The Liveness Server mimics this behavior by being alive and responsive for a predetermined amount of time before intentionally becoming unresponsive. The example from https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-liveness-http-request at the time of writing has been updated to use the image created via this repository -

```
apiVersion: v1
kind: Pod
metadata:
  labels:
    test: liveness
  name: liveness-http
spec:
  containers:
  - name: liveness
    image: spurin/liveness
    args:
    - /server
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
        httpHeaders:
        - name: Custom-Header
          value: Awesome
      initialDelaySeconds: 3
      periodSeconds: 3
```

## Multi Architecture Builds

This repository makes use of buildx to create multi-architecture images see build.sh
