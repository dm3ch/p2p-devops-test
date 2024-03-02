FROM golang:alpine AS builder
WORKDIR /app
COPY app/go.mod app/go.sum ./
RUN go mod download
COPY app .
RUN go build -o /app/bin/app

FROM scratch
COPY --from=builder /app/bin/app /app/bin/app
ENTRYPOINT ["/app/bin/app"]