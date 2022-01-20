#!/bin/bash

set -x

# Supports AWS Linux and Centos 8

PHP_VERSION="${PHP_VERSION:-7.4}"

echo $PHP_VERSION

LINUX_VERSION=$(cat /etc/system-release)

sudo yum install make -y

echo $LINUX_VERSION

sudo yum remove php* -y


if echo $LINUX_VERSION | grep -q "Amazon Linux release 2"
then
  # TO DO MOVE REPOS to THE initial SCRITt 
  sudo amazon-linux-extras enable php${PHP_VERSION}
  sudo yum clean metadata
  # to downgarede use disable command
  #sudo amazon-linux-extras disable php${PHP_VERSION}
  # sudo yum remove php* -y
  # sudo yum autoremove php php-common
  sudo yes | sudo amazon-linux-extras install php${PHP_VERSION} 
  # sudo yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap}
  OS_RELATED = " php-redis php-pear libmcrypt libmcrypt-devel php-mcrypt "
  
  ## REmi repo 
  
  # sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
  # sudo yum --disablerepo="*" --enablerepo="remi-safe" list php[7-9][0-9].x86_64
  # sudo yum-config-manager --setopt="remi-php73.priority=5" --enable remi-php73
  # sudo yum install php php-common php-mysqlnd php-opcache php-xml php-gd php-soap php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel
  # wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
  # tar -zxvf ioncube_loaders_lin_x86*
  # sudo cp ioncube/ioncube_loader_lin_7.3.so /usr/lib64/php/
  # Then add below line as the first line in the respective php.ini files.
  # zend_extension = /usr/lib64/php/ioncube_loader_lin_7.3.so
  # sudo yum install nginx -y

elif echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
  # TO DO MOVE REPOS to THE initial SCRITt 
  #yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y 
  sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
  ## ARM instances has issues with remi repo - remi doesn't support ARM
  yum install config-manager -y
  #yum config-manager --set-enabled remi
  sudo yum module list php
  yum module reset php -y
  sudo dnf module list reset php -y
  yes | sudo yum module enable php:$PHP_VERSION
  yes | sudo dnf module enable php:remi-$PHP_VERSION
  #yum module reset php -y
  #yum -y module enable php:remi-$PHP_VERSION
  sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
  OS_RELATED=" php74-php-pecl-mcrypt php74-php-pecl-redis  "


elif echo $LINUX_VERSION | grep -q "Oracle Linux Server release 8"
then
  # TO DO MOVE REPOS to THE initial SCRITt 
  
 yum module reset php -y

 yes | sudo dnf module enable php:${PHP_VERSION} -y
 sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
 
 OS_RELATED=" php74-php-pecl-mcrypt php74-php-pecl-redis "
  
 sudo setenforce Permissive
 
else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi

sudo yum -y install php php-common php-pear php-mysqlnd php-opcache php-xml php-gd php-soap php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel 

sudo yum -y install $OS_RELATED

sudo yum install libsodium libsodium-devel -y
sudo yum install libzip-devel -y
sudo yum install libzstd-devel -y

yes | sudo pecl install libsodium 
yes | sudo pecl install igbinary
yes | sudo pecl install redis 

  echo "extension=igbinary.so" | sudo tee /etc/php.d/10-igbin.ini
  echo "extension=redis.so" | sudo tee /etc/php.d/50-redis.ini
  echo "extension=sodium.so" | sudo tee /etc/php.d/20-sodium.ini
 

## downgrade php 
#
# yum remove php-cli mod_php php-common
# 
# yum module reset php -y
# yum -y module enable php:remi-7.2
# https://computingforgeeks.com/enable-powertools-repository-on-centos-rhel-linux/
# yum install php-common php-mysqlnd php-opcache php-xml php-gd php-soap php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel php72-php-pecl-mcrypt php72-php-pecl-redis
# sudo yum --enablerepo="power*" --enablerepo="epel"  install php-common php-mysqlnd php-opcache php-xml php-gd php-soap php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel php73-php-pecl-mcrypt php73-php-pecl-redis

bash ./install-libsodium.sh

sudo yum install php-fpm -y
service php-fpm start
systemctl enable php-fpm

sudo chmod -R 775 /var/log/php-fpm/

echo "PHP $PHP_VERSION is installed "
 
# sudo pecl install mcrypt-1.0.2 -y
 
