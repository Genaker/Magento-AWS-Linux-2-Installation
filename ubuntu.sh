sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
deb https://nginx.org/packages/ubuntu/ xenial nginx
sudo -s

sudo apt-get update && sudo apt-get install -y --no-install-recommends locales software-properties-common 
&& sudo locale-gen en_US.UTF-8 && sudo apt install nginx && sudo apt-get update 
&& sudo apt-get install -y nginx curl zip unzip git wget supervisor sqlite3    pv cifs-utils mcrypt bash-completion ca-certificates openssl perl acl 
&& sudo add-apt-repository -y ppa:ondrej/php && sudo apt-get update && sudo add-apt-repository -y universe
&& sudo apt install certbot python3-certbot-apache && sudo ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
&& sudo apt-get update && sudo apt-get install -y php7.4-fpm php7.4-cli php7.4-gd php7.4-mysql    php7.4-pgsql php7.4-imap php7.4-mbstring php7.4-xml php7.4-curl    php7.4-sqlite3 php7.4-zip php7.4-bcmath php7.4-soap php7.4-redis php7.4    php7.4-intl php7.4-readline 
&& sudo php -r "readfile('http://getcomposer.org/installer');" | sudo php -- --install-dir=/usr/bin/ --filename=composer && sudo wget https://dev.mysql.com/get/mysql-apt-config_0.8.14-1_all.deb
&& sudo dpkg -i mysql-apt-config_0.8.14-1_all.deb && sudo apt-get update && sudo apt-get dist-upgrade -y 
&& sudo apt-get install -y gnupg mysql-server openjdk-8-jdk jpegoptim optipng && sudo mysql_secure_installation 
&& rm -f mysql-apt-config_0.8.14-1_all.deb && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - 
&& sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" > /etc/apt/sources.list.d/elastic-6.x.list'
&& sudo apt-get update && sudo apt-get install -y elasticsearch
&& sudo systemctl enable elasticsearch.service&& sudo systemctl start elasticsearch.service 
&& curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - 
&& sudo apt-get install -y nodejs && sudo apt-get update && sudo apt-get upgrade -y 
&& sudo apt-get remove -y --purge software-properties-common && sudo apt-get autoremove -y
&& sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


