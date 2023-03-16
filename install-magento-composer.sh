#!/bin/bash

MAGENTO_VERSION="2.4.2"

export COMPOSER_MEMORY_LIMIT=-1

echo "Download Magento using Composer"

sudo mkdir -p /var/www/html/magento

sudo chmod 777 /var/www/html/magento/

cd /var/www/html/magento/

php -d memory_limit=1028M /usr/local/bin/composer create-project --ignore-platform-reqs --repository-url=https://repo.magento.com/ magento/project-community-edition=$MAGENTO_VERSION . 

sudo chmod 777 /var/www/html/magento/
