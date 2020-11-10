

cd /tmp
git clone https://github.com/mariadb-corporation/MaxScale
mkdir build
cd build
../MaxScale/BUILD/install_build_deps.sh
cmake ../MaxScale -DCMAKE_INSTALL_PREFIX=/usr
make

sudo make install

sudo systemctl enable maxscale.service

sudo service maxscale start

##TEST connection 

mysql -h localhost -P 4306 -u newuser -ppassword -e "SHOW VARIABLES LIKE \"%version%\";"



