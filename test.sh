#!bin/bash

sudo service nginx status ; sudo systemctl is-active --quiet redis && echo "Redis is running" ; sudo service elasticsearch status; sudo service docker status ; sudo service php-fpm status ; docker ps ;
