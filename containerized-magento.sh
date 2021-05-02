#!/bin/bash

echo "Install Necessary software:\n"

bash ./install-prepare.sh

echo "Install Docker + Dockr-Compose:\n"

bash ./install-docker.sh

bash ./install-doctl.sh

doctl auth init -t '2a97e2e18798cf2a484aa135d60989907961c0f5a7813fd51d2c1e9ecd04c3ef'

doctl registry login

echo "Docker Compose Run:\n"

docker-compose -f docker-compose.yml up -d 

## get SQL dump wget https://sfsdfsdfsdfsdf-test1.s3.us-east-2.amazonaws.com/magento2_20200402.sql.gz

#Gunzipmagento2_20200402.sql

## gunzip ecklersm2_20200402.sql.gz

## mysql -h 127.0.0.1 -u magento -pmagento magento < magento2_20200402.sql

## mysql -h 127.0.0.1 -u root -pmyrootpassword magento < magento2_20200402.sql

## git clone magento 

## composer install 

## docker exec  magento bash -c 'php -d memory_limit=5028M /var/www/html/magento/bin/magento setup:install --base-url=\\\$MAGENTO_URL --backend-frontname=admin --language=\\\$MAGENTO_LANGUAGE --timezone=\\\$MAGENTO_TIMEZONE --currency=\\\$MAGENTO_DEFAULT_CURRENCY --db-host=\\\$MYSQL_HOST --db-name=\\\$MYSQL_DATABASE --db-user=\\\$MYSQL_USER --db-password=\\\$MYSQL_PASSWORD --use-secure=\\\$MAGENTO_USE_SECURE --base-url-secure=\\\$MAGENTO_BASE_URL_SECURE --use-secure-admin=\\\$MAGENTO_USE_SECURE_ADMIN --admin-firstname=\\\$MAGENTO_ADMIN_FIRSTNAME --admin-lastname=\\\$MAGENTO_ADMIN_LASTNAME --admin-email=\\\$MAGENTO_ADMIN_EMAIL --admin-user=\\\$MAGENTO_ADMIN_USERNAME --admin-password=\\\$MAGENTO_ADMIN_PASSWORD'

