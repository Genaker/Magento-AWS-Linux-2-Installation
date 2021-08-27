#!/bin/bash

wget https://downloads.mariadb.org/interstitial/mariadb-10.4.21/source/mariadb-10.4.21.tar.gz
tar xvf mariadb-10.4.21.tar.gz
yum install cmake make openscap-utils python3-pyyaml python3-jinja2 libarchive libaio-devel ncurses-devel gnutls-utils cmake make gcc gcc-c++ ncurses-devel libevent openssl openssl-devel gnutls-devel libxml2 libxml2-devel bison -y

# if you have error fix it 
# remove CMakeCache.txt , and try again

cmake . -DBUILD_CONFIG=mysql_release -DPLUGIN_AUTH_PAM=NO  -DPLUGIN_AUTH_PAM_V1=NO

make 
sudo make install

sudo useradd -r mysql


sudo chown -R mysql /usr/local/mysql/
sudo /usr/local/mysql/scripts/mysql_install_db --user=mysql --datadir=/usr/local/mysql/data/

PATH=$PATH:/usr/local/mysql/bin

// http://www.mysqlab.net/knowledge/kb/detail/topic/installation/id/4923
sudo /usr/local/mysql/bin/mysqld_safe --datadir='/usr/local/mysql/data' &


# Make sure that NOBODY can access the server without a password
mysql -e "UPDATE mysql.user SET Password = PASSWORD('SecurePasswordChangeMe') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"

sudo tee /etc/systemd/system/mariadb.service<<EOF 
[Unit]
Description=MariaDB database server
After=network.target
After=syslog.target

[Service]
Type=simple
PrivateNetwork=false
User=mysql
Group=mysql
CapabilityBoundingSet=CAP_IPC_LOCK
PermissionsStartOnly=true
ExecStart=/usr/local/mysql/bin/mysqld_safe --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID

Restart=on-abort
RestartSec=5s
UMask=007
PrivateTmp=false
LimitNOFILE=16364

[Install]
WantedBy=multi-user.target
Alias=mysql.service
Alias=mysqld.service
EOF

sudo pkill mysqld
sudo systemctl start mariadb
sudo systemctl status mariadb
sudo systemctl enable mariadb

