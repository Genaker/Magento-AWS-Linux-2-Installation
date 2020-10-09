# Overthere a lot of ways of coping/mifrating magento to the new beter enviroment 

#SSH to the legacy Instance 
# Go to magento root dirrectory 
cd {MAgento pathc}

# archive all files except media var pub/static/ vendor/etc or you can copy everething 
tar -pczf magento.tar.gz --exclude "*/pub/media/*" .

#dump MYSQL you can also zip the dump
mysql -h {{HOST}} -u {{}} -p'{{}}' {{DB_NAME}}  > mysqldump.sql

# SSH to the new enviroment 

# undump zip and sql

sudo tar -xzf magento.tar.gz -C magento


# SET: AUTOCOMMIT=0, UNIQUE_CHECKS=0, FOREIGN_KEY_CHECKS=0 (AND DON'T FORGET TO ROLLBACK THIS CHANGES)
mysqladmin -h  -u   create database 'magento2'

mysql -h -u -p magento2 < magento_dump.sql

