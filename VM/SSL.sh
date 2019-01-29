#Creation du dossier cerfs ou mettre le certificat SSL
sudo mkdir cerfs && cd cerfs
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
