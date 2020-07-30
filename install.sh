#!/bin/bash
PHP_VERSION=7.4

sudo amazon-linux-extras install php${PHP_VERSION}

sudo yum install php php-common php-mysqlnd php-opcache php-xml php-mcrypt php-gd php-soap php-redis php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel -y

sudo yum install wget git unzip htop -y

sudo amazon-linux-extras install epel -y 

sudo yum install epel-release yum-utils

sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

sudo yum-config-manager --enable remi

sudo yum install redis

sudo service redis start

sudo chkconfig redis on
# edit redis configuration ToDO:
#sudo nano /etc/redis.conf
sudo systemctl enable redis

sudo amazon-linux-extras install nginx1 -y
sudo systemctl enable nginx



#install composer 
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

composer -v

#install MAriaDB

sudo yum install -y mariadb-server
sudo service mariadb start



