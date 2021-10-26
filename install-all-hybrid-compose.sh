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

echo "Install Docker and Docker-Compose"
bash ./install-docker.sh

echo "Install Doker Compose ElasticSearch/MariaDB/Redis containers"

docker-compose -f magento-docker-compose-hybrid.yml up -d

docker ps

curl 127.0.0.1:9200

docker exec -it redis redis-cli -r 1 info server
mysql -h 127.0.0.1 -u root -p'sdsd' -c'version()'
