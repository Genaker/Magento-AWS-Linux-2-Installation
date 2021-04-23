#!/bin/bash

sudo yum-config-manager --enable epel

sudo yum install certbot python3-certbot-nginx
# in some cases python2-certbot-nginx

echo "\nEnter domain names separated by spaces: "  
read MAGENTO_DOMAIN  

#if not empty
[[ ! -z "$MAGENTO_DOMAIN" ]] && sudo sed -i 's/server_name _;/server_name $MAGENTO_DOMAIN;/g' /etc/nginx/conf.d/magento.conf

echo "\n NOTICE: your domains should pass the validation/chalange (https://letsencrypt.org/docs/challenge-types/) \n"

sudo certbot --nginx

# You shuld See Something like 
# Saving debug log to /var/log/letsencrypt/letsencrypt.log
# Plugins selected: Authenticator nginx, Installer nginx

# Which names would you like to activate HTTPS for?
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 1: magento2-example-domain.com
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# and After execution 
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Congratulations! You have successfully enabled https://magento2-example-domain.com
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Subscribe to the EFF mailing list (email: egorshitikov@gmail.com).

# Agento 2 Config for Https 
# mysql -u root magento2 -e 'UPDATE core_config_data set value = "1" where path like "%web/secure/use_in%"'

# mysql -u root magento2 -e "UPDATE core_config_data set value = \"https://$MAGE_DOMAIN/\" where path like \"%base_url%\""
# mysql -u root magento2 -e "UPDATE core_config_data set value = \"https://$MAGE_DOMAIN/\" where path like \"%web/secure/base_link_url%\""

# Set up HTTPS automatic renewal

echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null

# To confirm that your site is set up properly, visit https://yourmagentodomain.com/ in your browser and look for the lock icon in the URL bar.
# If you want to check that you have the top-of-the-line installation, you can head to https://www.ssllabs.com/ssltest/.

sudo service nginx restart

sudo yum-config-manager --disable epel

# renew certificate  

# sudo certbot renew
