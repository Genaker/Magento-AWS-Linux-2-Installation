#!/bin/bash/
# Repo is not working with ARM instances
LINUX_VERSION=$(cat /etc/system-release)

echo $LINUX_VERSION

if echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
##wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup

# The MariaDB Repository supports these Linux OSs, on x86_64 only:
#    * RHEL/CentOS 7 & 8 (rhel)
#    * Ubuntu 18.04 LTS (bionic), & 20.04 LTS (focal)
#    * Debian 9 (stretch), 10 (buster), & 11 (bullseye)
#    * SLES 12 & 15 (sles)

##sudo chmod +x mariadb_repo_setup
##sudo ./mariadb_repo_setup
##rm /etc/yum.repos.d/mariadb.repo

cat > /etc/yum.repos.d/mariadb.repo << EOF
[mariadb-main]
name = MariaDB Server
baseurl = https://dlm.mariadb.com/repo/mariadb-server/10.4/yum/rhel/8/x86_64
gpgkey = file:///etc/pki/rpm-gpg/MariaDB-Server-GPG-KEY
gpgcheck = 0
enabled = 1
module_hotfixes = 1

[mariadb-maxscale]
# To use the latest stable release of MaxScale, use "latest" as the version
# To use the latest beta (or stable if no current beta) release of MaxScale, use "beta" as the version
name = MariaDB MaxScale
baseurl = https://dlm.mariadb.com/repo/maxscale/latest/yum/rhel/8/x86_64
gpgkey = file:///etc/pki/rpm-gpg/MariaDB-MaxScale-GPG-KEY
gpgcheck = 0
enabled = 1

[mariadb-tools]
name = MariaDB Tools
baseurl = https://downloads.mariadb.com/Tools/rhel/8/x86_64
gpgkey = file:///etc/pki/rpm-gpg/MariaDB-Enterprise-GPG-KEY
gpgcheck = 0
enabled = 1
EOF

sudo yum remove mysql* -y

sudo yum install perl-DBI libaio libsepol lsof boost-program-options rsync -y

sudo yum install MariaDB-server -y

sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service


## Oracle HAS OWN MYSQL not MARIADB repo with ARM support 

elif echo $LINUX_VERSION | grep -q "Oracle Linux Server release 8"
then
echo "Installing MySQL 8 and not MariaDB"
sudo yum remove mysql* -y
sudo yum install mysql-server -y
DB_PASSWORD='MyNewSecurePasswordI#Changed1234'
#https://www.tecmint.com/reset-root-password-in-mysql-8/
sudo service mysqld stop
sudo pkill mysql
sudo  mysqld --skip-grant-tables --user=mysql &
sleep 5
mysql -h localhost -u root -e "FLUSH PRIVILEGES;ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASSWORD'"
mysql -h 127.0.0.1 -u root -p"$DB_PASSWORD" -e 'select VERSION();'
sudo pkill mysqld
mysql -h 127.0.0.1 -u root -p"$DB_PASSWORD" -e 'select VERSION();'
sudo service mysqld start
sudo systemctl enable mysqld
mysql -h 127.0.0.1 -u root -p"$DB_PASSWORD" -e 'select VERSION();'

else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi
