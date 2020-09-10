#!/bin/bash

MAGENTO_VERSION="2.3.4"

echo "Download Magento using Composer"

sudo mkdir /var/www/html/magento

sudo chmod 777 /var/www/html/magento/

cd /var/www/html/magento/

php -d memory_limit=1028M /usr/local/bin/composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=$MAGENTO_VERSION .

sudo chmod 777 /var/www/html/magento/
