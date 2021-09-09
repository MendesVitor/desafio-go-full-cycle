FROM golang:1.17 AS builder
WORKDIR /tmp/go-app
COPY . .
RUN apt-get update -y && apt-get install -y upx 
RUN go build -a -gcflags=all="-l -B" -ldflags="-w -s" .
RUN upx --best --ultra-brute example.com

FROM scratch
COPY --from=builder /tmp/go-app/example.com /app/go-app
CMD ["/app/go-app"]