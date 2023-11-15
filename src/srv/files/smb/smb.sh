#!/usr/bin/env bash

clear

#-----------------------------
# Root Testing
#-----------------------------
if [[ "$(id -u)" -ne 0 ]];then
    echo -e "\e[1;77mPlease, run this program as root!\n\e[0m"
    exit 1
fi

#------------------------------------
# Banner
#------------------------------------
figlet FTP Server
echo -e "By: @pauloxc6 | \t $(date)"

#-----------------------------------
# Var
#-----------------------------------


#-----------------------------------
# Functions
#-----------------------------------

function ssmbd() {
    #install
    apt update && apt upgrade -y
    apt install samba -y

    #config
    echo -e "Config: "
    echo -e "1. Manual"
    echo -e "2. Auto"

    read -p "[-] Opt: " ma

    case $ma in
        1)
            cd /home
            echo -e "[*] Create : User -> smbuser [*]"
            adduser smbuser
            chmod 755 smbuser
            mkdir pub

            echo -e "[*] Create : Group -> administrate [*]"
            addgroup administrate
            chgrp administrate pub
            adduser smbuser administrate
            smbpasswd -a smbuser
            
            pdbedit -L -v

            echo -e "[*] Init server : /etc/init.d/smbd [*]"
            /etc/init.d/smbd start
            
            cd /etc/samba/
            cp smb.conf smb.conf.bkp
            
            echo -e "[*] Confing Server [*]"
            sleep 2
            
            nano smb.conf
            
            testparm
            
            echo -e "[*] Exit [*]"
            exit 0 ;;
        2)
            cd /home
            echo -e "[*] Create : User -> smbuser [*]"
            adduser smbuser
            chmod 755 smbuser
            mkdir pub

            echo -e "[*] Create : Group -> administrate [*]"
            addgroup administrate
            chgrp administrate pub
            adduser smbuser administrate
            smbpasswd -a smbuser

            pdbedit -L -v

            echo -e "[*] Init server : /etc/init.d/smbd [*]"
            /etc/init.d/smbd start
            
            cd /etc/samba/
            cp smb.conf smb.conf.bkp

            echo -e "[*] Confing Server [*]"
            sleep 5
            echo -e "[global]\n\tworkgroup = Administrate \n\tnetbios name = ServerADM \n\tserver string = Servidor do setor administrativo \n\n[test-smb]\n\tcomment = Diretorio SMBUSER\n\tpath = /home/smbuser/ \n\tvalid users = smbuser \n\twritable = yes \n\tread only = no" > /etc/samba/smb.conf
           
            testparm
            
            echo -e "[*] Exit [*]"
            exit 0 ;;

        *)
            echo -e "[*] Error : Escolha uma opção acima [*]"
    esac

    #run
    /etc/init.d/smbd start
}


#-----------------------------------
# Main
#-----------------------------------

while true; do

    #----------------------------------
    # Menu
    #----------------------------------
    echo -e "Install:"
    echo -e "1. samba/smb"
    echo -e "2. exit"

    echo -e ""

    read -p "root@server:~/sshell/src/srv/files/smb/# " server

    case $server in
        1)
            ssmbd
            exit 0;;
        2)
            echo -e "[*] Exit [*]"
            exit 0 ;;
    esac
done
