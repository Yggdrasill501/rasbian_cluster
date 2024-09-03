apiVersion: apps/v1
kind: Deployment
metadata:
  name: counter-backend
  namespace: go-apps
spec:
  replicas: 1
  selector:
    matchLabels:
      app: counter-backend
  template:
    metadata:
      labels:
        app: counter-backend
    spec:
      containers:
      - name: counter-backend
        image: your-dockerhub-username/counter-backend:latest
        ports:
        - containerPort: 8080
        env:
        - name: REDIS_BACKEND_URL
          value: "http://redis-backend.go-apps.svc.cluster.local:8081"  # Service URL for redis-backend
---
apiVersion: v1
kind: Service
metadata:
  name: counter-backend
  namespace: go-apps
spec:
  selector:
    app: counter-backend
  ports:
    - protocol: TCP
      port: 8080
      targetPort: 8080
  type: NodePort
