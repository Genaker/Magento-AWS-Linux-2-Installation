#!/bin/bash

#remove default
sed 's/80/6666/g'  /etc/nginx/nginx.conf

cat > /etc/nginx/conf.d/magento.conf<<EOF
server {
  listen 80;
  server_name _;
  set \$MAGE_ROOT /var/www/html/magento;
  include /var/www/html/magento/nginx.conf.sample;
}

# PHP-FPM FastCGI server
# network or unix domain socket configuration

upstream fastcgi_backend {
        server unix:/run/php-fpm/www.sock;
}
EOF
