#!/bin/bash

sudo bash ./install-docker-service.sh

docker pull redis

docker images

# ToDo: volume my.conf and db files
# Official Documentatio https://hub.docker.com/_/mariadb

sudo docker run --name redis -p 6379:6379 --restart unless-stopped -d redis:alpine3.13 --save '' --databases 10000

# mysql-cli

sleep 5

docker exec -it redis redis-cli -v

docker exec -it redis redis-cli ping

docker ps

