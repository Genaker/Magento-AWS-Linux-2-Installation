#!/bin/bash

cd <your Magento install dir> 

// 644 permission for files
find . -type f -exec chmod 644 {} \; 
                   
// 755 permission for directory
find . -type d -exec chmod 755 {} \;    

chmod 644 ./app/etc/*.xml

chown -R :<web server group> .

chmod u+x bin/magento
