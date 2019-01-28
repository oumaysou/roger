sudo sh resources/ddos.sh
sudo sh ./firewall.sh
sudo cp resources/interfaces /etc/network/interfaces
sudo echo "Port 5432" >> /etc/ssh/sshd_config
sudo service ssh restart
sudo service networking restart
#sudo iptables-restore < resources/iptables
#sudo iptables-save > /etc/iptables/rules.v4
#sudo ip6tables-save > /etc/iptables/rules.v6
sudo service iptables-persistent start
sudo mkdir /root/scripts
sudo cp resources/update_script.sh /root/scripts/
sudo cp resources/check_crontab.sh /root/scripts/
sudo crontab resources/crontab.bak
sudo cp resources/html/* /var/www/html
sudo cd /var/
#Creation du dossier cerfs ou mettre le certificat SSL
sudo mkdir cerfs
sudo openssl genrsa -des3 -out server.key 1024
sudo openssl req -new -key server.key -out server.csr
#Création d'un backup
sudo cp server.key server.key.org
#Signer le certificat
sudo openssl rsa -in server.key.org -out server.key
sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
#Activer SSL
sudo a2enmod ssl
#Redemarrer apache2
sudo a2enmod ssl
