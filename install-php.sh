#!/bin/bash
PHP_VERSION="7.4"

sudo amazon-linux-extras enable php${PHP_VERSION}

# to downgarede use disable command
#sudo amazon-linux-extras disable php7.4 

sudo amazon-linux-extras install php${PHP_VERSION} 

sudo yum install php php-common php-mysqlnd php-opcache php-xml php-mcrypt php-gd php-soap php-redis php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel -y

 sudo yum install php-pear -y
 sudo yum install libmcrypt libmcrypt-devel -y
 
# sudo pecl install mcrypt-1.0.2 -y
 
