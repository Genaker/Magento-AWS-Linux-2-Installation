#!/bin/bash

# Install XHProf selfhosted

git clone "https://github.com/tideways/php-xhprof-extension.git"
cd php-xhprof-extension
phpize
./configure
make
sudo make install

## Configure the extension to load with this PHP INI directive

echo "extension=tideways_xhprof.so" > /etc/php.d/99-profiler.ini

## 

cd /var/www/html/

git clone https://github.com/phacility/xhprof

HTML_PATH="/var/www/html/xhprof/xhprof_html"

# USAGE https://github.com/tideways/php-xhprof-extension#usage

##ADDITIONAL_CONFIG##ADDITIONAL_CONFIG

cat > /etc/nginx/conf.d/xhprof.conf.part<<EOF

location ^~ /xhprof_html/ {
    root /var/www/html/xhprof/;
    include /etc/nginx/fastcgi_params;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME /var/www/html/xhprof\$fastcgi_script_name;
    fastcgi_pass fastcgi_backend;

    location ~ ^.*\.(css|js|gif)$ {}
  }
EOF

sudo sed -i 's/##ADDITIONAL_CONFIG/##ADDITIONAL_CONFIG \n include \/etc\/nginx\/conf.d\/xhprof.conf.part;/g'  /etc/nginx/conf.d/magento.conf

cd /var/www/html/

git clone https://github.com/perftools/xhgui.git
cd xhgui
yum -y install gcc php-pear php-devel

sudo pecl install mongodb

echo "extension=mongodb.so" > /etc/php.d/88-mongo.ini

composer install --ignore-platform-reqs

php install.php

sudo service php-fpm restart

# error_reporting(E_ALL ^ E_DEPRECATED) fix error 


