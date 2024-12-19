## Sur la Base :
https://wiki.archlinux.org/title/Installation_guide

https://www.youtube.com/watch?v=iF91ZxHmMVM

## définir clavier azerty
```
localectl list-keymaps
loadkeys fr-latin1
```
## vérifier mode EFI

`cat /sys/firmware/efi/fw_platform_size`

## vérifier internet

`ping archlinux.org`

## Mise à jour de l'horloge système

`timedatectl`

## Partitionnement des disques
```
fdisk -l
fdisk /dev/sda
	g
	w
cfdisk /dev/sda
	n > 512M	t > EFI
	n > 1G		t > Linux Swap
	n > 
	w > yes
mkfs.ext4 /dev/sda3
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2

mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/sda2
```
## Installation des paquets essentiels
```
pacman-key --init
pacman-key --populate

pacman -Sy archlinux-keyring

pacstrap -c -K /mnt base vim nano
```
## Configuration du système
  #~fstab
```
  genfstab -U /mnt  
  genfstab -U /mnt >> /mnt/etc/fstab
  cat !$
  
   
  arch-chroot /mnt
  ping archlinux.org
  
  vim /etc/pacman.conf
	décommente <color>
	décommente <ParallelDownload = 4>

pacman -S linux linux-firmware networkmanager terminus-font sudo
```
 #~config de l'heure
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
```
 #~config de la locale et du clavier
```
vim /etc/locale.gen
	decommenté <fr_FR.UTF-8 UTF-8>
locale-gen
vim /etc/locale.conf
	LANG=fr_FR.UTF-8
	LC_MESSAGES=fr_FR.UTF-8
	
ls /usr/share/kbd/consolefonts/ | grep "ter-"
vim /etc/vconsole.conf
	KEYMAP=fr-latin1
	#FONT=ter-132b
```
 #~definition du nom de la machine
 
`echo <nom de la machine> > /etc/hostname`

 #~ definition du mot de passe root
 
`passwd`

## boot loader
```
pacman -S intel-ucode
bootctl install
cd /boot
ls
cd loader/
ls
vim loader.conf
	default  arch.conf
	timeout  4
	console-mode max
	editor   no

cd entries
blkid
blkid | grep sda3 | awk -F '"' '{print $2}' > arch.conf
vim arch.conf
	title   Arch Linux
	linux   /vmlinuz-linux
	initrd  /intel-ucode.img
	initrd	/initramfs-linux.img
	options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw

bootctl list
cp arch.conf arch-fallback.conf
vim arch-fallback.conf
	title   Arch Linux fallback
	linux   /vmlinuz-linux
	initrd  /intel-ucode.img
	initrd	/initramfs-linux-fallback.img
	options root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx rw

bootctl list
```
## redémarrage du système (pas oublier de retirer le CD du  lecteur)
```
exit
umount -R /mnt
swapoff /dev/sda2

reboot
```
--------------------------
## initialisation des services au démarrage 
```
systemctl enable --now NetworkManager
systemctl enable --now systemd-timesyncd
```
## création de l'utilisateur et de son mot de passe (ajout au groupe sudo)
```
useradd -m -G sudo -s /bin/bash <nom de l'utilisateur>
passwd <nom de l'utilisateur>
```
#~ modif sudoer
```
EDITOR=nano visudo
   #~décommenter la ligne #%sudo	ALL=(ALL:ALL) ALL
```

 










