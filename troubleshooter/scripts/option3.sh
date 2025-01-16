#!/bin/bash

##!!!!RUN SCREEN COMMS SUPER COMMAND !!!!!!!!

#!/bin/bash


#irrelevant functions 
color_f() {
    echo -e "\e[31m[SH]\e[0m" "\e[1m$@\e[0m"
}

#Validate if the user has set IPs and Inputs in sbL
read -p "Have you set the screens' IP settings on Switchboard Local? [Yes/No]: " sb_local_ips
read -p "Have you set the screens' input on Switchboard Local? [Yes/No]: " sb_local_input 

#Capitalize user input 
sb_local_ips="${sb_local_ips^}"
sb_local_input="${sb_local_input^}"

#if stament to let user continue after setting sb local 
if [ "$sb_local_input" = "Yes" ]; then
    sleep 1
    color_f "SBL check: \e[32mPassed\e[0m"
else
    sleep 1
    color_f "SBL check: \e[31mFailed\e[0m"
    sleep 1
    color_f "Please configure the screens' input settings in Switchboard Local first" 
    exit
fi

if [ "$sb_local_ips" = "Yes" ]; then
    sleep 1
    color_f "SBL2 check: \e[32mPassed\e[0m"
else 
    sleep 1
    color_f "SBL2 check: \e[31mFailed\e[0m"
    sleep 1
    color_f "Please configure the screens' IPs in Switchboard Local first"
    exit 
fi

#saves SQL query output into a variable (screen input and IPs)
sleep 1
color_f "Extracting data from MariaDB"
screen_ips=$(MYSQL_PWD=root mysql -sN -uroot switchboard -e "SELECT JSON_UNQUOTE(JSON_EXTRACT(data, '\$[0].value')) AS ip FROM screen")
screen_input=$(MYSQL_PWD=root mysql -sN -uroot switchboard -e "SELECT JSON_UNQUOTE(JSON_EXTRACT(data, '\$[1].value')) AS input_value FROM screen;")

#check if the store has DT
if [[ $screen_ips == *192.168.30.207* || $screen_ips == *192.168.30.208* || $screen_ips == *192.168.30.209* || $screen_ips == *192.168.30.210* || $screen_ips == *192.168.30.217* || $screen_ips == *192.168.30.218* ]]; then
    sleep 1
    color_f "This location has a Drive-thru"
    dt="True"
else 
    sleep 1
    color_f "This location does not have a Drive-thru"
    dt="False"
fi

#If the store has DT do:
if [ $dt = "True" ];then
    #cheks if the store has HDBTs or HDMIs for the DT
    if [[ $screen_input == *HDBaseT* ]]; then
        sleep 1
        color_f "Drive-thru uses HDBTs"
        HDBT="True"
    else
        sleep 1
        color_f "Drive-thru uses HDMIs"
        HDBT="False"
    fi 
else 
    : #do nothing 
fi

#Removes duplicates from SQL query 
screen_ips=$(echo "$screen_ips" | tr ' ' '\n' | awk '!seen[$0]++' | tr '\n' ' ')

#Sort form lowest to highest IP
screen_ips=$(echo "$screen_ips" | tr ' ' '\n' | sort -n -t . -k1,1 -k2,2 -k3,3 -k4,4 | tr '\n' ' ')

#Convert variable into array
screen_ips_array=($screen_ips)

#get the screens' brand and send the hex command
color_f "Checking screens' brand"
for ip in "${screen_ips_array[@]}"; do 
    brand=$(timeout --signal=SIGKILL 10s sudo nmap -p- $ip)
    if [ "$?" -eq 137 ]; then
        color_f "$ip \033[1;31mTimed out!\033[0m"
        continue
    else
        : #do nothing
    fi
    if [[ "$brand" == *1515* ]]; then
        sleep 1
        color_f "$ip is Samsung"
        if [[ ("$ip" == "192.168.30.207" || "$ip" == "192.168.30.208" || "$ip" == "192.168.30.209" || "$ip" == "192.168.30.210") && "$HDBT" == "True" ]]; then 
            sleep 1
            color_f "$ip uses HDBT, executing hexcommand"
            echo -ne '\xAA\xFD\x00\x02\x00\x01\x00' | nc -q1 $ip 1515 | xxd -p && sleep 1 && echo -ne '\xAA\x33\x01\x01\x01\x36' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x56\x01\x01\x00\x58' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xB5\x01\x01\x01\xB8' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x92\x01\x01\x00\x94' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x86\x01\x01\x00\x88' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xCA\x01\x02\xA1\x00\x6E' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xC6\x01\x02\x81\x00\x4A' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x1D\x01\x01\x01\x20' | nc -q1 $ip 1515 | xxd -p && switchboard screen control -t=input -b=samsung -i=$ip -v=HDBaseT && sleep 1 && echo -ne '\xAA\xC8\x01\x02\x82\x00\x4D' | nc -q1 $ip 1515 | xxd -p && switchboard screen control -t=power-status -b=samsung -i=$ip -v=OFF && sleep 1 && switchboard screen control -t=power-status -b=samsung -i=$ip -v=ON
        elif [[ ("$ip" == "192.168.30.207" || "$ip" == "192.168.30.208" || "$ip" == "192.168.30.209" || "$ip" == "192.168.30.210") && "$HDBT" == "False" ]]; then
            sleep 1
            color_f "$ip uses HDMI, executing hexcommand"
            echo -ne '\xAA\xFD\x00\x02\x00\x01\x00' | nc -q1 $ip 1515 | xxd -p && sleep 1 && echo -ne '\xAA\x33\x01\x01\x01\x36' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x56\x01\x01\x00\x58' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xB5\x01\x01\x01\xB8' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x92\x01\x01\x00\x94' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x86\x01\x01\x00\x88' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xCA\x01\x02\xA1\x00\x6E' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xC6\x01\x02\x81\x00\x4A' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x1D\x01\x01\x01\x20' | nc -q1 $ip 1515 | xxd -p && switchboard screen control -t=input -b=samsung -i=$ip -v=HDMI1 && sleep 1 && echo -ne '\xAA\xC8\x01\x02\x82\x00\x4D' | nc -q1 $ip 1515 | xxd -p && switchboard screen control -t=power-status -b=samsung -i=$ip -v=OFF && sleep 1 && switchboard screen control -t=power-status -b=samsung -i=$ip -v=ON
        else
            sleep 1
            color_f "Running hexcommand for $ip"
            echo -ne '\xAA\xFD\x00\x02\x00\x01\x00' | nc -q1 $ip 1515 | xxd -p && sleep 1 && echo -ne '\xAA\x33\x01\x01\x01\x36' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x56\x01\x01\x00\x58' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xB5\x01\x01\x01\xB8' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x92\x01\x01\x00\x94' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x86\x01\x01\x00\x88' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xCA\x01\x02\xA1\x00\x6E' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\xC6\x01\x02\x81\x00\x4A' | nc -q1 $ip 1515 | xxd -p && echo -ne '\xAA\x1D\x01\x01\x01\x20' | nc -q1 $ip 1515 | xxd -p && switchboard screen control -t=input -b=samsung -i=$ip -v=HDMI1 && sleep 1 && echo -ne '\xAA\xC8\x01\x02\x82\x00\x4D' | nc -q1 $ip 1515 | xxd -p && switchboard screen control -t=power-status -b=samsung -i=$ip -v=OFF && sleep 1 && switchboard screen control -t=power-status -b=samsung -i=$ip -v=ON
        fi
    elif [[ "$brand" == *7141* ]]; then
        sleep 1
        color_f "$ip is Nec"
        sleep 1
        color_f "There is not hexcommand for Nec available"
    elif [[ "$brand" == *9761* ]]; then 
        sleep 1
        color_f "$ip is Lg"
        sleep 1
        color_f "There is not hexcommand for Lg available"
    else
        color_f "$ip \033[1;31mError!\033[0m"
    fi
done 

#start clean up process 
sleep 1
color_f "If there are \e[1;31merrored\e[1;39m or \e[1;31mtimed out\e[1;39m devices, please double check them and run hexcommand manually if needed"
sleep 1
color_f "Operation completed"
sudo rm screen-hex.sh