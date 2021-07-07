#!/bin/bash/
# Repo is not working with ARM instances
#wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup
#sudo chmod +x mariadb_repo_setup

#sudo ./mariadb_repo_setup
cat > /etc/yum.repos.d/mariadb.repo << EOF
[mariadb-main]
name = MariaDB Server
baseurl = https://dlm.mariadb.com/repo/mariadb-server/10.4/yum/rhel/8/x86_64
gpgkey = file:///etc/pki/rpm-gpg/MariaDB-Server-GPG-KEY
gpgcheck = 1
enabled = 1
module_hotfixes = 1

[mariadb-maxscale]
# To use the latest stable release of MaxScale, use "latest" as the version
# To use the latest beta (or stable if no current beta) release of MaxScale, use "beta" as the version
name = MariaDB MaxScale
baseurl = https://dlm.mariadb.com/repo/maxscale/latest/yum/rhel/8/x86_64
gpgkey = file:///etc/pki/rpm-gpg/MariaDB-MaxScale-GPG-KEY
gpgcheck = 1
enabled = 1

[mariadb-tools]
name = MariaDB Tools
baseurl = https://downloads.mariadb.com/Tools/rhel/8/x86_64
gpgkey = file:///etc/pki/rpm-gpg/MariaDB-Enterprise-GPG-KEY
gpgcheck = 1
enabled = 1
EOF

sudo yum remove mysql* -y

sudo yum install perl-DBI libaio libsepol lsof boost-program-options rsync -y

sudo yum install MariaDB-server -y

sudo systemctl start mariadb.service

sudo systemctl enable mariadb.service
