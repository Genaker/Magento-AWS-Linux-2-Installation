# Overthere a lot of ways of coping/mifrating magento to the new beter enviroment 

#SSH to the legacy Instance 
# Go to magento root dirrectory 
cd {MAgento pathc}

# archive all files except media var pub/static/ vendor/etc and other garbage or you can copy everething 
tar -pczf magento.tar.gz --warning=no-file-changed --exclude "*/pub/media/*" --exclude "*/var/*" --exclude "*.zip" --exclude "*.sql" --exclude "*.tar*" --exclude "*.gz*" --exclude "*.tgz" .

#check Size of the dump file 
ls -lh magento.tar.gz
 
#dump MYSQL you can also zip the dump
mysql -h {{HOST}} -u {{}} -p'{{}}' {{DB_NAME}}  > mysqldump.sql

# Check MySQL database size 

# SELECT table_schema AS "Database", ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)" FROM information_schema.TABLES GROUP BY table_schema;

#  

# To check DB credentials 

cat app/etc/env.php | grep "db\|password\|host\|user"

# I like download that files by placing it to pub/media floder. However don't forgot remove it after. 

# SSH to the new enviroment 

# Copy dump files :

scp {user}@{ip}:/../public_html/dump.sql .

# undump zip and sql

sudo tar -xzf magento.tar.gz -C magento --skip-old-files


# SET: AUTOCOMMIT=0, UNIQUE_CHECKS=0, FOREIGN_KEY_CHECKS=0 (AND DON'T FORGET TO ROLLBACK THIS CHANGES)
mysqladmin -h  -u  create 'magento2'

mysql -h -u -p magento2 < magento_dump.sql

## I also had an issue :

# ERROR 1293 (HY000) at line 142: Incorrect table definition; there can be only one TIMESTAMP column with CURRENT_TIMESTAMP in DEFAULT or ON UPDATE clause
# fix
# sed -i 's/timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT /timestamp NOT NULL DEFAULT 0 COMMENT /' magento_dump.sql

