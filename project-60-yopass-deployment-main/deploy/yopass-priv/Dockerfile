FROM golang:buster as app
RUN mkdir -p /yopass
WORKDIR /yopass
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o yopass ./cmd/yopass && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o yopass-server ./cmd/yopass-server

FROM node:18 as website
COPY website /website
WORKDIR /website
RUN yarn install --network-timeout 600000 && yarn build

#####

FROM alpine
COPY /extract-env.sh /
COPY --from=website /website/build /public
COPY --from=app /yopass/yopass /yopass/yopass-server /

EXPOSE 1337

ENTRYPOINT ["/bin/sh", "-c", "./extract-env.sh && mv /env.js /public && /yopass-server --memcached=$DB_IP"]
