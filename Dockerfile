# stage 0
FROM golang:latest as builder
WORKDIR /go/src/github.com/PierreZ/goStatic
COPY . .
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -tags netgo -installsuffix netgo

# stage 1
FROM scratch

# set port environment variable with default value
ENV HTTP_SERVER_PORT 8043
ENV PUBLIC_FOLDER_PATH "/srv/http"

# get the binary
WORKDIR /
COPY --from=builder /go/src/github.com/PierreZ/goStatic/goStatic .

ENTRYPOINT ["/goStatic"]
