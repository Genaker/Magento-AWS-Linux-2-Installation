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

echo "Install Redis Docker\n"

bash ./install-redis-docker.sh

echo "Install MYSQL/MARIA DB Docker \n"

bash ./install-mariadb-docker.sh

echo "Install Elastic Search Docker\n"

bash ./install-elasticsearch-docker.sh

echo "Install Magento Monorepo \n"

bash ./install-monorepo-git.sh
#bash ./install-magento-composer.sh

# echo "Test Software is running"

# bash ./test.sh
