#!/bin/bash

menu () {
    ##je voudrais que le premier echo soit en vert
    echo "$(tput setaf 2)que fair?"
    echo "$(tput setaf 6)1. Désinstaller Samba"
    echo "2. Ajouter un utilisateur"
    echo "3. Ajouter un disque partagé"
    echo "4. Voir les dossiers partagés"
    echo "5. Voir les utilisateurs et les mots de passe"
    echo "$(tput setaf 1)6. Quitter"
    echo "$(tput sgr0)"
}

# Vérifier si Samba est installé
if ! command -v smbd &> /dev/null; then
    echo "Samba n'est pas installé. Installation en cours..."
    sudo apt-get update
    sudo apt-get install -y samba samba-common-bin
    sudo cp smb.conf /etc/samba/smb.conf
    sudo mkdir  /home/shares
    sudo mkdir /home/shares/public
    sudo chown -R root:users /home/shares/public
    sudo chmod -R ug=rwx,o=rx /home/shares/public
    sudo touch /etc/samba/smbpasswd
    sudo /etc/init.d/smbd restart
    echo "Samba installé, les dossiers partagés sont dans /home/shares/public."
    menu
    ## Si Samba est déjà installé, afficher le menu
else
    menu
fi

read -p "Votre choix : " choix

if [ $choix -eq 1 ]; then
    echo "Désinstallation de Samba..."
    sudo apt-get remove -y samba samba-common-bin
    echo "Désinstallation terminée."
    exit 0
elif [ $choix -eq 2 ]; then
    echo "Ajout d'un utilisateur..."
    read -p "Nom de l'utilisateur : " user
    sudo useradd $user -m -G users
    read -p "Mot de passe : " password
    sudo smbpasswd -a $user
    echo "$user:$password" >> /etc/samba/smbpasswd
    echo "Utilisateur ajouté."
    exit 0
elif [ $choix -eq 3 ]; then
    echo "Ajout d'un disque partagé..."
    read -p "Nom du disque (exemple disk1=sda1 / disk2=sda2): " disk
    sudo mkdir /home/shares/public/$disk

    # Vérifier si le disque existe
    if [[ -e /dev/$disk ]]; then
        # Vérifier si le disque a un chiffre dans son nom
        if [[ $disk =~ [0-9] ]]; then
            diskName=$(echo $disk | sed 's/[0-9]*//g')
            diskNumber=$(echo $disk | sed 's/[^0-9]*//g')
            sda="sda$diskNumber"
        fi
        sudo mount /dev/$sda /home/shares/public/$disk

        # Ajouter une entrée dans /etc/fstab
        echo "/dev/$sda /home/shares/public/$disk ext4 defaults 0 0" | sudo tee -a /etc/fstab
        echo "Disque partagé ajouté."
    else
        echo "Le disque n'existe pas."
    fi
    exit 0
elif [ $choix -eq 4 ]; then
    echo "Liste des dossiers partagés :"
    sudo cat /etc/samba/smb.conf | grep "\[" | cut -d "[" -f2 | cut -d "]" -f1
    exit 0
elif [ $choix -eq 5 ]; then
    echo "Liste des utilisateurs et des mots de passe :"
    sudo cat /etc/samba/smbpasswd
    exit 0
else
    echo "Script terminé."
    exit 1
fi
