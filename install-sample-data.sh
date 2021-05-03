 #!bin/bash
 
 cd /var/www/html/magento
 
 git clone https://github.com/magento/magento2-sample-data.git
 
 php -f ./magento2-sample-data/dev/tools/build-sample-data.php -- --ce-source="/var/www/html/magento"
 
 bin/magento setup:upgrade
