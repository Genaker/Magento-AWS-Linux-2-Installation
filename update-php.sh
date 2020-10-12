 #!/bin/bash

sudo amazon-linux-extras disable php7.3
sudo amazon-linux-extras enable php7.4

sudo yum install php7.4

sudo yum remove php*

sudo  yum --disablerepo="epel" repolist
sudo  yum --disablerepo="amzn2-core" repolist

sudo yum install httpd-mmn -y

sudo yum  --disablerepo="amzn2-core" --disablerepo="epel"  install php httpd-mmn php-common php-mysqlnd php-opcache php-xml php-mcrypt php-gd php-soap php-redis php-bcmath php-intl php-mbstring php-json php-iconv php-fpm php-apcu php-zip php-devel -y


