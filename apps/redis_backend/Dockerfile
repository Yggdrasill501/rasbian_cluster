# Use the official Go image to create a binary
FROM golang:1.20 as builder

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o redis_backend main.go

# Use a minimal image to run the binary
FROM arm64v8/alpine:3.16
COPY --from=builder /app/redis_backend /redis_backend

EXPOSE 8081

CMD ["/redis_backend"]
