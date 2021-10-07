#!/bin/bash
set -x

sudo bash ./install-docker-service.sh

docker pull mariadb

docker images

# ToDo: volume my.conf and db files
# Official Documentatio https://hub.docker.com/_/mariadb

DB_PASSWORD=asdfDFhdjtDFGeq4rwrc3IOcvxb4xbfsdf

sudo docker run --name magento -p 3306:3306  -e MYSQL_ROOT_PASSWORD=$DB_PASSWORD --restart unless-stopped -d mariadb:10.4 

echo "Mysql Password: $DB_PASSWORD"
echo "Mysql Password: $DB_PASSWORD" >> install-log.txt
# mysql-cli


sudo yum install mysql -y

# sudo yum install mysql -y 

# sudo docker exec -it magento bash
  
# sudo yum install mariadb-bench

# sudo docker exec -it magento bash

sleep 5

#mysql -h 127.0.0.1 -u root -p'root' -e 'select Version();'

# you can commit DB inside of docker my using new image 

# docker ps  -a
# docker commit <CONTAINERID> mariadb:my

# IF you have issue PDOException: SQLSTATE[HY000] [1045] Access denied for user 'root'@'172.17.0.1' 

# do this to fix : https://medium.com/tech-learn-share/docker-mysql-access-denied-for-user-172-17-0-1-using-password-yes-c5eadad582d3
