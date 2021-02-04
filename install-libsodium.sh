#!/bin/bash

# Install Lib Sodium PHP

pecl install -f libsodium

sudo yum install libsodium libsodium-devel -y 

sudo pecl install libsodium

echo "extension=sodium.so" >> /etc/php.ini

sudo service php-fpm restart

php -i | grep sodium
