#!/bin/bash

wget https://raw.githubusercontent.com/Genaker/Magento-AWS-Linux-2-Installation/master/install-docker-service.sh
sudo bash install-docker-service.sh

docker run --privileged --name magento2-mono -dit  -v /sys/fs/cgroup:/sys/fs/cgroup:ro  -p 80:80 -p 443:443 -p 3306:3306   genaker/magento2-mono:latest3
