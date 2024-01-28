### STAGE 1: Build ###

FROM golang:1-bullseye as builder

WORKDIR /app
COPY . /app
RUN go install

### STAGE 2: Setup ###

# https://github.com/gohugoio/hugo/issues/10839#issuecomment-1499463944
FROM alpine
RUN apk add --no-cache \
  libc6-compat \
  && \
  ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2
COPY --from=builder /go/bin/nut_exporter /nut_exporter
RUN chmod +x /nut_exporter
