#!/bin/bash

# configure MAgento cron jobs 

cd /var/www/html/magento/

bin/magento cron:install --force
