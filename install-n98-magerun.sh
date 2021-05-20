#!bin/bash

curl -O https://files.magerun.net/n98-magerun2.phar

sudo chmod +x ./n98-magerun2.phar

sudo cp ./n98-magerun2.phar /usr/local/bin/

n98-magerun2.phar --version
