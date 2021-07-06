#!/bin/bash/
# Repo is not working with ARM instances
wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
sudo chmod +x mariadb_repo_setup

sudo ./mariadb_repo_setup

sudo yum remove mysql* -y

sudo yum install perl-DBI libaio libsepol lsof boost-program-options rsync -y

sudo yum install MariaDB-server -y

sudo systemctl start mariadb.service

sudo systemctl enable mariadb.service
