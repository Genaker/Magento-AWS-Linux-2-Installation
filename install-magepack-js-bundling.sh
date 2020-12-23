#!/bin/bash

# Install node JS

# Debian/Ubuntu
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# Centos 
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs

# Install Mage Pack 
sudo npm install -g magepack --unsafe-perm=true --allow-root

sudo yum install pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 -y

# To bundle use
# magepack generate --cms-url="{CMS_PAGE_URL}" --category-url="{CATEGORY_PAGE_URL}" --product-url="{PRODUCT_PAGE_URL}"
# magepack bundle
