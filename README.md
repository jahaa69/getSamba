# getSamba
 it's a small script that allows you to install Samba and configure it automatically

 ## To add another disk 
 
to add another disk you would have to add certain information to do this type the command


```bash
  dmesg	
```


then you will be able to find a new disk surely named sda2 or sd3....

once the name of your disk recover created a new folder


```bash
  sudo mkdir /home/shares/public/disk2
```
Then

```bash
  sudo mount /dev/DISK_NAME /home/shares/public/disk2
```


after you have created the folder entered in the fstab file ATTENTION be careful not to make a mistake or block your raspberry and have to start all over again

```bash
  sudo nano /etc/fstab	
```
once in this file copy and paste this line again don't forget the spaces

```bash
  /dev/DISK_NAME /home/shares/public/disk2 auto noatime 0 0	
```
and ctrl+x , y

finish!!!
=============================================
# getSamba
 c'est un petit script qui permet d'installer Samba et de le configurer automatiquement

 ## Pour ajouter un autre disque
 
pour ajouter un autre disque, vous devrez ajouter certaines informations pour ce faire, tapez la commande


```bash
  dmesg
```


alors vous pourrez trouver un nouveau disque sûrement nommé sda2 ou sd3....

une fois le nom de votre disque récupéré, un nouveau dossier a été créé


```bash
  sudo mkdir /home/shares/public/disk2
```
Alors

```bash
  sudo mount /dev/LE_NOM_DE_VOTRE_DISQUE /home/shares/public/disk2
```


après avoir créé le dossier entré dans le fichier fstab ATTENTION faites attention à ne pas vous tromper ou bloquer votre raspberry et devoir tout recommencer

```bash
  sudo nano /etc/fstab
```
une fois dans ce fichier copiez et collez à nouveau cette ligne n'oubliez pas les espaces

```bash
  /dev/LE_NOM_DE_VOTRE_DISQUE /home/shares/public/disk2 auto noatime 0 0
```
et ctrl+x , y

fini!!!