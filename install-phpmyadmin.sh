#!/bin/bash

cd /var/www/html/

timestamp=$(date +%s)

sudo git clone --single-branch https://github.com/phpmyadmin/phpmyadmin.git phpmyadmin$timestamp

cd ./phpmyadmin$timestamp

composer install --no-dev

cat > /etc/nginx/conf.d/phpmyadmin.conf<<EOF
server {
        listen 80;
        listen [::]:80;

        server_name _; # You need replace this with your IP or mysqlphp specific IP 
        root /var/www/html;
        index index.php index.html;

        location / {
                index index.php;
                #try_files \$uri \$uri/ /index.php;
        }

        location ~ \.php$ {
                fastcgi_pass fastcgi_backend;
                fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
                include fastcgi_params;
                #include snippets/fastcgi-php.conf;
        }

	     location ~ \.(ico|jpg|jpeg|png|gif|svg|js|css|swf|eot|ttf|otf|woff|woff2|html|json)$ {
                add_header Cache-Control "public";
                add_header X-Frame-Options "SAMEORIGIN";
                expires +1y;
        }
}
EOF

curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash 

sudo yum install nodejs -y
sudo yum install yarn -y

yarn install

cp config.sample.inc.php config.inc.php

service nginx restart


## if host is different from localhost you need to edit config 
## if Login without a password is forbidden by configuration (see AllowNoPassword)
## $cfg['Servers'][$i]['AllowNoPassword'] = true; in config.sample.inc.php to use without password
