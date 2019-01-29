# Vider toutes les règles déjà existantes
sudo iptables -t nat -F
sudo iptables -t nat -X

## On bloque toutes autres paquets
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
#iptables -P FORWARD DROP

# On autorise les connexions déjà établie
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

## Loopback
sudo iptables -I INPUT -i lo -j ACCEPT
sudo iptables -I OUTPUT -o lo -j ACCEPT



## On bloque toutes ip ayant essayer une attaque SYN et on met à jour la
## liste et l'attaque et de nouveau ban pour 15 secondes
sudo iptables -A FORWARD -m recent --name Attaque_Syn -j LOG --log-prefix="Ip_Banned"
sudo iptables -A FORWARD -m recent --name Attaque_Syn --update --seconds 15 -j DROP

## Création de la chaine Syn_Flood qui rajoute l'IP à la liste Attaque_Syn
## et reset de la connexion '"--reject-with tcp-reset
sudo iptables -N Syn_FLood
sudo iptables -A SYn_FLood -m recent --set -name Attaque_Syn -p tcp -j REJECT --reject-with tcp-reset

## Routeur + NAT
sudo iptables -t nat -I POSTROUTING -o eth0 -s 10.0.0.0/24 -j SNAT --to-source 192.168.1.14

## Création de la chaine TesT_Scan et redirection des paquets vers cette ## chaine
sudo iptables -N Test_Scan
sudo iptables -A FORWARD -p tcp -j Test_Scan

## On redirige vers la chaine Syn_Flood si l'on detecte un scan de port
sudo iptables -A Test_Scan -p tcp --tcp-flags ALL SYN -i eth1 -o eth0 -m limit --limit 20/s -j ACCEPT
sudo iptables -A Test_Scan -m state --state NEW -p tcp --tcp-flags ALL SYN -i eth1 -o eth0 -m limit --limit 5/minute -j LOG --log-prefix="SYn_FLood"
sudo iptables -A Test_Scan -m state --state NEW -p tcp --tcp-flags ALL SYN -i eth1 -o eth0 -j Syn_FLood

# Pour ques les chqngement perrsistent
sudo mv firewall.sh /etc/init.d
sudo chmod +x firewall.sh
# Lancer qu démarrage
sudo update-rc.d firewall.sh defaults