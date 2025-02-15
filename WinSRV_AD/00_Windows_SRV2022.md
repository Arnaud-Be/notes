### Installation de Windows Serveur 2022 

> [!NOTE]
> #### La Machine Virtuelle Proxmox :
> 1. Iso Windows Serveur + Iso virtio-win pour les drivers
> 2. 2 Disque de 200 Go SCSI / Write back
> 3. 2 Supports de Processeur / 4 Cœurs de type host
> 4. 8192 Mib de RAM

- Démarrage bien penser à activer la console Proxmox pour "Appuyer sur une touche"

<img src="./images/02-1.png" width=50%>

- Choix du système d'exploitation 

> [!NOTE]
> Avec `Experience de bureau` si on veut un serveur avec une interface Windows.
> 
> Sinon sans ce sera un serveur dit `Nano` à gérer à distance soit en SSH soit avec WAC ([Windows Admin Center](https://www.microsoft.com/en-ca/windows-server/windows-admin-center))

<img src="./images/02-3.png" width=50%>

- Pilotes

> [!NOTE]
> Ajouter les pilotes VirtIO pour les disques (**vioscsi**) et la carte réseau (**NetKVM**)

![vmproxmox](./images/02-4.png) ![vmproxmox](./images/02-5.png)

#### Premier démarrage :

1. Insatallation des Drivers Virtuo :
![vmproxmox](./images/03-1.png)

2. Paramètrage de la carte réseau : Utilisation d'une adresse static (indispensable pour certains rôles de l'AD)
	* Adresse : 10.111.0.15
	* Masque : 255.255.0.0
	* Passerelle : 10.111.0.1 (pfsense)
	* DNS : 10.111.0.1 (pfsense)
	
![vmproxmox](./images/03-2.png)

> [!NOTE]
> Lancer le **Gestionnaire de serveur** qui permettra de configurer et gérer le serveur ainsi que les les autres serveurs rattacher à cette forêt.
> 
> ![vmproxmox](./images/03-3.png)

3. Changement du nom de l'ordinateur 

![vmproxmox](./images/03-4.png)

On peut redémarrer le serveur, il est pret pour commencer à installer nos **Rôles**.
---------







