FROM centos:8
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

COPY ./install-prepare.sh /scripts/
RUN ls && chmod +x /scripts/install-prepare.sh && \
bash /scripts/install-prepare.sh $$ \
wget https://github.com/Genaker/Magento-AWS-Linux-2-Installation/archive/refs/heads/master.zip && \
unzip master.zip && cd ./Magento-AWS-Linux-2-Installation-master/ && \
sudo bash ./install-all.sh

EXPOSE 80 443

# VOLUME ["/var/www/html/magento"]
# VOLUME ["/var/www/html/magento/pub/media"]

ENTRYPOINT ["/usr/sbin/init"]
