#!/bin/bash

mkdir -p /var/www/html/magento/

cd /var/www/html/magento/

git clone https://github.com/magenx/Magento-2.git .

echo "\nRun: "bin/magento  setup:install" to finish installation\n"
