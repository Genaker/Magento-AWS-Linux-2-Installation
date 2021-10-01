#!/bin/bash

mkdir -p /tmp/python
cd /tmp/python

sudo yum install gcc openssl-devel bzip2-devel libffi-devel 

wget https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tar.
sudo tar xvf Python-3.9.7.tar.xz 
cd Python-3.9.7/  

sudo ./configure --enable-optimizations
sudo make altinstall

python3.9 -V 

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
source $HOME/.poetry/env
