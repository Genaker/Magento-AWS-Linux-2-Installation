#!/bin/bash

# CentOS/RHEL

curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.rpm.sh | sudo bash
sudo yum install mysql-devel mysql-lib
sudo yum -y install sysbench
which sysbench
mysql -e "create database test"

sysbench /usr/share/sysbench/oltp_read_only.lua --threads=4 --mysql-host=127.0.0.1 --mysql-db=test --mysql-user=root --mysql-password=root --tables=10 --table-size=10000 prepare
sysbench /usr/share/sysbench/oltp_read_only.lua --threads=2 --mysql-host=127.0.0.1 --mysql-db=test --mysql-user=root --mysql-password=root --tables=10 --table-size=1000000 --range_selects=off --db-ps-mode=disable --report-interval=1 run
sysbench /usr/share/sysbench/oltp_read_only.lua --threads=2 --mysql-host=127.0.0.1 --mysql-db=test --mysql-user=root --mysql-password=root --tables=10 --table-size=1000000 --range_selects=off --db-ps-mode=disable --report-interval=1 cleanup


# Ubuntu
# curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | sudo bash
# sudo apt -y install sysbench
