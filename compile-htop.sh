#!bin/bash

yum groupinstall "Development Tools" -y
yum install ncurses ncurses-devel -y
wget https://github.com/htop-dev/htop/archive/refs/tags/3.0.5.tar.gz
tar xvfvz 3.0.5.tar.gz
cd htop-3.0.5

./autogen.sh && ./configure && make
make install
