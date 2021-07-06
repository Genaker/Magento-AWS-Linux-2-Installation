#!/bin/bash/
# Repo is not working with ARM instances
sudo tee /etc/yum.repos.d/MariaDB.repo<<EOF 
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.4/centos8-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

sudo dnf install boost-program-options -y
sudo dnf install mariadb-server --disablerepo=AppStream -y
sudo dnf install mariadb-client -y
sudo systemctl enable --now mariadb

mysql -h 127.0.0.1 -u root -e 'Select Version()';
