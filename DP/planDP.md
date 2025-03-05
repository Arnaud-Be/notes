### 1 - Exploiter les éléments de l’infrastructure et assurer le support aux utilisateurs
1. Assurer le support utilisateur en centre de services
  - 

2. Exploiter des serveurs Windows et un domaine ActiveDirectory
Sur un Serveur Windows installé :
  - Créer des Groupes de Sécurités
  - Créer des Utilisateurs et les lier aux groupes
  - créer les disques réseaux et les partages
  - créer les mappages des disques
  - mettre en place des restriction d'horaires de travail
  - mettre en place des GPO 
   - politique de mot de passe
   - font d'écrans
  
3. Exploiter des serveurs Linux
  - installer une stack LAMP + glpi
  
4. Exploiter un réseau IP
Dans le cadre de la stack LAMP :
  - Règle de filtrage NAT sur pfsense et proxmox
  - vérifier le bon accès au site ainsi que les logs de la pfsense

### 2 - Maintenir l’infrastructure et contribuer à son évolution et à sa sécurisation
1. Maintenir des serveurs dans une infrastructure virtualisée
  - mettre en place des GPO 
   - politique de mot de passe
   - font d'écrans
  - ajouter des partage sur un serveur de fichier samba
2. Automatiser des tâches à l’aide de scripts
  - script d'installation docker + portainer + swarm + oSekour vable pour debian et ubuntu serveur (à voir avec Patrice)
  
3. Maintenir et sécuriser les accès à Internet et les interconnexions des réseaux
Sur pfsense
  - mise en place serveur VPN avec certificats clients pour les utilisateurs
  - mise en place d'un portail captif : squid
  - mise en place de Snort
  
4. Mettre en place, assurer et tester les sauvegardes et les restaurations des éléments de l’infrastructure
  - Proxmox Backup Server
5. Exploiter et maintenir les services de déploiement des postes de travail.
  - 

