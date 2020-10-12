# ideo of this repo is not to use Docker for the basic functionality 'php,nginx,redis'. Ide is to be close to the corre and don't use aditional level of complexity and bugs 

sudo yum install docker -y
sudo service docker start
sudo systemctl enable docker

sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

docker pull php:7.3

#connect to the docker 
docker run -it --net=host  php:7.3 bash

# inside of the docker 
apt-get update -y
apt install nano -y
