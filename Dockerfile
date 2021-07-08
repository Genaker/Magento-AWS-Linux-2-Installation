FROM centos:8 as centosd

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

# CMD ["/usr/sbin/init"]

FROM centosd

COPY ./install-prepare.sh /scripts/
RUN ls && chmod +x /scripts/install-prepare.sh && \
bash /scripts/install-prepare.sh; \
cd ~ && \
wget https://github.com/Genaker/Magento-AWS-Linux-2-Installation/archive/refs/heads/master.zip && \
unzip master.zip && cd ./Magento-AWS-Linux-2-Installation-master/; \
echo "Install Redis \n"; \
bash ./install-redis-compile.sh ; \
yum clean all && \
rm -rf /var/cache/yum

RUN set -x; \
cd ~; \
cd ./Magento-AWS-Linux-2-Installation-master/; \
ls; \
echo "Installing Utilities \n"; \
bash ./install-prepare.sh; \ 
echo "Install PHP \n"; \
bash ./install-php.sh; \
bash ./configure-php.sh; \
# bash ./install-tideways-profiler.sh
set +e; \
bash ./install-composer.sh; \
composer clear-cache; \
set -e; \
echo "Install NGINX \n"; \
bash ./install-nginx.sh; \
echo "Configure Nginx \n"; \
set +e; \
bash ./configure-nginx.sh; \
set -e; 
RUN echo "Install MYSQL/MARIA DB \n"; \
cd ~; \
cd ./Magento-AWS-Linux-2-Installation-master/; \
bash /usr/sbin/init; \
bash ./install-mariadb-repo.sh; \
echo "Install Elastic Search \n"; \
bash ./install-elastic-search.sh; \
echo "Install Magento Git \n"; \
mkdir -p /var/www/html/magento/; \
echo "We are not instaling magento for now"; \
yum clean all && \
rm -rf /var/cache/yum; \
#bash ./install-monorepo-git.sh; 
export IP=127.0.0.1; \
set +e; \
bash ./install-magento-git.sh; \
set -e; 
ENV DOCKER=YES
EXPOSE 80 443 3306 6379

# VOLUME ["/var/www/html/magento"]
# VOLUME ["/var/www/html/magento/pub/media"]

ENTRYPOINT ["/usr/sbin/init"]
