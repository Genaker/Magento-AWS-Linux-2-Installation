#!/bin/bash

#Install OpenMagen Magento 1 fork 

git clone https://github.com/OpenMage/magento-lts.git magento1

cd magento1

# Install MAgento 1 samole data 

sudo wget https://github.com/Vinai/compressed-magento-sample-data/raw/b1740ffe864198e31cef1a610047eaa8f3de293c/compressed-no-mp3-magento-sample-data-1.9.2.4.tgz

tar -xzf compressed-no-mp3-magento-sample-data-1.9.2.4.tgz

mysqladmin -h localhost -u root create magento1

mysql -h localhost -u root  magento1 < magento-sample-data-1.9.2.4/magento_sample_data_for_1.9.2.4.sql

rm magento-sample-data-1.9.2.4/magento_sample_data_for_1.9.2.4.sql

cp -r magento-sample-data-1.9.2.4/* .

rm -rf magento-sample-data-1.9.2.4

# Nginx Config 

cat > /etc/nginx/conf.d/magento1.conf<<EOF
server { 
	listen 8080; 
	##Change to your Magento 1  Root dir 
	root /var/www/html/magento1;
	index index.php index.html index.htm;
	 
	server_name _; 
	access_log /var/log/nginx/magento1_access.log;
	access_log /var/log/nginx/magento1_error.log;
	 
	## These locations would be hidden by .htaccess normally 
	location ^~ /app/                { deny all; } 
	location ^~ /includes/           { deny all; } 
	location ^~ /lib/                { deny all; } 
	location ^~ /media/downloadable/ { deny all; } 
	location ^~ /pkginfo/            { deny all; } 
	location ^~ /report/config.xml   { deny all; } 
	location ^~ /var/                { deny all; } 
	location /var/export/            { deny all; } 
	 
	# deny htaccess files 
	location ~ /\. { 
		deny  all; 
		access_log off; 
		log_not_found off; 
	} 
	 
	location ~*  \.(jpg|jpeg|png|gif|ico)$ { 
		expires 365d; 
		log_not_found off; 
		access_log off; 
	} 
	 
	location ~ .php/ { ## Forward paths like /js/index.php/x.js to relevant handler 
		rewrite ^(.*.php)/ $1 last; 
	}

	## rewrite anything else to index.php
	location / { 
		index index.html index.php;
		try_files $uri $uri/ /index.php?$query_string;
		expires 30d;
		rewrite /api/rest /api.php?type=rest;
	}
	 
	# pass the PHP scripts to FPM socket 
	location ~ \.php$ { 
		#fastcgi_pass 127.0.0.1:9000;
		#fastcgi_param MAGE_RUN_TYPE store;
		#fastcgi_index index.php; 
		#include fastcgi.conf; 
		try_files $uri =404;
    		fastcgi_pass   fastcgi_backend;
    		fastcgi_buffers 16 16k;
    		fastcgi_buffer_size 32k;

    		fastcgi_param  PHP_FLAG  "session.auto_start=off \n suhosin.session.cryptua=off";
    		fastcgi_param  PHP_VALUE "memory_limit=756M \n max_execution_time=18000";
    		fastcgi_read_timeout 600s;
    		fastcgi_connect_timeout 600s;

    		fastcgi_index  index.php;
    		fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
	    	include        fastcgi_params;


	}
}

# if not defined
#upstream fastcgi_backend {
 #       server unix:/run/php-fpm/www.sock;
#}

EOF

sudo service nginx restart

sudo chmod -r 777 var/*
