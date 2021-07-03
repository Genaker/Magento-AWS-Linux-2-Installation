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

echo "Install Redis \n"

bash ./install-redis-compile.sh

echo "Install MYSQL/MARIA DB \n"

bash ./install-mariadb-docker.sh


