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

    figlet Monitory
    echo -e "By: @pauloxc6 | \t $(date)"
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
}

function dnstop1(){
    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo" | grep -v "wlx"))

    for interface in "${interfaces[@]}";do
        echo "Interface: $interface"
        sleep 1
        dnstop $interface
    done

    echo ""
}

function dhcpdump1(){
    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo"))

    for interface in "${interfaces[@]}";do
        dhcpdump -i $interface
    done

    echo ""
}

function speed1(){
    interfaces=($(ifconfig -a | grep -oP '^[a-zA-Z0-9]+(?=: flags=)' | grep -v "lo"))

    for interface in "${interfaces[@]}";do
        speedometer -t $interface -r $interface
    done

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
    echo -e "1. bmon"
    echo -e "2. dhcpdump"
    echo -e "3. dnstop"
    echo -e "4. httpry"
    echo -e "5. p0f"
    echo -e "6. speedometer"
    echo -e "7. whowatch"
    echo ""

    read -p "root@server:~/sshell/src/testing/monitory/# " mon

    # Testing
    case $mon in

        1)
            bmon
            echo "";;

        2)
            dhcpdump1
            echo "";;

        3)
            dnstop1
            echo "";;

        4)
            httpry
            echo "";;

        5)
            p0f
            echo "";;

        6)
            speed1
            echo "";;

        7)
            whowatch.dpkg-new 
            echo "";;    

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

        ping)
            ping1 ;;
        
        ip)
            ip1 ;;

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
