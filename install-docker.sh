#!/bin/bash
set -x
set +e
curl -fsSL https://get.docker.com -o get-docker.sh 
sudo sh get-docker.sh || (sudo amazon-linux-extras install docker && sudo yum install docker -y && sudo usermod -a -G docker ec2-user) || sudo yum install docker -y
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock

# Issue is ip table is not installed
yum install iptables-services -y

sudo service docker start
sudo systemctl enable docker.service

sudo curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Test Docker Compose
docker-compose --version

sudo chmod 666 /var/run/docker.sock

set +x
set -e
