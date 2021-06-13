#!/bin/bash

# Using this for ARM Graviton processor 
# it is difficult to run it on AEM a 

LINUX_VERSION=$(cat /etc/system-release)

echo $LINUX_VERSION

if echo $LINUX_VERSION | grep -q "Amazon Linux release 2"
then

  echo "Install Uing Amazon Linux Extras"
  
  sudo yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
  
  sudo yum install -y mysql-community-client
  
  OSRELEASE="7"
  sudo yum install docker -y

elif echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
  echo "Install Using Centos 8"
  OSRELEASE="8"
  sudo curl -fsSL https://get.docker.com/ | sh
  sudo yum install docker-ce -y


elif echo $LINUX_VERSION | grep -q "Oracle Linux Server release 8"
then
  echo "Install Uing Oracle 8"
  OSRELEASE="8"
  #sudo curl -fsSL https://get.docker.com/ | sh
  sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install docker-ce -y

else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi

sudo service docker start

sudo systemctl enable docker

sudo gpasswd -a "${USER}" docker

source ~/.bashrc

sudo chmod 777 /var/run/docker.sock
