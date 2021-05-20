#!/bin/bash

# Using this for ARM Graviton processor 
# it is difficult to run it on AEM a 

LINUX_VERSION=$(cat /etc/system-release)

echo $LINUX_VERSION

if echo $LINUX_VERSION | grep -q "Amazon Linux release 2"
then
  echo "Install Uing Amazon Linux Extras"
  OSRELEASE="7"
  sudo yum install docker -y

elif echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
  echo "Install Uing Centos 8"
  OSRELEASE="8"
  sudo curl -fsSL https://get.docker.com/ | sh
  sudo yum install docker-ce -y
else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi

sudo service docker start

sudo systemctl enable docker

docker pull mariadb

docker images

sudo gpasswd -a "${USER}" docker

source ~/.bashrc

sudo chmod 777 /var/run/docker.sock

# ToDo: volume my.conf and db files
# Official Documentatio https://hub.docker.com/_/mariadb

sudo docker run --name magento -p 3306:3306  -e MYSQL_ROOT_PASSWORD=root --restart unless-stopped -d mariadb:latest 

# mysql-cli

sudo yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm

sudo yum install -y mysql-community-client

sudo yum install mysql -y

# sudo yum install mysql -y 

# sudo docker exec -it magento bash
  
# sudo yum install mariadb-bench

# sudo docker exec -it magento bash

mysql -h 127.0.0.1 -u root -p'root' -e 'select Version();'

# you can commit DB inside of docker my using new image 

# docker ps  -a
# docker commit <CONTAINERID> mariadb:my

# IF you have issue PDOException: SQLSTATE[HY000] [1045] Access denied for user 'root'@'172.17.0.1' 

# do this to fix : https://medium.com/tech-learn-share/docker-mysql-access-denied-for-user-172-17-0-1-using-password-yes-c5eadad582d3

