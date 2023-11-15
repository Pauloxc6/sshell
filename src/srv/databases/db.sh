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
figlet Database Server
echo -e "By: @pauloxc6 | \t $(date)"
sleep 2

#-----------------------------------
# Var
#-----------------------------------


#-----------------------------------
# Functions
#-----------------------------------

function my1() {
    #install
    apt update && apt upgrade -y
    apt install mysql -y

    #config
    echo -e "Config: "
    echo -e "1. Manual"
    echo -e "2. Auto"

    read -p "[-] Opt: " ma

    case $ma in
        1)
            echo -e "[*] Login in MySQL [*]"
            read -p "[+] User: " user
            mysql -u $user -p 

            exit 0 ;;
        2)
            echo -e "[*] Login in MySQL [*]"
            read -p "[+] User: " user
            mysql -u $user -p < script_mysql.sql
            exit 0 ;;

        *)
            echo -e "[*] Error : Escolha uma opção acima [*]"
            exit 0;;
    esac

}

function pos1() {
    #install
    apt update && apt upgrade -y
    apt install postgresql -y

    #config
    echo -e "Config: "
    echo -e "1. Manual"
    echo -e "2. Auto "

    read -p "[-] Opt: " ma

    case $ma in
        1)
            echo -e "[*] Login in MySQL [*]"
            read -p "[+] User: " user
            psql -u $user -W
            exit 0 ;;
        2)
            echo -e "[*] Login in MySQL [*]"
            read -p "[+] User: " user
            psql -u $user -W -f script_postgresql.sql
            exit 0 ;;
        *)
            echo -e "[*] Error : Escolha uma opção acima [*]"
            exit 0 ;;
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

    read -p "root@server:~/sshell/src/srv/databases/# " db

    case $db in

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
            my1
            exit 0;;
        2)
            pos1
            exit 0;;

    esac
done
