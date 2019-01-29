sh resources/ddos.sh
sh resources/firewall.sh
cp resources/interfaces /etc/network/interfaces
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

