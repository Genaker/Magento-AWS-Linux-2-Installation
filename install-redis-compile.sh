#!/bin/bash

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

sudo systemctl enable redis
sudo systemctl start redis

sudo service redis status
