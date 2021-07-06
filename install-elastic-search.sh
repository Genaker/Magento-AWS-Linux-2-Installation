#!/bin/bash

yum -y install java

ELKREPO="7.x"

#install Elastic Search

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat > /etc/yum.repos.d/elastic.repo << EOF
[elasticsearch-${ELKREPO}]
name=Elasticsearch repository for ${ELKREPO} packages
baseurl=https://artifacts.elastic.co/packages/${ELKREPO}/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

sudo yum -y install --enablerepo=elasticsearch-${ELKREPO} elasticsearch

#echo "xpack.security.enabled: true" >> /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*cluster.name.*/cluster.name: magento/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*node.name.*/node.name: magento-node1/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*network.host.*/network.host: 127.0.0.1/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*http.port.*/http.port: 9200/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/-Xms.*/-Xms512m/" /etc/elasticsearch/jvm.options
sed -i "s/-Xmx.*/-Xmx512m/" /etc/elasticsearch/jvm.options
chown -R :elasticsearch /etc/elasticsearch/*

systemctl enable elasticsearch.service
systemctl restart elasticsearch.service
#/usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto

echo "ES Cluster Name : magento | Node: magento-node1 | Port: 9200 \n"

set +e
curl localhost:9200/
set -e
