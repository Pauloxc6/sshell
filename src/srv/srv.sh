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
function banner1(){

    figlet Servers
    echo -e "Github: @pauloxc6 | \t $(date)"
}

banner1

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
    echo -e "\t banner      | Activate the Banner"
    echo ""
    echo -e "Testing Commands:"
    echo
    echo -e "\t ping        | Testing Connection"
    echo -e "\t ip          | IP Information"
    echo ""
}

function debug() {
    echo "Test"
}

function ping1(){
    echo -e "Testing PING"
    read -p "IP/DNS: " ipdns
    echo ""

    ping -c 4 $ipdns | awk '/PING/ {print; next} {print "\t" $0}'

    echo ""
}


function ip1(){

    lo=$(ip -4 a s dev lo | grep inet | cut -d "/" -f1 | sed s/inet//)
    lo1=$(echo $lo | grep -v "    ")
    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo"))

    for interface in "${interfaces[@]}";do
        ipv4=$(ifconfig $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
        echo -e "\tIPv4: $interface | $ipv4"
    done

    echo -e "\tIP Loopback: lo | $lo1 "

    echo ""

    lo=$(ip -6 a s dev lo | grep inet6 | cut -d "/" -f1 | sed 's/inet6//')
    lo1=$(echo $lo | grep -v "    ")
    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo"))

    for interface in "${interfaces[@]}";do
        ipv6=$(ifconfig $interface | grep -oP '(?<=inet6\s)[\w:]+')
        echo -e "\tIPv6: $interface | $ipv6"
    done

    echo -e "\tIP Loopback: lo | $lo1 "

    echo ""

}
   
#-----------------------------------
# Main
#-----------------------------------

while true; do

    #----------------------------------
    # Menu
    #----------------------------------
    echo -e "Servers:"
    echo
    echo -e "1. Database"
    echo -e "2. DHCP"
    echo -e "3. Email"
    echo -e "4. Files"
    echo -e "5. Login"
    echo -e "6. Printer"
    echo -e "7. VPN"

    echo ""

    read -p "root@server:~/sshell/src/srv/# " srv

    case $srv in
    
        help)
            help ;;

        exit|3)
            echo -e "[*] Exiting ..... [*]\n"
            exit 1 ;;

        clear)
            clear ;;

        back)
            exit 0;;

        banner)
            banner1 ;;

        version)
            echo ""
            echo -e "Version: 1.0" 
            echo "" ;;

        ping)
            ping1;;
        
        ip)
            ip1;;

        #----------------------------------

        1)
            ./srv/databases/db.sh    ;;
        2)
            ./srv/dhcp/dhcp.sh       ;;
        3)
            ./srv/email/email.sh     ;;
        4)
            ./srv/files/file.sh      ;;
        5)
            ./srv/login/login.sh     ;;
        6)
            ./srv/printer/printer.sh ;;
        7)
            ./srv/vpn/vpn.sh         ;;

        #------------------------------------------
        *)
            echo -e "[*] Erro no programa! [*]\n"
            sleep 1
            exit 1 ;;
    esac
done
