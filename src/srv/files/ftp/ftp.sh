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
sleep 2

#-----------------------------------
# Var
#-----------------------------------


#-----------------------------------
# Functions
#-----------------------------------

function vs() {
    #install
    apt update && apt upgrade -y
    apt install vsftpd -y

    #config
    echo -e "Config:"
    echo -e "1. Manual"
    echo -e "2. Auto"

    read -p "[-] Opt: " ma

    case $ma in
        1)
            echo -e "[*] Create : Group -> ftpusers [*]"
            groupadd ftpusers

            echo -e "[*] Create : User -> ftpuser [*]"
            useradd -g ftpusers ftpuser
            passwd ftpuser

            cd /home
            mkdir ftpuser

            chown ftpuser:ftpusers ftpuser
            chmod a-w ftpuser

            echo -e "[*] Create : Dir -> /home/ftpuser/public [*]"
            mkdir /home/ftpuser/public
            chown ftpuser:ftpusers /home/ftpuser/public
            
            echo -e "[*] Confing Server [*]"
            sleep 2
            
            nano /etc/vsftpd.conf
            
            echo -e "[*] Exit[*]"
            exit 0 ;;
        2)
            echo -e "[*] Create : Group -> ftpusers [*]"
            groupadd ftpusers

            echo -e "[*] Create : User -> ftpuser [*]"
            useradd -g ftpusers ftpuser
            passwd ftpuser

            cd /home
            mkdir ftpuser
            chown ftpuser:ftpusers ftpuser
            chmod a-w ftpuser

            echo -e "[*] Create : Dir -> /home/ftpuser/public [*]"
            mkdir /home/ftpuser/public
            chown ftpuser:ftpusers /home/ftpuser/public

            echo -e "[*] Confing Server [*]"
            sleep 5

            echo "$(sed 's/anonymous_enable=NO/anoymous_enable=YES/' -e 's/local_root=/home/$USER/public//local_root=/home/$USER/public//' -e 's/local_enable=NO/local_enable=YES/' -e 's/pasv_enable=NO/pasv_enable=YES/' -e 's/chroot_local_user=NO/chroot_local_user=YES' /etc/vsftpd.conf)" > /etc/vsftpd.conf
            
            echo -e "[*] Exit[*]"
            exit 0 ;;

        *)
            echo -e "Error Config"
    esac

    #run
    /etc/init.d/vsftpd start
}

function pro() {
    #install
    apt update && apt upgrade -y
    apt install proftpd -y

    #config
    echo -e "Config: "
    echo -e "1. Manual"
    echo -e "2. Auto"

    read -p "[-] Opt: " ma

    case $ma in
        1)
            exit 0;;
        2)
            exit 0;;
        *)
            echo -e "[*] Error : Escolha uma opção acima [*]"
    esac
}


function help() {

    echo -e "Help Menu: "
    echo -e ""
    echo -e "\t help        | Help Menu"
    echo -e "\t exit        | Exit the program"
    echo -e "\t clear       | Clean the screen"
    echo -e "\t back        | Go back to the root"
    echo ""
}

function debug() {
    echo "Teste"
}

#-----------------------------------
# Main
#-----------------------------------

while true; do

    #----------------------------------
    # Menu
    #----------------------------------
    echo -e "\nInstall: "
    echo -e "1. vsftpd"
    echo -e "2. proftpd"
    echo -e "3. exit "

    echo -e ""

    read -p "root@server:~/sshell/src/srv/files/ftp/# " server

    case $server in

        help)
            help;;

        exit|3)
            echo -e "[*] Exiting ..... [*]\n"
            exit 1;;

        clear)
            clear;;

        back)
            exit 0;;

        1)
            vs
            exit 0;;
        2)
            pro
            exit 0;;

    esac
done
