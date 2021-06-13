#!/bin/bash

mkdir -p /var/www/html/magento/

cd /var/www/html/magento/

git clone https://github.com/magenx/Magento-2.git .

echo "\nRun: "bin/magento  setup:install" to finish installation\n"

mysql -h 127.0.0.1 -u root  -p'root' -e 'create database magento';

IP=$(wget -qO - icanhazip.com)

sudo service nginx restart

echo "php -d memory_limit=5028M /var/www/html/magento/bin/magento setup:install --base-url=http://$IP --base-url-secure=http://$IP --use-secure=0 --use-rewrites=1 --use-secure-admin=1 --backend-frontname=admin --db-host=127.0.0.1 --db-name=magento --db-user=root --db-password=root --use-secure=0 --base-url-secure=0 --use-secure-admin=0 --admin-firstname=Admin --admin-lastname=Adminovich --admin-email=admin@admin.ua --admin-user=admin --backend-frontname=admin --use-rewrites=1 --admin-password=admin123"

echo "chmod -R 777 /var/www/html/magento/"

echo "yes | /var/www/html/magento/bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=127.0.0.1 --page-cache-redis-db=1"

sudo chmod -R 777 /var/www/html/magento/
