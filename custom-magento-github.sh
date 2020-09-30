#!/bin/bash

YOUR_GIT_REPOSETORY="https://github.com/magento/magento2"
MAGE_DOMAIN=$(curl ipinfo.io/ip)

cd /var/www/html/magento/

git clone $YOUR_GIT_REPOSETORY . #replace with your git hub url

git config core.fileMode false
git config --global credential.helper store

composer install # use instal if you are having Lock file or Update if without 

# wget http://s3.example.com/production_dump.sql.gz

# mysql -u root -e  'create database magento2;'

# mysql -u root magento2 < ./production_dump.sql.gz

# zcat ./production_dump.sql.gz | mysql -u root magento2 

# rm /production_dump.sql.gz 

# change magento configurations

# for HTTPS

# mysql -u root magento2 -e 'UPDATE core_config_data set value = "0" where path like "%web/secure/use_in%"'

# mysql -u root magento2 -e "UPDATE core_config_data set value = \"http://$MAGE_DOMAIN/\" where path like \"%base_url%\""
# mysql -u root magento2 -e "UPDATE core_config_data set value = \"http://$MAGE_DOMAIN/\" where path like \"%web/unsecure/base_link_url%\""

# for Https 
# mysql -u root magento2 -e 'UPDATE core_config_data set value = "1" where path like "%web/secure/use_in%"'

# mysql -u root magento2 -e "UPDATE core_config_data set value = \"https://$MAGE_DOMAIN/\" where path like \"%base_url%\""
# mysql -u root magento2 -e "UPDATE core_config_data set value = \"https://$MAGE_DOMAIN/\" where path like \"%web/unsecure/base_link_url%\""


rm -rf ./app/env.php

# copy production images to S3
# aws s3 cp /{magento_dir}/pub/media/ s3://{your-s3media-bucked}/ --recursive --exclude "*cache*"

# copy from s 3 to current server 
# aws s3 cp s3://{your-s3media-bucked}/ /{magento_dir}/pub/media/  --recursive --exclude "*cache*"

bash ./install-magento.sh
