#!/bin/bash

echo "Install Redis"

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

#sudo -u ec2-user /usr/local/bin/redis-server --daemonize yes

# Run as SUDO

cat > /etc/systemd/system/redis.service <<END
[Unit]
Description=Redis Data Store
After=network.target

[Service]
User=ec2-user
Group=ec2-user
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target
END

sudo systemctl enable redis
sudo systemctl start redis

sudo systemctl status redis

sudo service redis status
