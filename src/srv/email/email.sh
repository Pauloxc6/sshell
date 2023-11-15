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
figlet Login Server
echo -e "By: @pauloxc6 | \t $(date)"
sleep 2

#-----------------------------------
# Var
#-----------------------------------


#-----------------------------------
# Functions
#-----------------------------------

function courier1() {
    #install
    apt update && apt upgrade -y
    apt install courier -y

    #config
    echo -e "Config: "
    echo -e "1. Manual"
    echo -e "2. Auto"

    read -p "[-] Opt: " ma

    case $ma in
        1)
            echo -e "[*] Confing Server [*]"
            
            grep -v "^#" imapd | sed '/^$/d' > imapd
            grep -v "^#" pop3d | sed '/^$/d' > pop3d

            echo -e "[*] Confing IMAP [*]"
            nano /etc/courier/imapd

            echo -e "[*] Confing POP [*]"
            nano /etc/courier/pop3d

            echo -e "[*] Exit [*]"
            exit 0 ;;
        2)
            echo -e "[*] Confing Server [*]"

            grep -v "^#" imapd | sed '/^$/d' > imapd
            grep -v "^#" pop3d | sed '/^$/d' > pop3d
            
            echo -e "[*] Confing IMAP [*]"
            echo "$(sed 's/ADDRESS=0/ADDRESS=$ipv4/' -e 's/IMAP_CHECK_ALL_FOLDERS=0/IMAP_CHECK_ALL_FOLDERS=1/' -e 's/IMAP_ENHANCEDIDLE=0/IMAP_ENHANCEDIDLE=1/' /etc/courier/imapd)" > /etc/courier/imapd

            echo -e "[*] Confing POP [*]"
            echo "$(sed 's/ADDRESS=0/ADDRESS=$ipv4/' /etc/courier/pop3d)" > /etc/courier/pop3d


            exit 0 ;;

        *)
            echo -e "Error Config"
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
    echo -e "\nInstall:"
    echo -e "1. Courier"
    echo -e "2. exit "

    echo -e ""

    read -p "root@server:~/sshell/src/srv/login/# " server

    case $server in

        help)
            help;;

        exit|2)
            echo -e "[*] Exiting ..... [*]\n"
            exit 1;;

        clear)
            clear;;

        back)
            exit 0;;

        1)
            courier1
            exit 0;;

    esac
done
