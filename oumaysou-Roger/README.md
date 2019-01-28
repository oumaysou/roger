#oumaysou 
#RogerSkyline

## Partie Réseau et Sécurité

> Vous devez créer un utilisateur non root pour vous connecter et travailler.

adduser username

> Utilisez sudo pour pouvoir, depuis cet utilisateur, effectuer les operations demandant des droits speciaux.

adduser username sudo

> Nous ne voulons pas que vous utilisiez le service DHCP de votre machine. A vous donc de la configurer afin qu’elle ait une IP fixe et un Netmask en /30.

Mettre une interface bridge. Configurer les IP avec le fichier /etc/network/interfaces, le netmask /30 limite les IP disponibles

> Vous devez changer le port par defaut du service SSH par celui de votre choix. L’accès SSH DOIT se faire avec des publickeys. L’utilisateur root ne doit pas pouvoir se connecter en SSH.

utiliser ssh-keygen et ssh-copy-id pour créer une clé côté client et la push sur le serveur. changer le port dans /etc/ssh/sshd_config

> Vous devez mettre en place des règles de pare-feu (firewall) sur le serveur avec uniquement les services utilisés accessible en dehors de la VM.

il faut voir du côté de iptables en autorisant les ports ssh, 80 et 443 pour le web http et https

> Vous devez mettre en place une protection contre les DOS (Denial Of Service Attack) sur les ports ouverts de votre VM.

J'ai installé le package ddos...

> Vous devez mettre en place une protection contre les scans sur les ports ouverts de votre VM.

J'ai ajouté une règle iptable qui banni les ip après un scan.

> Arretez les services dont vous n’avez pas besoin pour ce projet.

Je ne garde que les services essentiels trouvés avec 'sudo service --status-all' et je coupe les autres avec 'sudo systemctl stop monservice'

> Réalisez un script qui met à jour l’ensemble des sources de package, puis de vos packages et qui log l’ensemble dans un fichier nommé /var/log/update_script.log. Créez une tache plannifiée pour ce script une fois par semaine à 4h00 du matin et à chaque reboot de la machine.


Je crée un script update_script.sh contenant apt update && apt upgrade et je le mv dans /root/scripts/update_script.sh
J'execute sudo crontab -e et j'ajoute la ligne 00 4 * * 1 /root/scripts/update_script.sh pour le démarrer le premier jour de la semaine à 4h00. Maintenant j'ajoute le script au démarrage de la machine.

> Réalisez un script qui permet de surveiller les modifications du fichier /etc/crontab et envoie un mail à root si celui-ci a été modifié. Créez une tache plannifiée pour script tous les jours à minuit.

Je crée un fichier check_crontab.sh utilisant md5sum pour comparer le fichier crontab à la dernière vérification de celui-ci. Installation de mailutils  pour envoyer le mail et j'ajoute tout cela en tache cron.
