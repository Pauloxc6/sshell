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
figlet Files Server
echo -e "By: @pauloxc6 | \t $(date)"
sleep 2

#-----------------------------------
# Var
#-----------------------------------


#-----------------------------------
# Functions
#-----------------------------------


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
    echo -e "1. ftp"
    echo -e "2. smb"
    echo -e "3. exit "

    echo -e ""

    read -p "root@server:~/sshell/src/srv/files/# " server

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
            ./src/srv/files/ftp/ftp.sh
            exit 0;;
        2)
            ./src/srv/files/smb/smb.sh
            exit 0;;

    esac
done
