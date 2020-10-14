#!/bin/bash

# Using this for ARM Graviton processor 
# it is difficult to run it on AEM a 

sudo yum install docker

sudo service docker start

docker pull mariadb

docker images

sudo gpasswd -a "${USER}" docker

# ToDo: volume my.conf and db files

sudo docker run --name magento -p 3306:3306  -e MYSQL_ROOT_PASSWORD=root -d mariadb:latest

# sudo docker exec -it magento bash
 
sudo yum install mariadb-bench

# sudo docker exec -it magento bash

mysql -h 127.0.0.1 -u root -p'root' -e 'select Version();'

# you can commit DB inside of docker my using new image 

# docker ps  -a
# docker commit <CONTAINERID> mariadb:my

