#!/bin/bash

#install composer 

echo "Install Composer for PHP"

sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/bin --filename=composer --version>=2.5.4

composer config --global http-basic.repo.magento.com 5310458a34d580de1700dfe826ff19a1 255059b03eb9d30604d5ef52fca7465d

composer -v
