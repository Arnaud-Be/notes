### Installation de Windows Serveur 2022 

#### vm proxmox

<img src="./images/01-1.png" width=50%>

- Système d'exploitation :

> [!NOTE]
> Bien pense à cocher `Ajouter un périphérique` pour y insérer l'ISO des drivers VirtIO  

<img src="./images/01-2.png" width=50%>

- Système

<img src="./images/01-3.png" width=50%>

- Disques

> [!NOTE]
> En prévision des rôle j'ai ajouté un disque

<img src="./images/01-4.png" width=50%>

- Processeur

<img src="./images/01-5.png" width=50%>

- Mémoire

<img src="./images/01-6.png" width=50%>

- Réseau

> [!NOTE]
> Pour mon projet j'ai mis le serveur sur le LAN2 (carte vmbr3) 

<img src="./images/01-7.png" width=50%>

#### Installation de Windows Serveur

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










