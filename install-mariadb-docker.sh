#!/bin/bash

# Using this for ARM Graviton processor 
# it is difficult to run it on AEM a 

LINUX_VERSION=$(cat /etc/system-release)

echo $LINUX_VERSION

if echo $LINUX_VERSION | grep -q "Amazon Linux release 2"
then
  echo "Install Uing Amazon Linux Extras"
  OSRELEASE="7"
  sudo yum install docker
elif echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
  echo "Install Uing Centos 8"
  OSRELEASE="8"
  sudo curl -fsSL https://get.docker.com/ | sh
  sudo yum install docker-ce
else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi

sudo service docker start

sudo systemctl enable docker

docker pull mariadb

docker images

sudo gpasswd -a "${USER}" docker

# ToDo: volume my.conf and db files

sudo docker run --name magento -p 3306:3306  -e MYSQL_ROOT_PASSWORD=root -d mariadb:latest

sudo yum install mysql -y 

# sudo docker exec -it magento bash
 
# sudo yum install mariadb-bench

# sudo docker exec -it magento bash

mysql -h 127.0.0.1 -u root -p'root' -e 'select Version();'

# you can commit DB inside of docker my using new image 

# docker ps  -a
# docker commit <CONTAINERID> mariadb:my

