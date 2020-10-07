#!/bin/bash

#Works only For x86 instances 

echo "Install Redis"

sudo amazon-linux-extras install epel -y 

sudo yum install epel-release yum-utils -y

sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

sudo yum-config-manager --enable remi

sudo yum install redis -y

redis-server -v

sudo service redis start

sudo chkconfig redis on
# edit redis configuration ToDO:
#sudo nano /etc/redis.conf
sudo systemctl enable redis

