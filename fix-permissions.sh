#!/bin/bash

echo "Fix Permissions"

# beter to run it like: bash fix-permissions.sh > /dev/null 2>&1
# >/dev/null makes 'stdout' text stream be sent to "nowhere",
# 2>&1 makes 'stderr' be sent to the same place,

cd /var/www/html/magento

sudo find . -type f -exec chmod 664 {} \;
sudo find . -type d -exec chmod 775 {} \;
sudo find var pub/static pub/media app/etc -type f -exec chmod g+w {} \;
sudo find var pub/static pub/media app/etc -type d -exec chmod g+ws {} \;
find ./var -type d -exec sudo chmod 777 {} \;
sudo chmod u+x bin/magento
sudo chown -R ec2-user:ec2-user .
sudo usermod -a -G ec2-user apache
sudo usermod -a -G ec2-user nginx
sudo usermod -a -G ec2-user ec2-user
sudo chmod -R g+w var/
sudo chmod -R g+w pub/media/

#or

#echo "\nUpdate permissions..."
#[OWNER][:[GROUP]]
#sudo chown -R ec2-user:ec2-user $project_dir
#sudo chmod -R 755 .
#sudo chmod -R 2750 .
#sudo chmod g-wx,o-wx $project_dir/generated
#sudo chown -h ec2-user:ec2-user $project_dir/pub/media/
#sudo chmod -R g+w $project_dir/var/
#sudo chmod -R g+w $project_dir/pub/media/
#echo "\n Block Execute permissions for files async [Only Linux user can execute] ..."
#sudo find . -type f -exec chmod g-x,o-x {} > /dev/null 2>&1 &
