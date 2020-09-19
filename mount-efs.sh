#!/bin/bash

EFS_NAME="fs-52168e57?"

cd /var/www/html/magento/

sudo yum install -y amazon-efs-utils

mkdir pub/media-tmp

cp -r pub/media/* pub/media-tmp/

rm -rf pub/media/*

sudo mount -t efs -o tls $EFS_NAME:/ pub/media

cp -r pub/media-tmp/* pub/media/  && rm -rf pub/media-tmp/  # beter make async will rur for a while

sudo chmod -r 777 pub/media/ 

# or 

# sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport {EFS_DNS}/ efs

