#!/bin/bash
PHP_VERSION="7.4"

LINUX_VERSION=$(cat /etc/system-release)

echo $LINUX_VERSION

if echo $LINUX_VERSION | grep -q "Amazon Linux release 2"
then
  # TO DO MOVE REPOS to THE initial SCRITt 
  sudo amazon-linux-extras enable php${PHP_VERSION}
  # to downgarede use disable command
  #sudo amazon-linux-extras disable php7.4 
  sudo amazon-linux-extras install php${PHP_VERSION} 
  OS_RELATED = "php-redis php-pear libmcrypt libmcrypt-devel php-mcrypt"
elif echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
  # TO DO MOVE REPOS to THE initial SCRITt 
  yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y && \
  yum config-manager --set-enabled remi
  yum module reset php -y
  yum -y module enable php:remi-$PHP_VERSION
  OS_RELATED=" php74-php-pecl-mcrypt php74-php-pecl-redis "
else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi

sudo yum install php php-common php-mysqlnd php-opcache php-xml php-gd php-soap php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel $OS_RELATED -y

 
# sudo pecl install mcrypt-1.0.2 -y
 
