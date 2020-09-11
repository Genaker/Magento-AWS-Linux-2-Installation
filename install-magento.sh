#!/bin/bash

MAGE_DOMAIN=$(curl ipinfo.io/ip)

mysql -e 'Create database magento2;' -h localhost -u root

MAGENTO_VERSION=$(bin/magento --version)
ELASTIC_INSTALL=""

if [[ "$MAGENTO_VERSION" == *"2.4"* ]]; then
  echo "With Elastic Search"
  ELASTIC_INSTALL=" --search-engine=elasticsearch7 \ 
--elasticsearch-host=localhost \
--elasticsearch-port=9200"
fi


/var/www/html/magento/bin/magento  setup:install \
--base-url=http://${MAGE_DOMAIN}/ \
--db-host=localhost \
--db-name=magento2 \
--db-user=root \
--db-password='' \
--admin-firstname=Magento \
--admin-lastname=User \
--admin-email=user@example.com \
--admin-user=admin \
--admin-password=admin123 \
--language=en_US \
--currency=USD \
--timezone=America/Chicago \
--use-rewrites=1 $ELASTIC_INSTALL

/var/www/html/magento/bin/magento setup:config:set --cache-backend=redis --cache-backend-redis-server=127.0.0.1 --cache-backend-redis-db=0

#bin/magento sampledata:deploy
#bin/magento setup:upgrade
#bin/magento setup:di:compile
#bin/magento setup:static-content:deploy
#sudo chmod -R 777 .
