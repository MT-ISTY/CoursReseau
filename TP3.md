# Programmation réseau avec Python3
Dans ce TP, vous allez devoir implémenter des serveurs et des clients utilisant un protocole
réseaux : TCP. Ce protocole est situé au niveau de la couche 4 du modèle OSI : la couche transport.
Nous utiliserons IP pour la couche 3 (couche réseau) et, la plupart du temps, Ethernet pour la couche 2 (liaison de données). Ainsi que le protocole applicatif HTTP, couche 7 Application.

# Le protocole UDP
Le protocole UDP est un protocole simple et non-fiable. Il fonctionne en mode non-connecté
et les messages envoyés ne sont pas acquittés (ce qui signifie que le récepteur n’envoie pas automatiquement de message pour indiquer qu’il a bien reçu). Ce protocole ne garantie pas à l’émetteur d’un message que le destinataire l’a bien reçu, ni que celui-ci n’a pas été altéré.
L’absence de phase de connexion permet à l’émetteur de commencer l’envoi de ses données dès
le premier paquet (en TCP, nous verrons que l’établissement de la connexion suppose l’échange de plusieurs messages, ce qui demande du temps).
Le protocole UDP est donc léger et efficace, et se limite essentiellement à introduire la notion de port à IP : le numéro de port permettra de distinguer le processus (ou service) destinataire du paquet. UDP est en général utilisé par les applications qui privilégient la performance à la fiabilité : par exemple, des applications multimédia qui peuvent se permettre de perdre des paquets (qu’il ne vaut pas la peine de retransmettre puisque de toutes façons ils arriveraient trop tard : Visio, Vidéo, son). UDP utilise donc un système d’adressage sur la machine permettant à une machine donnée d’être impliquée dans plusieurs communications sans les mélanger : ce sont les ports réseau.

# Comment faire une connexion avec Python3
## Les sockets :
Une socket est un point terminal sur le réseau. C’est la structure de donnée qui permet de
communiquer sur le réseau.
Lorsque l’on écrit un programme communiquant sur le réseau, on manipule des sockets pour
établir ou fermer les connexions dans les cas des protocoles connectés, envoyer et recevoir des données sur le réseau.
Programmation réseau sur les sockets :
En Python, les fonctions associées aux sockets sont fournies dans le module socket. Vous
devez donc, en premier lieu, importer ce module.
Votre script Python devra commencer par :

    #!/usr/bin/env python3
    import socket

# Programmation client-serveur
Nous avons vu que le protocole UDP fonctionne, en mode non connecté :
La socket à ouvrir pour une communication UDP est de type « SOCK_DGRAM ».
    serveur = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
Voici un exemple de programme serveur « simpleUDPServeur.py » qui ouvre un socket UDP et l’associe au port de votre choix (ici 3000) : 
    #!/usr/bin/env python3
    import socket
    serveur = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    # permet de libérer le PORT après un CTRL + C
    serveur.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    serveur.bind(('localhost', 3000)) # Utilise le port réseau 3000
    print("Serveur UDP en écoute sur 3000\n")
    while True :
        # utilisation de recvfrom pour récupérer le tuple address
	request, address = serveur.recvfrom(1024)
	print("Message client : ", request.decode("utf-8"))
	print("IP du client connecté : ", address)
	serveur.sendto(b"i am the server", address)
    serveur.close()

