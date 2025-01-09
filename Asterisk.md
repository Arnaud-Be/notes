*base : https://doc.ubuntu-fr.org/asterisk*

installé sur GNU/Debian 12 minimal (serveur + ssh + stack LAMP)
fonctione avec Ubuntu

### mettre à jour
```
apt update
apt upgrade
```
### installation des paquets pour compiler Asterisk
```
apt install build-essential libxml2-dev libncurses5-dev linux-headers-$(uname -r) libsqlite3-dev libssl-dev libedit-dev uuid-dev libjansson-dev
```
### installation de la dernière version d'Asterisk

> copier le liens de la version sur https://downloads.asterisk.org/pub/telephony/asterisk/ 

```
mkdir /usr/src/asterisk
cd /usr/src/asterisk
wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-22-current.tar.gz
tar -xvzf asterisk-22-current.tar.gz
cd asterisk-22.1.0/
./configure --with-jansson-bundled
make menuselect
```
> Lorsque vous faites le ./configure, il est possible qu'il manque des paquets; dans ce cas, installez
la version dev de ce paquet (par exemple, s'il manque le paquet libedit, exécutez la commande `apt install libedit-dev`) puis relancez le `./configure`

> Dans le menu qui s'affiche, allez dans Core Sound Package et cochez à l'aide de la touche Espace CORE-SOUNDS-FR-ULAW. Quittez en pressant la touche Echap. Allez ensuite dans Music On Hold File Packages, décochez MOH-OPSOUND-WAV et cochez MOH-OPSOUND-ULAW. Enfin, allez dans Extras Sound Packages et cochez EXTRA-SOUNDS-FR-ULAW.

> Revenez à l'écran principal et appuyez sur Echap pour terminer et pressez S pour sauvegarder.
```
make
make install
make samples
make config
```

### lancez Asterisk
```
systemctl enable asterisk.service
systemctl start asterisk.service
```

### entrer en mode console Asterisk
```
asterisk -rvvvv
core set verbose 10
reload
```
----------
### Début des configurations
sortir du mode console Asterisk
```
exit
```

Modifier les fichiers **/etc/asterisk/pjsip.conf** et **/etc/asterisk/extensions.conf**
(bien penser à récupèrer l'adresse IP de du serveur avec la commande `ip a` )
```
vim /etc/asterisk/pjsip.conf

;===============EXAMPLE TRANSPORTS============================================
[transport-udp]
type=transport
protocol=udp    ;udp,tcp,tls,ws,wss,flow
bind=0.0.0.0

=====ENDPOINT CONFIGURED FOR USE WITH A SIP PHONE====
[1001]
type=endpoint
transport=transport-udp
context=from-internal
disallow=all
allow=ulaw
allow=gsm
auth=1001
aors=1001

[1001]
type=auth
auth_type=userpass
password=1001
username=1001

[1001]
type=aor
max_contacts=1
contact=sip:1001@<adresseIpDeVotreMachine>:5060

[1002]
type=endpoint
transport=transport-udp
context=from-internal
disallow=all
allow=ulaw
allow=gsm
auth=1002
aors=1002

[1002]
type=auth
auth_type=userpass
password=1002
username=1002

[1002]
type=aor
max_contacts=1
contact=sip:1002@<adresseIpDeVotreMachine>:5060
```
----------------
*ajouter à la toute fin du fichier extensions.conf*
```
vim /etc/asterisk/extensions.conf
;=======Context tp VoIP 09/01/2025 =========
[from-internal]
exten => 1001,1,DIAL(PJSIP/${EXTEN},10,tr)
exten => 1002,1,DIAL(PJSIP/${EXTEN},10,tr)
```

### entrer en mode console Asterisk
```
asterisk -rvvvv
core set verbose 10
reload
```

**il ne nous reste plus qu'à configurer MicroSIP (sur Windows)**

-----------------------
### Installation du voicemail
base : https://tsrit.com/2014/07/19/configuration-de-base-de-voicemail-sur-asterisk-2/
Au début il faut vérifier que le fichier /etc/asterisk/voicemail.conf contient les lignes suivantes :
```
[general]
format=wav49|gsm|wav ; Formats for writing Voicemail
serveremail=asterisk ; Who the e-mail notification should appear to come from
attach=yes ; Should the email contain the voicemail as an attachment
skipms=3000 ; How many milliseconds to skip forward/back when rew/ff in message playback
maxsilence=10 ; How many seconds of silence before we end the recording
silencethreshold=128 ; Silence threshold
maxlogins=3 ; Max number of failed login attempts
pagerdateformat=%A, %B %d, %Y at %r ; Default for pager use
sendvoicemail=yes ; Allow the user to compose and send a voicemail
maxsecs=120

; Corps du mail

emaildateformat=%A, %d %B %Y a %H:%M:%S
emailsubject=[asterisk] Nouveau message dans la boite ${VM_MAILBOX}
emailbody=Bonjour ${VM_NAME},nntLe numero ${VM_CALLERID} a tente de vous joindre sans succes le ${VM_DATE}.nCette personne vous a laisse un message de ${VM_DUR} secondes. Vous pouvez le consulter en appelant votre boite vocale.nntBonne journee !nntttt–Asterixn
pagerfromstring=[Asteriks]
pagersubject=Nouveau message vocal
pagerbody=Nouveau message de ${VM_DUR} secondes dans la boite ${VM_MAILBOX} laisse le ${VM_DATE} par ${VM_CALLERID}.

[zonemessages]

eastern=America/New_York|’vm-received’ Q ‘digits/at’ IMp
central=America/Chicago|’vm-received’ Q ‘digits/at’ IMp
central24=America/Chicago|’vm-received’ q ‘digits/at’ H N ‘hours’
military=Zulu|’vm-received’ q ‘digits/at’ H N ‘hours’ ‘phonetic/z_p’
european=Europe/Copenhagen|’vm-received’ a d b ‘digits/at’ HM
```
et ajouter à la fin 
```
[default]
1001 => 4242,1001,votreAdresse@mail.com
1002 => 4242,1002,votreAdresse@mail.com 
```
> [default] : Contexte dans lequel se trouvent nos utilisateurs
> 1001 : Numéro de l’utilisateur
> 4242 : Mot de passe pour accéder à la boite vocale
> 1001 : Nom de l’utilisateur
> votreAdresse@mail.com : Les adresses mail mises au bout sont les adresses du propriétaire de la boite.


modifier le fichier extensions.conf
```
[from-internal]
exten => 1001,1,DIAL(PJSIP/${EXTEN},10,tr)
exten => 1001,2,VoiceMail(1001)
exten => 1002,1,DIAL(PJSIP/${EXTEN},10,tr)
exten => 1002,2,VoiceMail(1002)

exten => 9999,1, Log(NOTICE, Dialing out from ${CALLERID(all)} to VoiceMail (9999))
exten => 9999,n, VoiceMailMain(${CALLERID(num)}@default,s)
exten => 9999,n, Hangup
```
pour joindre la boite vocale composer le 9999

pour la messagerie en fr recupérer les ficchiers son sur 

https://downloads.asterisk.org/pub/telephony/sounds/releases/
```
cd /var/lib/asterisk/sounds/
wget https://downloads.asterisk.org/pub/telephony/sounds/releases/asterisk-core-sounds-fr-gsm-1.6.1.tar.gz
tar -xf asterisk-core-sounds-fr-gsm-1.6.1.tar.gz
wget https://downloads.asterisk.org/pub/telephony/sounds/releases/asterisk-core-sounds-fr-ulaw-1.6.1.tar.gz
tar -xf asterisk-core-sounds-fr-ulaw-1.6.1.tar.gz
wget https://downloads.asterisk.org/pub/telephony/sounds/releases/asterisk-core-sounds-fr-wav-1.6.1.tar.gz
tar -xf asterisk-core-sounds-fr-wav-1.6.1.tar.gz
```
