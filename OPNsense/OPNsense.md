### OPNsense

- [OPNsense](https://opnsense.org/)
- [OPNsense - Download](https://opnsense.org/download/)
- [OPNsense - Starter guide](https://opnsense.org/users/get-started/)
- [OPNsense - Manuel](https://docs.opnsense.org/manual/hardware.html)

#### Création de la vm proxmox

1. Création d'une nouveau Bridge réseau vmbr4 qui sera utiliser pour conecter la machine OPNsense au réseau LAN

[!OPNs-creaVM](./images/vmbr-01-1.png)

2. Création de la vm
	
	* 1 cœur / 1 CPU
	* 2 Go de RAM
	* Bridge sur vmbr1

[!OPNs-creaVM](./images/vmbr-01-2.png)

3. Ajout d'une carte réseau, la vmbr4

[!OPNs-creaVM](./images/vmbr-01-3.png)

#### Installation

[!OPNs-INstallation](./images/install-00-0.png)

[!OPNs-INstallation](./images/install-00-1.png)

Pour la première connexion et l'installation

	* Login : **installer**
	* mot de passe : **opnsense**

> [!WARNING]
> le clavier est en QWERTY pour le moment

[!OPNs-INstallation](./images/install-00-2.png)

Choix du type d'action à effectuer. 
Selection de l'insr=tallation en utilisant UFS

[!OPNs-INstallation](./images/install-00-3.png)

[!OPNs-INstallation](./images/install-00-4.png)

Selection et préparation du disque.

[!OPNs-INstallation](./images/install-00-5.png)

[!OPNs-INstallation](./images/install-00-6.png)

[!OPNs-INstallation](./images/install-00-7.png)

[!OPNs-INstallation](./images/install-00-8.png)

Définition du mot de passe root

[!OPNs-INstallation](./images/install-00-9.png)

[!OPNs-INstallation](./images/install-00-10.png)

Reboot pour finaliser l'installation.

[!OPNs-INstallation](./images/install-00-11.png)

#### Configuration du réseau

OPNsense est maintenant installé mais pas encore connecté.

1. Assignation des interfaces réseau

[!OPNs-INstallation](./images/install-01-1.png)

On récupère les adresses MAC pour assigner les cartes sur le LAN et le WAN

[!OPNs-INstallation](./images/install-01-2.2.png)

[!OPNs-INstallation](./images/install-01-2.png)

	vmbr1 -> WAN -> em0
	
	vmbr4 -> LAN -> em1

[!OPNs-INstallation](./images/install-01-3.png)

2. Configuration des interfaces

[!OPNs-INstallation](./images/install-02-1.png)

	* WAN
		- Static
		- 192.168.42.111/24
		- passerelle : 192.168.42.1 (vmbr1)
		
		[!OPNs-INstallation](./images/install-02-2.png)
	
	* LAN
		- static
		- 10.0.0.1/16
		- pas de passerelle
		- activation du DHCP
		- plage de DHCP : 10.0.0.100 - 10.0.0.150
		
		[!OPNs-INstallation](./images/install-02-3.png)
		[!OPNs-INstallation](./images/install-02-4.png)

[!OPNs-INstallation](./images/install-03-1.png)

OPNsense est maintenant installer, on peut s'y connecter via le navigateur d'une machine sur le réseau.

[!OPNsense-webUI](./images/OPNsense-webUI.png)







