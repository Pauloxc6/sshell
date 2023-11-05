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
    echo ""
    echo -e "\t ip          | IP Information"
    echo -e "\t ping        | Testing Connection"
    echo -e "\t netstat     | Show Network Connection"
    echo -e "\t nslookup    | Query Internet name servers"
    echo -e "\t dig         | DNS lookup utility"
    echo -e "\t netdiscover | ARP reconnaissance tool"
    echo -e "\t netcat      | Arbitrary TCP and UDP connections and listens"
    echo -e "\t nbtscan     | Scan networks for NetBIOS name information"
    echo -e "\t smbclient   | Ftp-like client to access SMB/CIFS resources on servers"
    echo -e "\t sslscan     | SSL Analysis"

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

function net(){
    echo ""
    netstat -tuln | awk '/Conexões/ {print; next} {print "\t" $0}'
    echo ""
}

function ns(){
    echo ""
    figlet NSLOOKUP
    read -p "DNS: " dns1
    nslookup -debug $dns1 1.1.1.1
    echo "" 
}

function di(){
    echo ""
    figlet DIG
    read -p "DNS: " dns1
    dig $dns1 -t any @8.8.8.8
    echo "" 
}

function netd1(){

    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo"))

    for interface in "${interfaces[@]}";do
        ipv4=$(ifconfig $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    done

    echo ""
    netdiscover -r $ipv4/24
    echo ""
}

function ncat(){
    echo ""
    figlet NETCAT
    echo "Test Connection"
    read -p "IP/DNS: " idn1
    read -p "Porta: " port1

    nc -vv $idn1 $port1

    echo ""
}

function nbts(){
    echo ""
    figlet NBTSCAN
    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo"))

    for interface in "${interfaces[@]}";do
        ipv4=$(ifconfig $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    done

    nbtscan -r $ipv4/24

    echo ""
}

function smbc(){
    echo ""
    figlet SMBCLIENT
    read -p "Server IP: " ipsmb
    smbclient \\\\$ipsmb\\;
    echo ""
}

function sss(){
    echo ""
    figlet SSLSCAN
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
    echo -e "3. Security"

    echo ""

    read -p "root@server:~/sshell/src/testing/# " testing

    case $testing in
    
        help)
            help ;;

        exit)
            echo -e "[*] Exiting ..... [*]\n"
            exit 1;;

        clear)
            clear ;;

        back)
            exit 0 ;;

        banner)
            banner1 ;;

        version)
            echo ""
            echo -e "Version: 1.0" 
            echo "" ;;

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

        3)
            ./src/testing/security/sec.sh ;;
        #-------------------------------------------

        *)
            echo -e "[*] Erro no programa! [*]\n"
            sleep 1
            exit 1 ;;
    esac

done
