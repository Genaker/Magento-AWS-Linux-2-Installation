#!/bin/bash

# Works with Centos 8 and AWS LINUX 2

# Official documentation how to install 
# https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-a-prebuilt-centos-rhel-package-from-the-official-nginx-repository
echo "Install Nginx"

LINUX_VERSION=$(cat /etc/system-release)

echo $LINUX_VERSION

sudo yum remove nginx* -y

if echo $LINUX_VERSION | grep -q "Amazon Linux release 2"
then
  echo "Install Uing Amazon Linux Extras"
  OSRELEASE="7"
  sudo amazon-linux-extras install nginx1 -y
  sudo systemctl enable nginx
elif echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
  echo "Install Uing Centos 8"
  OSRELEASE="8"
  cat > /etc/yum.repos.d/nginx.repo <<END
[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
module_hotfixes=true
END
  sudo yum -y install nginx
elif echo $LINUX_VERSION | grep -q "Oracle Linux Server release 8"
then
  echo "Oracle Linux Server release 8"
  OSRELEASE="8"
  cat > /etc/yum.repos.d/nginx.repo <<END
[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
module_hotfixes=true
END
  sudo yum -y install nginx
  # Disable firewall on Oracle instance
  sudo systemctl disable firewalld
  sudo service firewalld stop
else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi

service nginx start
systemctl enable nginx
sudo chmod -R 775 /var/log/nginx/
nginx -v

echo "Install finished"

