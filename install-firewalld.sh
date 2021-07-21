#!\bin\bash
sudo yum install firewalld -y 
sudo service firewalld start
sudo systemctl enable firewalld
sudo firewall-cmd --zone=public --permanent --remove-port=3306/tcp
