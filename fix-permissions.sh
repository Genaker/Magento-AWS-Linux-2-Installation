#!/bin/bash

echo "Fix Permissions"

cd /var/www/html/magento

sudo find . -type f -exec chmod 664 {} \;
sudo find . -type d -exec chmod 775 {} \;
sudo find var pub/static pub/media app/etc -type f -exec chmod g+w {} \;
sudo find var pub/static pub/media app/etc -type d -exec chmod g+ws {} \;
find ./var -type d -exec chmod 777 {} \;
sudo chmod u+x bin/magento
sudo chown -R ec2-user:ec2-user .
sudo usermod -a -G ec2-user apache
sudo usermod -a -G ec2-user nginx
sudo usermod -a -G ec2-user ec2-user
sudo chmod -R g+w var/
sudo chmod -R g+w pub/media/
