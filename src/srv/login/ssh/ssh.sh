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
figlet SSH Server
echo -e "By: @pauloxc6 | \t $(date)"

#-----------------------------------
# Var
#-----------------------------------


#-----------------------------------
# Functions
#-----------------------------------

function ossh() {
    #install
    apt update && apt upgrade -y
    apt install openssh -y

    #config
    echo -e "Config: \n"
    echo -e "1. Manual \n"
    #echo -e "2. Auto \n"

    read -p "Opt: " ma

    case ma in
        1)
            systemctl start openssh.service
            ssh-keygen
            ssh-agent
            ssh-add
            exit 0;;

        #2)
        #    exit 0;;

        *)
            echo -e "Error"
    esac
}

#-----------------------------------
# Main
#-----------------------------------

while true; do

    #----------------------------------
    # Menu
    #----------------------------------
    echo -e "Install: \n"
    echo -e "1. openssh \n"

    echo -e "\n"

    read -p "Server: " server

    case server in
        1)
            ossh
            exit 0;;
    esac
done
