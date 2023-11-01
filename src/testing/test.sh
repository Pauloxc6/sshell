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

    figlet Testing Servers
    echo -e "By: @pauloxc6 | \t $(date)"
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
    echo -e "\t ip          | IP Information"
    echo -e "\t ping        | Testing Connection"
    echo -e "\t netstat     | Show Network Connection"
    echo -e "\t nslookup    | Query Internet name servers"
    echo -e "\t dig         | "
    echo -e "\t netdiscover | "
    echo -e "\t netcat      | "
    echo -e "\t nbtscan     | "
    echo -e "\t smbclient   | "
    echo -e "\t sslscan     | "

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

}   

function net(){
    echo ""
    netstat -tuln
    echo ""
}

function ns(){
    read -p "DNS: " dns1
    nslookup -debug $dns1 1.1.1.1
    echo "" 
}

function di(){
    read -p "DNS: " dns1
    dig $dns1 -t any @8.8.8.8
    echo "" 
}

function netd1(){

    ip1
    echo ""
    netdiscover -r $ipv4/24  #| sed 's/^/\t'
    echo ""
}

function ncat(){
    echo ""
    echo "Test Connection"
    read -p "IP/DNS: " idn1
    read -p "Porta: " port1

    nc -vv $idn1 $port1

    echo ""
}

function nbts(){
    echo ""
    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo"))

    for interface in "${interfaces[@]}";do
        ipv4=$(ifconfig $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    done

    nbtscan -r $ipv4/24

    echo ""
}

function smbc(){
    echo ""
    read -p "Server IP: " ipsmb
    smbclient \\\\$ipsmb\\;
    echo ""
}

function sss(){
    echo ""
    read -p "DNS/IP: " dip
    sslscan $dip
    echo ""
}
#-----------------------------------
# Main
#-----------------------------------

while true; do

    #----------------------------------
    # Menu
    #----------------------------------
    echo -e "Testing: "
    echo ""
    echo -e "1. Monitory"
    echo -e "2. Traffic"

    echo ""

    read -p "root@server:~/sshell/src/testing/# " testing

    case $testing in
    
        help)
            help ;;

        exit|3)
            echo -e "[*] Exiting ..... [*]\n"
            exit 1;;

        clear)
            clear ;;

        back)
            exit 0 ;;

        banner)
            banner1 ;;

        ping)
            ping1 ;;
        
        ip)
            ip1 ;;

        netstat)
            net ;;

        nslookup)
            ns ;;

        dig)
            di ;;

        netdiscover)
            netd1 ;;

        netcat)
            ncat ;;

        nbtscan)
            nbts ;;

        smbclient)
            smbc ;;

        sslscan)
            sss ;;

        #-------------------------------------------
        1)
            ./src/testing/monitory/mon.sh ;;

        2)
            ./src/testing/traffic/traffic.sh ;;

        #-------------------------------------------

        *)
            echo -e "[*] Erro no programa! [*]\n"
            sleep 1
            exit 1 ;;
    esac

done
