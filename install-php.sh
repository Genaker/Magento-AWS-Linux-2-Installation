#!/bin/bash
PHP_VERSION="7.4"

sudo amazon-linux-extras install php${PHP_VERSION}

sudo yum install php php-common php-mysqlnd php-opcache php-xml php-mcrypt php-gd php-soap php-redis php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel -y
