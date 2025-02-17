### OPNsense

- [OPNsense](https://opnsense.org/)
- [OPNsense - Download](https://opnsense.org/download/)
- [OPNsense - Starter guide](https://opnsense.org/users/get-started/)
- [OPNsense - Manuel](https://docs.opnsense.org/manual/hardware.html)

#### Création de la vm proxmox

1. Création d'une nouveau Bridge réseau vmbr4 qui sera utiliser pour connecter la machine OPNsense au réseau LAN

<img src="./images/vmbr-01-1.png" width=50%>

2. Création de la vm
	
  * 1 cœur / 1 CPU
  * 2 Go de RAM
  * Bridge sur vmbr1

<img src="./images/vmbr-01-2.png" width=50%>

3. Ajout d'une carte réseau, la vmbr4

<img src="./images/vmbr-01-3.png" width=50%>

#### Installation

<img src="./images/install-00-0.png" width=50%>

<img src="./images/install-00-1.png" width=50%>

Pour la première connexion et l'installation

  * Login : **installer**
  * mot de passe : **opnsense**

> [!WARNING]
> le clavier est en **QWERTY** pour le moment

<img src="./images/install-00-2.png" width=50%>

Choix du type d'action à effectuer. 
Sélection de l'installation en utilisant UFS

<img src="./images/install-00-3.png">

<img src="./images/install-00-4.png">

Sélection et préparation du disque.

<img src="./images/install-00-5.png">

<img src="./images/install-00-6.png">

<img src="./images/install-00-7.png">

<img src="./images/install-00-8.png">

Définition du mot de passe root

<img src="./images/install-00-9.png">

<img src="./images/install-00-10.png">

Reboot pour finaliser l'installation.

<img src="./images/install-00-11.png">

#### Configuration du réseau

OPNsense est maintenant installé mais pas encore connecté.

1. Assignation des interfaces réseau

<img src="./images/install-01-1.png" width=50%>

On récupère les adresses MAC pour assigner les cartes sur le LAN et le WAN

<img src="./images/install-01-2.2.png" width=50%>

<img src="./images/install-01-2.png" width=50%>

  * vmbr1 -> WAN -> em0
  * vmbr4 -> LAN -> em1

<img src="./images/install-01-3.png" width=50%>

2. Configuration des interfaces

<img src="./images/install-02-1.png" width=50%>

  * WAN
	- Static
	- 192.168.42.111/24
	- passerelle : 192.168.42.1 (vmbr1)
		
<img src="./images/install-02-2.png" width=50%>

  * LAN
	- Static
	- 10.0.0.1/16
	- pas de passerelle
	- activation du DHCP
	- plage de DHCP : 10.0.0.100 - 10.0.0.150

<img src="./images/install-02-3.png" width=50%>

<img src="./images/install-02-4.png" width=50%>

<img src="./images/install-03-1.png" width=50%>

OPNsense est maintenant installer, on peut s'y connecter via le navigateur d'une machine sur le réseau.

<img src="./images/OPNsense-webUI.png" width=50%>







