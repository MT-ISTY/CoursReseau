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

## Programmation du serveur UDP

Voici un exemple de programme **serveur** « simpleUDPServeur.py » qui ouvre un socket UDP et l’associe au port de votre choix (ici 3000) : 

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

Nous avons maintenant un mini serveur qui accepte les connexions UDP sur le PORT 3000 et afficher dans la console l’IP du client qui s’y connecte.

Tester : Enregistrez ce fichier dans votre VM Linux et exécutez le dans un terminal via la commande :
    
    ~$ python3 ./simpleUDPServeur.py
    
Le serveur affiche : « Serveur UDP en écoute sur 3000 » et attend des messages d’un client (boucle infinie : while True)
Pour tester, vous pouvez utiliser la commande linux « netcat -u localhost 3000 »
Ensuite tapez un mot et faites « Entrée » le serveur affichera votre chaîne de caractères et l’IP de votre poste client et répondra sur la console du client « i am the server »

## Programmation du client UDP
Pour envoyer des messages au serveur UDP, nous devons définir un « tuple » que l’on appelle **addrPort** et qui contient l’IP du serveur et le Port réseau sur lequel il écoute.

    addrPort = ("127.0.0.1", 3000)
    
Puis, nous créons un « socket » client de type UDP, comme pour le serveur, avec le type SOCK_DGRAM

    client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    
Enfin, il suffit d’envoyer des messages au serveur, via notre variable « addrPort » et la fonction « sendto(…) » sans avoir à réaliser une connexion, puisque UDP est en mode déconnecté :

    client.sendto(b"Hello from client", addrPort)
    
On peut également attendre une réponse du serveur via la fonction « recv(1024) » que l’on décode en « utf-8 », car les données transitent au format « bytes » sur le socket, puis on affiche le msg du serveur dans la console :

    msgServer = client.recv(1024).decode('utf-8')
    print("Message du serveur : ", msgServer)
    
Pour terminer, on ferme le « socket » client que l’on a ouvert au début :

    client.close()
    
Voici le code complet de notre client UDP « simpleUDPclient.py » :

    #!/usr/bin/env python3
    import socket
    addrPort = ("127.0.0.1", 3000)
    client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    client.sendto(b"Hello from client", addrPort)
    msgServer = client.recv(1024).decode('utf-8')
    print("Message du serveur : ", msgServer)
    client.close()
    
## Echo UDP (latences et pertes)
### Serveur UDP (echo)
Enregistre udp_server.py :

    # udp_server.py
    import socket

    HOST = "0.0.0.0"
    PORT = 9999
    BUF  = 4096

    def main():
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.bind((HOST, PORT))
        print(f"[UDP] Echo server on {HOST}:{PORT} (Ctrl+C pour quitter)")
        try:
            while True:
                data, addr = sock.recvfrom(BUF)
                # Echo immédiat
                sock.sendto(data, addr)
        except KeyboardInterrupt:
            print("\n[UDP] Stop")
        finally:
            sock.close()

    if __name__ == "__main__":
        main()
        
Exécute ce programme....  

### Serveur UDP (echo)
Enregistre udp_client.py :

    # udp_client.py
    import socket, time, statistics, os

    SERVER = ("127.0.0.1", 9999)  # changer IP si serveur distant
    COUNT  = 50
    TIMEOUT = 1.0
    PAYLOAD = b"x" * 32  # taille applicative (modifie pour tester)

    def main():
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.settimeout(TIMEOUT)
        rtts = []
        lost = 0

        for seq in range(1, COUNT+1):
            t0 = time.perf_counter()
            msg = seq.to_bytes(4, "big") + t0.hex().encode() + b"|" + PAYLOAD
            try:
                sock.sendto(msg, SERVER)
                data, _ = sock.recvfrom(4096)
                t1 = time.perf_counter()
                rtt_ms = (t1 - t0) * 1000
                rtts.append(rtt_ms)
                print(f"#{seq:03d} RTT = {rtt_ms:.2f} ms, len={len(data)}")
            except socket.timeout:
                lost += 1
                print(f"#{seq:03d} *** PERDU ***")

        sock.close()
        if rtts:
            print("\n--- Statistiques UDP ---")
            print(f"Envoyés: {COUNT}, Reçus: {COUNT-lost}, Pertes: {lost} ({100*lost/COUNT:.1f}%)")
            print(f"RTT min/avg/max = {min(rtts):.2f}/{statistics.mean(rtts):.2f}/{max(rtts):.2f} ms")

    if __name__ == "__main__":
        main()

Exécute ce programme....  

***À mesurer/observer :***

1. RTT* min/moy/max, taux de pertes (essayez de changer PAYLOAD et COUNT).

2. Couper temporairement le serveur pour provoquer des pertes : comportement de l’appli ?

_* Le RTT (Round Trip Time) est le temps total nécessaire pour qu’un paquet fasse l’aller-retour entre l’émetteur et le destinataire._
_Autrement dit :_
_RTT = temps d’envoi (aller) + temps de réponse (retour)_
_C’est une mesure du délai de communication entre deux machines._
