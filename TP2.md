** à rendre pour le dimanche 16 novembre 2025 à minuit (en pdf)**


#🔹 Niveau 1 – Découverte et manipulation de base avec Windows (déjà fait sous Linux)



## Adresse IP et Ping

1. Trouver son adresse IP (en IPv4 et en IPv6 et vérifier) avec l'invite de commande (cmd) et ipconfig /all

2. Donner l'adresse IP sur serveur DHCP (en IPv4 et en IPv6 et vérifier)

3. Faire un ping entre deux machines.

4. 👉 Constater ce qui se passe quand on change de masque / mauvaise IP.

5. Faire un ping 1000 fois entre deux machines.


## Wireshark – capture de trames - Ne pas faire -> au prochain semestre

1. Lancer Wireshark, capturer un ping.

2. Identifier les adresses IP et MAC dans la capture.

3. Comparer "requête" et "réponse".
	👉 Ça donne un côté espion amusant.

## Table ARP

1. Lancer arp -a après un ping.

2. Expliquer simplement le lien IP ↔ MAC.

3. Faire effacer la table ARP et voir la différence.

#🔹 Niveau 2 – Mise en place de services simples

## Serveur web local

1. Lancer un petit serveur web Python : python3 -m http.server 8080

2. Accéder depuis un autre PC via '''http://IP:8080'''.

	👉 vous voyez la notion de client ↔ serveur.

## Partage de fichiers (netcat = nc)

1. Envoyer un fichier avec nc -l 1234 > recu.txt.

2. Recevoir avec '''nc IP 1234 < fichier.txt'''.
	👉 vous voyez comment transférer sans clé USB.

## DNS simplifié

1. Faire nslookup www.google.com.

2. Changer le DNS dans la config réseau (par ex. passer sur 1.1.1.1 ou 8.8.8.8).

3. Observer la différence si on met un DNS faux
