#!/bin/bash

## on remote original server 

# mysqldump -h production.cluster.us-east-1.rds.amazonaws.com -u prod_M2 -p'' magento2 | gzip -c | cat > myMagentoDatabaseDump-$(date +%Y-%m-%d-%H.%M.%S).sql.gz

## download form remote 

# scp remoteuser@remoteserver:~/myMagentoDatabaseDump.txt  myMagentoDatabaseDump.sql.gz

cd {path to magento}

## on a server archive magento forlder 
# tar -pczf magento.tar.gz --warning=no-file-changed --exclude "*/pub/media/*" .

# scp remoteuser@remoteserver:~/magento.tar.gz  magento.tar.gz

cp magento.tar.gz pub/media/

wget http://{{PATH}}/media/magento.zip

mkdir -p  /var/www/html/magento/

tar -xzf magento.zip --directory /var/www/html/magento/

## gzip -d magento.zip

mysql -h {host} -u {user} -p'{password}' {db_name} | gzip > mysqldump.sql.gz

