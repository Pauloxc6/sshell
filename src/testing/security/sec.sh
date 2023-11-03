#!/usr/bin/env bash
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

    figlet Security
    echo -e "Github: @pauloxc6 | \t $(date)"
}

banner1

#----------------------------
# Var
#----------------------------

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
    echo -e "\t version     | Show Version"
    echo ""
    echo -e "Testing Commands:"
    echo
    echo -e "\t ping        | Testing Connection"
    echo -e "\t ip          | IP Information"
    echo ""
}

function debug() {
    echo "Teste"
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

function nk(){
    echo ""
    figlet nikto
    read -p "DNS/IP: " ho
    nikto -h $ho | awk '/- Nikto/ {print; next} {print "\t" $0}'
    echo ""

}

function medu(){
    echo ""
    figlet medusa
    read -p "DNS/IP: " ho
    read -p "Port: " po

    port_stat=$(nmap -p $po $ho | grep "open" | cut -d " " -f2)
    stat="open"

    if [[ $port_stat -eq $stat ]]; then
        case $po in
            21)
               echo ""
               read -p "Username: " users
               read -p "List of Pass: " list_pass
               medusa -h $ho -u $users -P $list_pass -e ns -M ftp -v 3 
               echo "" ;;

            22)

                echo ""
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                medusa -h $ho -u $users -P $list_pass -e ns -M ssh -v 3 
                echo "" ;;

            23)

                echo ""
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                medusa -h $ho -u $users -P $list_pass -e ns -M telnet -v 3 
                echo "" ;;

            *)
                echo -e "Error no programa!" ;;

        esac

    else
        echo -e "Error: Todas portas estao fechadas"
    fi 

}

function ncr(){
    echo ""
    figlet ncrack
    read -p "DNS/IP: " ho
    read -p "Port: " po

    port_stat=$(nmap -p $po $ho | grep "open" | cut -d " " -f2)
    stat="open"

    if [[ $port_stat -eq $stat ]]; then
        case $po in
            21)
               echo ""
               figlet FTP
               read -p "Username: " users
               read -p "List of Pass: " list_pass
               ncrack -vv --user $users -P $list_pass ftp://$ho:$po -f
               echo "" ;;

            22)

                echo ""
                figlet SSH
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass ssh://$ho:$po -f
                echo "" ;;

            23)

                echo ""
                figlet TELNET
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass telnet://$ho:$po -f 
                echo "" ;;

            25)
                echo ""
                figlet SMTP
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass fsmtp://$ho:$po -f
                echo "" ;;

            110)
                echo ""
                figlet POP3
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass pop3://$ho:$po -f
                echo "" ;;

            143)
                echo ""
                figlet IMAP
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass imap://$ho:$po -f
                echo "" ;;

            445)
                echo ""
                figlet SMB
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -v --user $users -P $list_pass smb://$ho:$po -f
                echo "" ;;

            3306)
                echo ""
                figlet MySQL
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass mysql://$ho:$po -f
                echo "" ;;

            3389)
                echo ""
                figlet RDP
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass rdp://$ho:$po -f
                echo "" ;;

            5060)
                echo ""
                figlet SIP
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass sip://$ho:$po -f
                echo "" ;;

            5801)
                echo ""
                figlet SIP
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass vnc://$ho:$po -f
                echo "" ;;

            5900)
                echo ""
                figlet SIP
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass vnc://$ho:$po -f
                echo "" ;;

            5901)
                echo ""
                figlet SIP
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass vnc://$ho:$po -f
                echo "" ;;

            6001)
                echo ""
                figlet VNC
                read -p "Username: " users
                read -p "List of Pass: " list_pass
                ncrack -vv --user $users -P $list_pass vnc://$ho:$po -f
                echo "" ;;

            *)
                echo -e "Error no programa!" ;;

        esac

    else
        echo -e "Error: Todas portas estao fechadas"
    fi 

}

function bx(){
    echo ""
    figlet BRUTEX
    read -p "Host: " ho
    read -p "Port: " po

    brutex $ho $po

    echo ""
}
#----------------------------
# Main
#----------------------------
while true ;do

    #----------------------------
    # Menu
    #----------------------------
    echo -e "Menu: \n"
    echo -e "1. Nikto"
    echo -e "2. Medusa"
    echo -e "3. Ncrack"
    echo -e "4. Brutex"

    echo ""

    read -p "root@server:~/sshell/src/testing/security/# " opt

    # Testing
    case $opt in

        1)
            nk ;;

        2)
            medu ;;

        3)
            ncr ;;

        4)
            bx ;;

        #-----------------------------------------
       
        help)
            help;;

        exit|3)
            echo -e "[*] Exiting ..... [*]\n"
            exit 1;;

        clear)
            clear;;

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

        *)
            echo -e "[*] Erro no programa! [*]\n"
            sleep 1
            exit 1 ;;

    esac

done

#----------------------------
#exit
#----------------------------
echo -e "[*] Exit ..... [*]\n"
sleep 1
exit 0
