#!/bin/bash

# Using this for ARM Graviton processor 
# it is difficult to run it on AEM a 

sudo yum install docker

sudo service docker start

docker pull mariadb

docker images

sudo gpasswd -a "${USER}" docker

sudo docker run -p 3306:3306  -e MYSQL_ROOT_PASSWORD=root -d mariadb:latest magento
 
sudo yum install mariadb-bench

#sudo docker exec -it magento bash

mysql -h 127.0.0.1 -u root -p'root' -e 'select Version();'
