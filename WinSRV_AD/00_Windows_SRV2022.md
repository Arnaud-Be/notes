### Installation de Windows Serveur 2022 

#### vm proxmox

![vmproxmox](./images/01-1.png)

- Système d'exploitation :

> [!NOTE]
> Bien pense à cocher `Ajouter un périphérique` pour y insérer l'ISO des drivers VirtIO  

![vmproxmox](./images/01-2.png)

- Système

![vmproxmox](./images/01-3.png)

- Disques

> [!NOTE]
> En prévision des rôle j'ai ajouté un disque

![vmproxmox](./images/01-4.png)

- Processeur

![vmproxmox](./images/01-5.png)

- Mémoire

![vmproxmox](./images/01-6.png)

- Réseau

> [!NOTE]
> Pour mon projet j'ai mis le serveur sur le LAN2 (carte vmbr3) 

![vmproxmox](./images/01-7.png)

#### Installation de Windows Serveur

- Démarrage bien penser à activer la console Proxmox pour "Appuyer sur une touche"

![vmproxmox](./images/02-1.png)

- Choix du système d'exploitation 

> [!NOTE]
> `Avec Experience de bureau` si on veut un serveur avec une interface Windows
> Sinon sans ce sera un serveur dit `Nano` à gérer à distance soit en SSH soit avec WAC ([Windows Admin Center][https://www.microsoft.com/en-ca/windows-server/windows-admin-center])

![vmproxmox](./images/02-3.png)

- Pilote 

> [!NOTE]
> Ajouter les piotes VirtIO pour les disques (**vioscsi**) et la carte réseau (**NetKVM**)

![vmproxmox](./images/02-4.png) ![vmproxmox](./images/02-5.png)







