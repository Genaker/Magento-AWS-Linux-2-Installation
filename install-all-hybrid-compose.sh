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

# Password from the docker compose 
export DB_PASSWORD=lfsdkgj@etwe456otpreDSFdsf34rer

docker ps

curl 127.0.0.1:9200

docker exec -it redis redis-cli -r 1 info server
mysql -h 127.0.0.1 -u root -p'sdsd' -c'version()'

# install magento 

echo "Install Magento"
export MAGENTO_VERSION="2.4.3-p1"
sudo mkdir -p /var/www/html/magento
sudo chmod 777 /var/www/html/magento/
cd /var/www/html/magento/
php -d memory_limit=5028M /usr/local/bin/composer create-project --ignore-platform-reqs --repository-url=https://repo.magento.com/ magento/project-community-edition=$MAGENTO_VERSION . 
sudo chmod 777 /var/www/html/magento/

# -E, --preserve-env
#             Indicates to the security policy that the user wishes to preserve
#             their existing environment variables.  The security policy may
#             return an error if the user does not have permission to preserve
#             the environment.

sudo -E bash ./install-magento.sh

## clear docker

# Stop the container(s) using the following command:
# docker-compose down
# Delete all containers using the following command:
# docker rm -f $(docker ps -a -q)
# Delete all volumes using the following command:
# docker volume rm $(docker volume ls -q)

