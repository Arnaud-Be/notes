### Installation de zabbix sur CT debian12

#### 1 Installation de Zabbix 

- [Zabbix](https://www.zabbix.com/fr/download)
> [!NOTE]
> Sur le site de Zabbix, selectionner la Version, la Distribution, l'OS, les composants Zabbix, le base de données et le serveur web.


```
wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb
sudo dpkg -i zabbix-release_latest_7.2+debian12_all.deb
sudo apt update

sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
```
> [!WARNING]
> Installer la base de donnée

#### 2 Installation de Mariadb

```
sudo apt install mariadb-server

sudo mysql_secure_installation

   Enter current password for root (enter for none): 
   Switch to unix_socket authentication [Y/n] Y
   Change the root password? [Y/n] Y
   New password:
   Re-enter new password:
   Password updated successfully!
   Remove anonymous users? [Y/n] Y
   Disallow root login remotely? [Y/n] Y
   Remove test database and access to it? [Y/n] Y
   Reload privilege tables now? [Y/n] Y
```

- Création de la base de données et de l'utilisateur

```
mysql -u root -p
```
> [!WARNING]
> Les commandes suivantes sont à entrer dans un terminal sous `MariaDB [(none)]>`
> et changer `MotDePasseUtilisateurZabbix` par votre mot de passe
```
create database zabbix character set utf8mb4 collate utf8mb4_bin;
create user zabbix@localhost identified by 'MotDePasseUtilisateurZabbix';
grant all privileges on zabbix.* to zabbix@localhost;
set global log_bin_trust_function_creators = 1;
quit;
```

- on verifie le status de Mariadb

```
systemctl status mariadb.service
```

#### 3 Installation adminer

```
sudo apt install adminer
sudo a2enconf adminer
sudo systemctl reload apache2
```

#### 4 Configuration Zabbix

- Configuration des locales

```
sudo dpkg-reconfigure locales
```
> [!NOTE]
> Sélectionner les `fr_FR` et `en_US`

<img src="./images/10.png" width=50%>
<img src="./images/11.png" width=50%>

- Importation de la bd zabbix

```
sudo zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | sudo mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
```

- Désactivation de `log_bin_trust_function_creators`

```
mysql -u root -p
```
> [!WARNING]
> Les commandes suivantes sont à entrer dans un terminal sous `MariaDB [(none)]>`
```
set global log_bin_trust_function_creators = 0;
quit;
```

- Configuration du mot de passe pour la base de données zabbix
```
sudo vim /etc/zabbix/zabbix_server.conf 
```
Modifier la ligne `# DBPassword= ` par `DBPassword=MotDePasseUtilisateurZabbix`

- Redémarrage de Zabbix et Apache

```
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2
```



> [!note]
> première connextion Zabbix
> http://AdressIp/zabbix/
> [ Admin / zabbix ]

