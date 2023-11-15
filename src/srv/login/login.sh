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

function ssh1() {
    #install
    apt update && apt upgrade -y
    apt install openssh -y

    #config
    echo -e "Config: "
    echo -e "1. Manual"
    echo -e "2. Auto"

    read -p "Opt: " ma

    case $ma in
        1)
            read -p "[+] Create group: " gps
            groupadd $gps

            read -p "[+] Create user: " user
            useradd -g $gps $user

            echo -e "[*] SSH-kEYGEN [*]"
            ssh-keygen -b 4096 -t rsa 

            echo -e "[*] Init Server [*]"
            systemctl start ssh.service

            exit 0 ;;
        2)
            echo -e "[+] Create group : users [+]"
            groupadd users

            echo -e "[+] Create user: user [+]"
            adduser -g users user

            echo -e "[*] SSH-kEYGEN [*]"
            ssh-keygen -b 4096 -t rsa 

            echo -e "[*] Init Server [*]"
            systemctl start ssh.service

            exit 0 ;;

        *)
            echo -e "Error Config"
    esac

}

function telnet1() {
    #install
    apt update && apt upgrade -y
    apt install telnetd -y

    #config
    echo -e "Config: "
    echo -e "1. Manual"
    echo -e "2. Auto "

    read -p "[-] Opt: " ma

    case $ma in
        1)
            read -p "[+] Create group: " gps
            groupadd $gps

            read -p "[+] Create user: " user
            useradd -g $gps $user

            echo -e "[*] Init Server [*]"
            systemctl start telnet.service

            exit 0 ;;
        2)
            echo -e "[+] Create group : users [+]"
            groupadd users

            echo -e "[+] Create user: user [+]"
            adduser -g users user

            echo -e "[*] Init Server [*]"
            systemctl start ssh.service

            exit 0 ;;
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
    echo -e "\nInstall:"
    echo -e "1. mysql "
    echo -e "2. postgresql"
    echo -e "3. exit "

    echo -e ""

    read -p "root@server:~/sshell/src/srv/login/# " server

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
            ssh1
            exit 0;;
        2)
            telnet1
            exit 0;;

    esac
done
