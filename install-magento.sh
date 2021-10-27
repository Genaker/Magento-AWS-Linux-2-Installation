#!/bin/bash
set -x

echo "DB Password:$DB_PASSWORD"

MAGE_DOMAIN=$(curl ipinfo.io/ip)
DB_NAME=magento2
DB_USER=root
DB_PASSWORD=${DB_PASSWORD:-asdfDFhdjtDFGeq4rwrc3IOcvxb4xbfsdf}  # If variable not set or null, set it to default.
DB_HOST=127.0.0.1

echo "DB Password:$DB_PASSWORD"

mysql -e 'Create database magento2;' -h ${DB_HOST} -u ${DB_USER} -p${DB_PASSWORD}

cd /var/www/html/magento/
sudo chmod -R 777 /var/www/html/magento/generated/ /var/www/html/magento/var/

MAGENTO_VERSION=$(bin/magento --version)
ELASTIC_INSTALL=""

if [[ "$MAGENTO_VERSION" == *"2.4"* ]]; then
  echo "With Elastic Search"
  ELASTIC_INSTALL=" --search-engine=elasticsearch7 \
--elasticsearch-host=localhost \
--elasticsearch-port=9200"
fi

## sometimes requires error_reporting(E_ALL ^ (E_NOTICE | E_WARNING | E_DEPRECATED)); in the app/bootstrap.php


/var/www/html/magento/bin/magento  setup:install \
--base-url=http://${MAGE_DOMAIN}/ \
--db-host=${DB_HOST} \
--db-name=${DB_NAME} \
--db-user=${DB_USER} \
--db-password=${DB_PASSWORD} \
--admin-firstname=Magento \
--admin-lastname=User \
--admin-email=user@example.com \
--admin-user=admin \
--admin-password=admin123 \
--backend-frontname=cloud_admin \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 $ELASTIC_INSTALL

yes | /var/www/html/magento/bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=127.0.0.1 --cache-backend-redis-db=0
yes | /var/www/html/magento/bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=127.0.0.1 --page-cache-redis-db=1
yes | /var/www/html/magento/bin/magento setup:config:set --session-save=redis --session-save-redis-host=127.0.0.1 --session-save-redis-log-level=4 --session-save-redis-db=2

echo "http://$MAGE_DOMAIN"

sudo service php-fpm restart
sudo nginx -t
setenforce 0
sudo service nginx restart

sudo chmod -R 777 /var/www/html/magento/generated/ /var/www/html/magento/var/

#bin/magento sampledata:deploy
#bin/magento setup:upgrade
#bin/magento setup:di:compile
#bin/magento setup:static-content:deploy
#sudo chmod -R 777 .
