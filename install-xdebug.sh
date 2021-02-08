#!/bin/bash

sudo pecl install xdebug

echo "zend_extension=/usr/lib64/php/modules/xdebug.so" > /etc/php.d/40-xdebug.ini

sudo service php-fpm restart
