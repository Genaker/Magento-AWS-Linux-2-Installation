#!/bin/bash

set -x

echo "Install PHP \n"

./install-php.sh
./configure-php.sh
./install-tideways-profiler.sh

echo "Install NGINX \n"

./install-nginx.sh

echo "Install Redis \n"

./install-redis-compile.sh

echo "Install Nginx \n"

./install-nginx.sh

echo "Install MYSQL/MARIA DB \n"

./install-maria-db-aws-extras.sh

#echo "Install Elastic Search \n"

#./install-elastic-search.sh

#echo "Install Magento"
