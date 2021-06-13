#!/bin/bash

#remove default
sed -i 's/80/88/g'  /etc/nginx/nginx.conf
sed -i 's/80/88/g'  /etc/nginx/conf.d/default.conf

# Run when magento files are in place 

cat > /etc/nginx/conf.d/magento.conf<<EOF
server {
  listen 80;
  server_name _;
  set \$MAGE_ROOT /var/www/html/magento;
  
  # Cloud Flare SSL Flexible 
  # fastcgi_param  HTTPS on;  
  # proxy_set_header X-Forwarded-Proto $scheme;

  
  ##ADDITIONAL_CONFIG
  
  include /var/www/html/magento/nginx.conf.sample;
}

# PHP-FPM FastCGI server
# network or unix domain socket configuration

upstream fastcgi_backend {
        server unix:/run/php-fpm/www.sock;
}
EOF

# test Nginx config 

sudo nginx -t
