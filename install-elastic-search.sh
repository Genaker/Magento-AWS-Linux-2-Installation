#!/bin/bash

yum -y install java htop

ELKREPO=${ELKREPO:="7.x"}

# By default Elasticsearch is only accessible on localhost. Set a different
# address here to expose this node on the network:
HOST_IP="0.0.0.0"
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

echo "discovery.type: single-node" >> /etc/elasticsearch/elasticsearch.yml
#echo "xpack.security.enabled: true" >> /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*cluster.name.*/cluster.name: magento/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*node.name.*/node.name: magento-node1/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*network.host.*/network.host: ${HOST_IP}/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*http.port.*/http.port: 9200/" /etc/elasticsearch/elasticsearch.yml
sed -i "s/.*-Xms.*/-Xms888m/" /etc/elasticsearch/jvm.options
sed -i "s/.*-Xmx.*/-Xmx888m/" /etc/elasticsearch/jvm.options
chown -R :elasticsearch /etc/elasticsearch/*

systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl restart elasticsearch.service
#/usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto

echo "ES Cluster Name : magento | Node: magento-node1 | Port: 9200 \n"

set +e
curl localhost:9200/
set -e
