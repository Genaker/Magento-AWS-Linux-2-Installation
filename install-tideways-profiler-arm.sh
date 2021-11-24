#!bin/bash

PHP_EXT="https://s3-eu-west-1.amazonaws.com/tideways/extension/5.4.26/tideways-php-5.4.26-arm64.tar.gz"
DEAMON="https://s3-eu-west-1.amazonaws.com/tideways/daemon/1.7.20/tideways-daemon_linux_aarch64-1.7.20.tar.gz"

"Install TIDEWAYS PHP Extension"
wget -O tideways-php-latest.tar.gz $PHP_EXT
tar xzvf tideways-php-latest.tar.gz --directory tideways-php
cd tideways-php
sudo bash install.sh

echo "Install TIDEWAYS Deamon"
wget -O tideways-deamon.tar.gz $DEAMON
tar xzvf tideways-deamon.tar.gz --directory tideways-deamon
cd tideways-deamon
sudo bash install.sh

# on ARM deamon has an issue:
# you need manually run : sudo tideways-daemon
