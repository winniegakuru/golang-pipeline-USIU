FROM golang:1.20.5-alpine3.18 AS builder
RUN mkdir /build
ADD go.mod go.sum hello.go /build/
WORKDIR /build
RUN go build hello.go

FROM alpine
RUN adduser -S -D -H -h /app appuser
USER appuser
COPY --from=builder /build/hello /app/
COPY views/ /app/views
WORKDIR /app
CMD ["./hello"]
