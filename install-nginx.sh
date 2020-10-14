#!/bin/bash

# Official documentation how to install 
# https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-a-prebuilt-centos-rhel-package-from-the-official-nginx-repository
echo "Install Nginx"

sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
nginx -v
