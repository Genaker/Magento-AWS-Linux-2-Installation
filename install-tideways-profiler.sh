#!/bin/bash

# run as SUDO

echo "[tideways]
name = Tideways
baseurl = https://packages.tideways.com/yum-packages-main" > /etc/yum.repos.d/tideways.repo
rpm --import https://packages.tideways.com/key.gpg
yum makecache --disablerepo=* --enablerepo=tideways
sudo yum -y install tideways-php tideways-cli tideways-daemon --nogpgcheck
