#!/bin/bash

YOUR_GIT_REPOSETORY="https://github.com/magento/magento2"

cd /var/www/html/magento/

git clone $YOUR_GIT_REPOSETORY . #replace with your git hub url

composer install # use instal if you are having Lock file or Update if without 

# wget http://s3.example.com/production_dump.sql.gz

#mysql  magento2 < ./production_dump.sql.gz

bash ./install-magento.sh

