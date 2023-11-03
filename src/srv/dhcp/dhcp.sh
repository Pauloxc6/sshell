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

function isc() {
    #install
    apt update && apt upgrade -y
    apt install isc-dhcp-server -y

    #config
    echo -e "Config: \n"
    echo -e "1. Manual \n"
    echo -e "2. Auto \n"

    read -p "Opt: " ma

    case ma in
        1)
            echo -e "[*] Create : IP Forward [*]"
            echo 1 > /proc/sys/net/ipv4/ip_forward
            echo -e "[*] Create : Firewall Rules [*]"
            iptables -t nat -a POSTROUTING -e wlan0 -j MASQUERADE
            cd /etc/default/
            echo -e "[*] Config : /etc/default/isc-dhcp-server [*]"
            nano isc-dhcp-server
            cd /etc/dhcp/
            echo -e "[*] Config : /etc/dhcp/dhcp/dhcp.conf [*]"
            nano dhcpd.conf
            grep -v "^#" dhcpd.conf | sed '/^$/d' > dhcp
            nano dhcp
            rm dhcpd.conf && mv dhcp dhcpd.conf
            echo -e "[*] Init Server [*]"
            service isc-dhcp-server start
            echo -e "[*] Exit[*]"
            exit 0 ;;
        2)
            echo -e "[*] Create : IP Forward [*]"
            echo 1 > /proc/sys/net/ipv4/ip_forward
            echo -e "[*] Create : Firewall Rules [*]"
            iptables -t nat -a POSTROUTING -e wlan0 -j MASQUERADE
            cd /etc/default/
            echo -e "[*] Config : /etc/default/isc-dhcp-server [*]"
            nano isc-dhcp-server
            cd /etc/dhcp/
            echo -e "[*] Config : /etc/dhcp/dhcp/dhcp.conf [*]"
            echo -e "option domain-name-servers 8.8.8.8, 8.8.4.4;\n\ndefault-lease-time 600;\nmax-lease-time 7200;\n\nddns-update-style none;\n\nsubnet 192.168.0.0 netmask 255.255.255.0 {\n\trange 192.168.0.10 192.168.0.30;\n\toption broadcast-address 192.168.0.255;\n\toption routers 192.168.0.1;\n}"
            rm dhcpd.conf && mv dhcp dhcpd.conf
            echo -e "[*] Init Server [*]"
            service isc-dhcp-server start
            echo -e "[*] Exit[*]"
            exit 0 ;;

        *)
            echo -e "Error Config"
    esac

    #run
    service isc-dhcp-server start
}

#-----------------------------------
# Main
#-----------------------------------

while true; do

    #----------------------------------
    # Menu
    #----------------------------------
    echo -e "Install: \n"
    echo -e "1. isc-dhcp-server \n"
    echo -e "3. exit "

    echo -e "\n"

    read -p "Server: " server

    case server in
        1)
            isc
            exit 0;;
        2)
            echo -e "[*] Exit [*]"
            exit 0 ;;
    esac
done
