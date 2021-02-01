#!/bin/bash

set -x

echo "Install PHP \n"

bash ./install-php.sh
bash ./configure-php.sh
bash ./install-tideways-profiler.sh
bash ./install-composer.sh

echo "Install NGINX \n"

bash ./install-nginx.sh

echo "Install Redis \n"

bash ./install-redis-compile.sh

echo "Configure Nginx \n"

bash ./configure-nginx.sh

echo "Install MYSQL/MARIA DB \n"

bash ./install-mariadb-docker.sh

#echo "Install Elastic Search \n"

#./install-elastic-search.sh

## echo "Install Magento \n"

#bash ./install-magento-composer.sh
