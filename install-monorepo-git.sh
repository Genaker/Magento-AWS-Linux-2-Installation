#!/bin/bash

cd /var/www/html/magento/

git clone https://github.com/magenx/Magento-2.git .

echo "\nRun: bin/magento  setup:install\n"
