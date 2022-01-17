#!/bin/bash
set -x
set +e
curl -fsSL https://get.docker.com -o get-docker.sh 
sudo sh get-docker.sh || (sudo amazon-linux-extras install docker && sudo yum install docker -y && sudo usermod -a -G docker ec2-user) 

LINUX_VERSION=$(cat /etc/system-release)
echo $LINUX_VERSION

if echo $LINUX_VERSION | grep -q "Oracle Linux Server release 8"
then
  sudo yum -y remove podman
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install docker-ce docker-ce-cli containerd.io
 
fi

sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock

# Issue is ip table is not installed
yum install iptables-services -y

sudo service docker start
sudo systemctl enable docker.service

## Doesn't work on ARM linuxes
# sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
#sudo chmod +x /usr/local/bin/docker-compose
#sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install Compose using Docker container

python3 -V
sudo curl -L --fail https://raw.githubusercontent.com/linuxserver/docker-docker-compose/master/run.sh -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose



# Test Docker Compose
/usr/local/bin/docker-compose --version

sudo chmod 666 /var/run/docker.sock

set +x
set -e
