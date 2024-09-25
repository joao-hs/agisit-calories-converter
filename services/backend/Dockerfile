# Start from the official Golang base image
FROM golang:1.23-alpine AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Install make
RUN apk add --no-cache make

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
ARG MICROSERVICE
RUN make $MICROSERVICE

# Rename the binary file
RUN mv bin/$MICROSERVICE bin/main

# Start a new stage from scratch
FROM alpine:latest

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/bin/main .

# Command to run the executable
CMD ["./main"]