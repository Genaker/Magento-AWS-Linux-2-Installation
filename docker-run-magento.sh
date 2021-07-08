#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

docker run --privileged --name magento2-mono -dit  -v /sys/fs/cgroup:/sys/fs/cgroup:ro  -p 80:80 -p 443:443 -p 3306:3306   genaker/magento2-mono:latest3
