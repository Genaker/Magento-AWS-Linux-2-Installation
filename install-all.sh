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

echo "Install Nginx \n"

bash ./install-nginx.sh

echo "Install MYSQL/MARIA DB \n"

bash ./install-maria-db-aws-extras.sh

#echo "Install Elastic Search \n"

#./install-elastic-search.sh

#echo "Install Magento"
