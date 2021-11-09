#!/bin/bash

set -x

mkdir -p /var/www/html/magento/

cd /var/www/html/magento/

git clone --depth 1 https://github.com/magento/magento2.git .

composer install

echo "\nRun: "bin/magento  setup:install" to finish installation\n"

if [ -f /.dockerenv ]; then
    echo "I'm inside Docker";
    mysqld --user=mysql &>/dev/null &
    adduser test
    usermod -a -G elasticsearch test
    chmod -R 777 /var/log/ /var/lib/elasticsearch/
    su - test -c"/usr/share/elasticsearch/bin/elasticsearch -d"
    sleep 3
    mysql -e"set password for 'root'@'localhost' = password('fsdhsgjh44234sfsdfSDFsdg23423')"
    mysql -e"flush privileges"
else
    echo "It is Not Docker";
fi

IP_REAL=$(wget -qO - icanhazip.com)
IP=${IP:=$IP_REAL}
MYSQL_DB_PASS=${MYSQL_DB_PASS:=fsdhsgjh44234sfsdfSDFsdg23423}

echo $IP
echo $MYSQL_DB_PASS

mysql -h 127.0.0.1 -u root  -p"$MYSQL_DB_PASS" -e 'create database magento';

sudo service nginx restart

php -d memory_limit=5028M /var/www/html/magento/bin/magento setup:install --base-url=http://$IP --base-url-secure=http://$IP --use-secure=0 --use-rewrites=1 --use-secure-admin=1 --backend-frontname=admin --db-host=127.0.0.1 --db-name=magento --db-user=root --db-password=$MYSQL_DB_PASS --use-secure=0 --base-url-secure=0 --use-secure-admin=0 --admin-firstname=Admin --admin-lastname=Adminovich --admin-email=admin@admin.ua --admin-user=admin --backend-frontname=admin --use-rewrites=1 --admin-password=admin123

echo "chmod -R 777 /var/www/html/magento/"

echo "yes | /var/www/html/magento/bin/magento setup:config:set --page-cache=redis --page-cache-redis-server=127.0.0.1 --page-cache-redis-db=1"

sudo chmod -R 777 /var/www/html/magento/

pkill mysql || true
