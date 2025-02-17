#### OPNsense OpenVPN

1. Création des Certificats.
	* Création d'une autorité : `System > Trust > Authorities`
		- Methode : internal Certificate Authority
		- Description : **CA-OPNsense**
		- issuer : Self-signed
		- Common Name : **CA-OPNsense**
		
		Save
		
	* Création d'un certificat : `System > Trust > Certificates`
		- Methode : Create an internal Certificate
		- Descriptive name : **Server-Cert**
		- Type : Server Certificate
		- issuer : **CA-OPNsense**
		- Common Name : **Server-Cert**
		Save
		
	* Création d'un utilisateur : `System > Acces > Users`
	
	* Création du certificat client pour notre utilisateur : `System > Trust > Certificates`
		- Methode : Create an internal Certificate
		- Descriptive name : **arnaud-CA**
		- Type : Client Certificate
		- issuer : **CA-OPNsense**
		- Common Name : **arnaud-CA**
		Save
		
2. Création du serveur de réseau virtuel

> [!NOTE]
> - LAN : 10.0.0.0 / 16
> - Tunnel VPN : 10.42.42.0/24

	* Création d'une clé statique : `VPN > OpenVPN > instances / onglet Static Keys`
		- Description : **arnaud_auth**
		- Mode : auth
		- click sur la roue dentelé pour créer la clé
		Save

	* Création d'un nouveau serveur : `VPN > OpenVPN > instances / onglet instances`
		- Role : Server
		- Description : **OPNsense-VPNserver**
		- Protocol : UDP (IPv4)
		- Port number : 11194  _(normalement c'est le port 1194, mais ce port étant déjà utilisé avec la pfSense, pour éviter les conflit de NAT sur proxmox on utilisera le 11194)_
		- Type : TUN
		- Server (IPv4) : 10.42.42.24/24
		- Certificate : **Server-Cert**
		- TLS static key : [auth ..] arnaud_auth
		- Local Network : 10.0.0.0/16
		Save

> [!WARNING]
> Ne pas oublier de cliquer sur **Apply**

	* Assignation de l'interface vpn : `Interfaces > Assignments`

3. Création des règles de pare-feu : `Firewall > Rules > WAN`

	* Autorise le client à se connecter au serveur : 
		- Action : Pass
		- Interface : WAN
		- TCP/IP Version : IPv4
		- Protocol : UDP
		- source : any
		- Destination : WAN address
		- Destination port range 
			Other
			11194 / 11194
		Save
	
	* Autorise le client à se connecter au sous réseau : 
		- Action : Pass
		- Interface : OpenVPN
		- TCP/IP Version : IPv4
		- Protocol : any
		- source : OpenVPN net
		- Destination : any
		- Destination port range 
			any / any
			
		Save

	> [!WARNING]
	> Appliquer les changement en cliquant sur **Apply changes**
	
4. Exportation du certificat client : `VPN > OpenVPN > Client Export`
		- Type : File Only
		- Hostname : *adressse proxmox*
		- Port : 11194
		Exporter arnaud-CA (le certificat client)

5. Création de la règle NAT sur le proxmox 
	au niveau du nœud (nsXXXXXX) `>_Shell`
	```
	iptables -t nat -A PREROUTING -p udp --dport 11194 -j DNAT --to-destination <IP de l'OPNsense>:11194
	```
	
	> [!NOTE]
	> Remplacer **<IP de l'OPNsense>** 
	
6. Utiliser le certificat client pour créer une connexion vpn avec votre OPNsense

**ENJOY**

> [!NOTE]
> Beaucoup de déconnexions comme si la connexion au vpn ne tenait pas !!!


	
