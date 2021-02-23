#!/bin/bash

sudo fallocate -l 2G /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1024 count=1048576
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
#sudo nano /etc/fstab
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
