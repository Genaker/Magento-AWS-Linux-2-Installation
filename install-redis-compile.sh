#!/bin/bash

# Tested Centos 8, AWS? ARM?

echo "Install Redis"

yum install make -y 
sudo yum install gcc -y

wget http://download.redis.io/redis-stable.tar.gz 

tar xvzf redis-stable.tar.gz

cd ./redis-stable/deps
make hiredis jemalloc linenoise lua geohash-int
cd ..
make
sudo make install

sudo mkdir -p /etc/redis

cd ..

pwd

sudo cp ./redis-stable/redis.conf /etc/redis

sudo groupadd redis
sudo adduser --system -g redis --no-create-home redis
mkdir -p /var/lib/redis

# Use gpasswd for immediate change
sudo gpasswd -a redis redis

#ToDo: Improve permissions

#sudo chmod -R 777 /usr/local/bin/redis-server /etc/redis/redis.conf

#sudo -u ec2-user /usr/local/bin/redis-server --daemonize yes

# Run as SUDO
# Detailed instruction: https://www.digitalocean.com/community/tutorials/how-to-install-redis-from-source-on-ubuntu-18-04

cat > /etc/systemd/system/redis.service <<END
[Unit]
Description=Redis Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
END

cd ..

#auto start Redis after searver reload 
sudo systemctl enable redis

sudo systemctl start redis

sudo service redis status --no-pager

#   It is also possible to remove all the previously configured save
#   points by adding a save directive with a single empty string argument
#   like in the following example:
#
#   save ""

#/etc/redis/redis.conf

# bind 0.0.0.0

# Set the number of databases. The default database is DB 0, you can select
# a different one on a per-connection basis using SELECT <dbid> where
# dbid is a number between 0 and 'databases'-1
# databases 1000000

