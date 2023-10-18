#!/bin/bash
set -e

echo "Starting identidock system"

docker run -d --restart=always --name redis redis:7.2
docker run -d --restart=always --name dnmonster amouat/dnmonster:1.0
docker run -d --restart=always --link dnmonster:dnmonster --link redis:redis \
-e ENV=PROD --name identidock tellariel/identidock:0.2
docker run -d --restart=always --name identiproxy --link identidock:identidock -p 80:80 \
-e NGINX_HOST=$(hostname -i) -e NGINX_PROXY=http://identidock:9090 \
tellariel/identiproxy:0.1

echo "Started"
