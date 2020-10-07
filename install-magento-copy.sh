#!/bin/bash

cd {path to magento}

tar -pczf magento.tar.gz --warning=no-file-changed --exclude "*/pub/media/*" .

cp magento.tar.gz pub/media/

wget http://{{PATH}}/media/magento.zip

tar -xzf magento.zip

mysql -h {host} -u {user} -p'{password}' {db_name} | gzip > mysqldump.sql.gz

