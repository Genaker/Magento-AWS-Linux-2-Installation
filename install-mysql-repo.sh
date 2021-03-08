#!/bin/bash

#Works only with x86 instance
 
MARIADB="10.2" 

#install MAriaDB 10.4

echo "Install Maria DB"

sudo tee /etc/yum.repos.d/MariaDB.repo<<EOF 
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/$MARIADB/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

sudo yum -y install MariaDB-server MariaDB-client

sudo service mariadb start

mysql -e 'Select Version()';

## Check if Mysql is Running 

# systemctl is-active --quiet mysql  ||  (mkdir -p /var/run/mysqld/ && sudo chmod -R 777 /var/run/mysqld/ && sudo service mysql restart)
