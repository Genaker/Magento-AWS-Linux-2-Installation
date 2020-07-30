#!/bin/bash

sudo mkdir /var/www/html/magento

sudo chmod 777 /var/www/html/magento/

cd /var/www/html/magento/

composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition

sudo chmod 777 /var/www/html/magento/
