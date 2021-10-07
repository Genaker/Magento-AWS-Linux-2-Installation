#!/bin/magento/

ELASTIC_VERSION='7.13.2'

echo "Install Elastic SEARCH Docker"

docker run -d --restart unless-stopped -p 9200:9200 -p 9300:9300  -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:$ELASTIC_VERSION

