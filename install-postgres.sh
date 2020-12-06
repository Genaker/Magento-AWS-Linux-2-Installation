
# Tested on centos 7 only 

sudo tee /etc/yum.repos.d/pgdg.repo<<EOF
[pgdg12]
name=PostgreSQL 12 for RHEL/CentOS 7 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-7-x86_64
enabled=1
gpgcheck=0
EOF


sudo yum install postgresql12 postgresql12-server -y

//way to get extensions
sudo  yum install postgresql12-contrib -y

sudo yum install php-pgsql -y

 sudo /usr/pgsql-12/bin/postgresql-12-setup initdb
 
 sudo systemctl enable --now postgresql-12
 
 systemctl status postgresql-12
 
 sudo -u postgres psql -c 'SELECT version()'
 
 //psql -c "alter user postgres with password 'your Password'"
 
 sudo -u postgres psql magento -c 'CREATE TABLE cars( id SERIAL PRIMARY KEY, cars_info JSONB NOT NULL);'
 
 sudo -u postgres psql magento -c 'CREATE INDEX idxgin ON product USING gin (data);'
 
 sudo -u postgres psql magento -c 'CREATE EXTENSION pg_trgm;';
 
 sudo -u postgres psql magento -c 'CREATE EXTENSION "btree_gin"';
 
 sudo -u postgres psql -c 'SHOW config_file'
 
 
 //create index tt_jb_int_idx on product using gin( cast (data->>'row_id' as int));
 //CREATE INDEX idx_btree_product_ASdsad ON product USING BTREE ((data->>'row_id'));
 //CREATE INDEX trgm_idx_users_first ON product USING gin ((data->>'sku') gin_trgm_ops);
 
 //sudo nano /var/lib/pgsql/12/data/pg_hba.conf 
 
 # TYPE  DATABASE        USER            ADDRESS                 METHOD

 # "local" is for Unix domain socket connections only
 #local   all             all                                     trust
 # IPv4 local connections:
 #host    all             all             127.0.0.1/32            trust
 # IPv6 local connections:
 #host    all             all             ::1/128                 trust
 
 
 
