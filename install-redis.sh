#!/bin/bash

echo "Install Redis"

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
