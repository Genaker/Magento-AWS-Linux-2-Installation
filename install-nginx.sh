#!/bin/bash

echo "Install Nginx"

sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx
nginx -v
