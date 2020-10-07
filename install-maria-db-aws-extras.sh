#!/bin/bash

sudo yum install -y mariadb-server

sudo systemctl enable mariadb.service

sudo service mariadb start

mysql -e 'Select Version()';

#ToDO: Compile from sources
