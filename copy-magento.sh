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
mysqladmin -h  -u  create 'magento2'

mysql -h -u -p magento2 < magento_dump.sql

## I also had an issue :

# ERROR 1293 (HY000) at line 142: Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause
# fix
# sed -i 's/timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT /timestamp NOT NULL DEFAULT 0 COMMENT /' magento_dump.sql

