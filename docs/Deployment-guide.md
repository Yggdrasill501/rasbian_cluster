# Deployment Guide

This guide details how to deploy the Go applications (`redis_backend` and `counter_backend`) to your Kubernetes cluster using Terraform.

## Prerequisites

- Docker installed on your local machine or Raspberry Pi.
- Docker Hub account for storing your images.
- Terraform installed.

## Steps

### 1. Build Docker Images

1. Navigate to the `redis_backend` directory and build the Docker image:
   ```bash
   docker build -t your-dockerhub-username/redis-backend:latest .
   docker push your-dockerhub-username/redis-backend:latest
