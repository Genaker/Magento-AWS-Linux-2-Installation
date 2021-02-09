#!/bin/bash

cd /var/www/html/

git clone {{repo}}.git magento

cd magento

composer install

# composer will ask magento repo credentials 

# run install-magento.sh
