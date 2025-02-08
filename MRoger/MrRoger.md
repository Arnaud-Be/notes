> Monsieur Roger, un photographe particulièrement stressé, t’a envoyé un email urgent :

    Bonjour,

    C’est la panique ! J’ai essayé de changer mon mot de passe et maintenant je ne peux plus accéder à mon ordinateur ! C’est vraiment problématique, j’ai des livraisons à faire et, en plus, mon réseau ne fonctionne plus… je ne sais plus quoi faire !

    Mes photos, elles sont toutes dans mon dossier « Images » et je dois absolument m’assurer qu’elles sont sauvegardées, c’est crucial !

    Je te demande de l’aide. Peux-tu, s’il te plaît, vérifier que tout est en ordre, créer un point de restauration au cas où, et t’assurer que je ne perds rien ? J’ai entendu parler de Recuva, tu pourrais peut-être l’utiliser pour récupérer ce qui a disparu ?

    Merci infiniment pour ton aide. Je suis vraiment à bout !

Ta mission est de calmer la situation et de diagnostiquer puis résoudre les problèmes rencontrés par Monsieur Roger en suivant ces étapes :

    Résoudre le problème de connexion (mot de passe),
    Réparer le périphérique réseau,
    Récupérer les images perdues avec Recuva,
    Ajouter l’historique de fichier pour le dossier « Images »,
    Créer un point de restauration.

#### Étape 1 : Incident : Résoudre le problème de connexion (mot de passe)

Boot sur Hiren's BootCD
![**Hiren's BootCD**](./images/00.png)

- Utilisation de **Windows Login Unlocker**

![**Hiren's BootCD**](./images/01-1.png)

- Suppression du mot de passe

![**Hiren's BootCD**](./images/01-2.png)
![**Hiren's BootCD**](./images/01-3.png)
> [!NOTE pour M Roger]
> Pour définir le mot de passe :
> Appuyer sur **CTRL + ALT + SUPPR**, puis cliquer sur **Modifier le mot de passe**

![**Hiren's BootCD**](./images/01-4.png)


> [!WARNING]
> On s'occupe tout de suite de l'étape 3 avec les outils de Hiren's BootCD

#### Étape 2 : Incident : Réparer le périphérique réseau



- Vérification de l'état de la carte réseau 
![**Réseau**](./images/02-1.png)

- Utilisation de l'outil de résolution de problèmes Windows
![**Réseau**](./images/02-2.png)

- Vérification du bon fonctionnement en faisant un ping de google.fr depuis une console CMD
![**Réseau**](./images/02-3.png)

> [!TIP]
> Autres possibilitées :
> - **Executer > ncpa.cpl** pour ouvrir les Connexions réseau, et activer la carte 
![**Réseau**](./images/02-4.png)
![**Réseau**](./images/02-5.png)
> - En console PowerShell Administrateur : 
```
Get-NetAdaptater
Enable-NetAdaptater -Name "Ethernet"
```
![**Réseau**](./images/02-7.png)
![**Réseau**](./images/02-8.png)


#### Étape 3 : Incident : Récupérer les images perdues avec Recuva

- Utilisation de Recuva pour récupérer des fichiers :
![**Recuva**](./images/03-1.png)
![**Recuva**](./images/03-2.png)
![**Recuva**](./images/03-3.png)

------
> [!WARNING]
> Pour les étapes 4 et 5 il serait bien d'installer un nouveau disque,
> ou de mettre en place une solution avec un disque dure extèrne ou un NAS.

#### Étape 4 : Demande : Ajouter l’historique de fichiers pour le dossier « Images »

- Ajout d'un nouveau disque : Activation et Formatage
![**HDD**](./images/04-1.png)
![**HDD**](./images/04-2.png)
![**HDD**](./images/04-3.png)

- Activation de l’historique de fichiers :
> aller dans	**Paramètres > Système > Stockage >> Afficher les options de sauvegarde**
> ou dans 	**Paramètres > Mise à jour et sécurité > Sauvegarde de fichiers**

![**Historique de fichiers**](./images/04-4.png)

> Ajouter un lecteur

![**Historique de fichiers**](./images/04-5.png)

> Selectionner les dossiers à sauvegarder et activer la sauvegarde

![**Historique de fichiers**](./images/04-6.png)

> [!NOTE pour M Roger]
> L'**Historique de fichiers** va permettre de sauvegarder régulièrement les dossiers sélectionnés.
> Pour les restaurer : Ouvrir l'**Explorateur de fichiers**

![**Restauration de fichiers**](./images/04-nr01.png)

> Selectionner **Ce PC**

![**Restauration de fichiers**](./images/04-nr02.png)

> Cliquer sur le petit *Chevron* à coté de **Ce PC** et sélectionner **Panneau de configuration**

![**Restauration de fichiers**](./images/04-nr03.png)

> Dans **Système et sécurité** cliquer sur **Enregistrer des copies de sauvegarde de vos fichiers...**

![**Restauration de fichiers**](./images/04-nr04.png)

> Selectionner **Restaurer des fichiers personnels**

![**Restauration de fichiers**](./images/04-nr05.png)

#### Étape 5 : Demande : Créer un point de restauration

- Création d’un point de restauration système :
> Dans **Paramètres** > **Système** > **À propos de** sélectionner **Paramètres avancés du système** > onglet **Protection du système** > **Créer...**

![**Restauration de fichiers**](./images/05-01.png)

#### Cloture de la réparation du PC de M Roger 

