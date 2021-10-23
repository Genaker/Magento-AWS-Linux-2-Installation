#!/bin/bash

set -x

echo "Installing Utilities \n"

bash ./install-prepare.sh

echo "Install PHP \n"

bash ./install-php.sh
bash ./configure-php.sh
# bash ./install-tideways-profiler.sh

set +e
bash ./install-composer.sh
set -e

echo "Install NGINX \n"

bash ./install-nginx.sh

echo "Configure Nginx \n"

set +e
bash ./configure-nginx.sh
set -e

echo "Install Doker Compose ElasticSearch/MariaDB/Redis containers"

docker-compose up -d -f magento-docker-compose-hybrid.yml 

docker ps
