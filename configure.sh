#!/bin/bash

bash ./configure-nginx.sh

bash ./configure-php.sh

sudo service nginx restart
sudo service php-fpm restart
sudo service elasticsearch restart
sudo service redis restart

#instance Public ip 
curl ipinfo.io/ip
