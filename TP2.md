🔹 Niveau 1 – Découverte et manipulation de base (déjà fait sous Linux)

Adresse IP et Ping

Trouver son adresse IP avec l'invite de commande (cmd) et ipconfig /all

Donner l'adresse IP sur derveur DHCP

Faire un ping entre deux machines.

👉 Constater ce qui se passe quand on change de masque / mauvaise IP.

Faire un ping 1000 fois entre deux machines.


Wireshark – capture de trames

Lancer Wireshark, capturer un ping.

Identifier les adresses IP et MAC dans la capture.

Comparer "requête" et "réponse".
👉 Ça donne un côté espion amusant.

Table ARP

Lancer arp -a après un ping.

Expliquer simplement le lien IP ↔ MAC.

Faire effacer la table ARP et voir la différence.

🔹 Niveau 2 – Mise en place de services simples

Serveur web local

Lancer un petit serveur web Python : python3 -m http.server 8080

Accéder depuis un autre PC via http://IP:8080.
👉 vous voyez la notion de client ↔ serveur.

Partage de fichiers (netcat = nc)

Envoyer un fichier avec nc -l 1234 > recu.txt.

Recevoir avec nc IP 1234 < fichier.txt.
👉 Ils voient qu’on peut transférer sans clé USB.

DNS simplifié

Faire nslookup www.google.com.

Changer le DNS dans la config réseau (par ex. passer sur 1.1.1.1 ou 8.8.8.8).

Observer la différence si on met un DNS faux
