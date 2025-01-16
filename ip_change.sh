#!/bin/bash
# Change IP address in current MP
# Able to change from DHCP to static

script_version="2.0"  #From DHCP to static settings added
echo -e "\e[34mNetwork Script V. ${script_version}\e[0m"
sleep 1
echo -e "\e[34mThis script can help you change a media player from DHCP to Static settings\e[0m"
sleep 1
echo -e "\e[34mOr it can help you change a static ip address\e[0m"
sleep 3
echo -e "\e[31mJust follow the instructions\e[0m"
sleep 3
echo -e "\U0001F60A" #smiley face
sleep 2
#subnet array, easier to map the values
declare -A subnet_map
subnet_map["/32"]="255.255.255.255"
subnet_map["/31"]="255.255.255.254"
subnet_map["/30"]="255.255.255.252"
subnet_map["/29"]="255.255.255.248"
subnet_map["/28"]="255.255.255.240"
subnet_map["/27"]="255.255.255.224"
subnet_map["/26"]="255.255.255.192"
subnet_map["/25"]="255.255.255.128"
subnet_map["/24"]="255.255.255.0"
subnet_map["/23"]="255.255.254.0"
subnet_map["/22"]="255.255.252.0"
subnet_map["/21"]="255.255.248.0"
subnet_map["/20"]="255.255.240.0"
subnet_map["/19"]="255.255.224.0"
subnet_map["/18"]="255.255.192.0"
subnet_map["/17"]="255.255.128.0"
subnet_map["/16"]="255.255.0.0"
subnet_map["/15"]="255.254.0.0"
subnet_map["/14"]="255.252.0.0"
subnet_map["/13"]="255.248.0.0"
subnet_map["/12"]="255.240.0.0"
subnet_map["/11"]="255.224.0.0"
subnet_map["/10"]="255.192.0.0"
subnet_map["/9"]="255.128.0.0"
subnet_map["/8"]="255.0.0.0"
subnet_map["/7"]="254.0.0.0"
subnet_map["/6"]="252.0.0.0"
subnet_map["/5"]="248.0.0.0"
subnet_map["/4"]="240.0.0.0"
subnet_map["/3"]="224.0.0.0"
subnet_map["/2"]="192.0.0.0"
subnet_map["/1"]="128.0.0.0"
subnet_map["/0"]="0.0.0.0"


interface_file_path="/etc/network/interfaces"
# reliably grab interface name. This will not change unless hardware changes
#I found instances in which 2 defaults are shown, therefore we grab the first one
interface_name=$(ip -o -4 route show to default | awk 'NR==1{print $5}')
exit_flag=0



#retrieve current static network settings
retrieve_static_settings(){
    #static__ip_address=$(awk '/address/ {print $2}' "$interface_file_path")
    static_netmask=$(awk '/netmask/ {print $2}' "$interface_file_path")
    static_gateway=$(awk '/gateway/ {print $2}' "$interface_file_path")
    static_nameservers=$(awk '/dns-nameservers/ {print $2}' "$interface_file_path")
}


#functions to get DHCP settings
f_obtain_DHCP_IP(){
    dhcp_IP="$(/usr/local/switchboard/shell/ip-address.sh)"
    echo acquiring ....
    sleep 2
    echo "dhcp IPv4 ${dhcp_IP}"
}

f_obtain_DHCP_gateway(){
    #get info from ip route
    dhcp_gateway=$(ip -4 route show default | awk 'NR==1{print $3}')
    echo "dhcp Gateway IPv4 ${dhcp_gateway}"
    sleep 1
}

#function to obtain subnet netmask
f_obtain_DHCP_netmask(){
    CIDR_mask="$(/usr/local/switchboard/shell/ip-address-only-mask.sh)"
    dhcp_netmask=${subnet_map[$CIDR_mask]}
    echo "dhcp Netmask IPv4 ${dhcp_netmask}"
    sleep 1
}

#function to obtain DNS server
f_obtain_DHCP_nameservers(){
    dhcp_nameservers=$(resolvectl status "${interface_name}"| awk '/DNS Servers:/ {print $3, $4}')
    sleep 1
    if [ -z "${dhcp_nameservers}" ]; then
    echo "Nameservers for the interface not set, grabbing global ones."
    dhcp_nameservers=$(resolvectl status | awk '/Current DNS Server:/ {print $4}')
    fi
    echo "dhcp nameservers IPv4 ${dhcp_nameservers}"
}


#function to change the internal values in the interface_file
#The nameservers dont change
change_interface_file(){
sudo tee "$interface_file_path" << EOF > /dev/null
auto lo
iface lo inet loopback
auto $interface_name
iface $interface_name inet static
  address         $ip_address
  netmask         $netmask
  gateway         $gateway
  dns-nameservers $nameservers
EOF
}

#function to retrieve the last octet of the ip_address to be used
retrieve_last_octet(){
    local ip="$1"
    local last_octet=$(echo "$ip" | cut -d '.' -f 4)
    echo "$last_octet"
}

#function to change hostname
f_change_hostname(){
    current_location_code=$(</var/lib/switchboard/data/location)
    echo "Changing host name to $current_location_code-$last_octet"
    switchboard hq "$(cat /var/lib/switchboard/data/network.hq)" "$current_location_code-$last_octet"
}

# Function to perform a bitwise AND operation
bitwise_and() {
    local bin1=$1
    local bin2=$2
    local and_result=""
    
    for (( i=0; i<${#bin1}; i++ )); do
        and_result+=$(( ${bin1:$i:1} & ${bin2:$i:1} ))
    done
    
    echo "$and_result"
}

# Function to convert IP to binary
ip_to_binary() {
    CONV=({0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1}{0..1})
    
    ip=""
    for byte in $(echo "${1}" | tr "." " "); do
        ip="${ip}${CONV[${byte}]}"
    done
    echo "${ip}"
}

#Function to check if IP is in the same network as gateway
is_same_network() {
    echo -e "Verifying if IP is in the same network as gateway, please hold ........."
    sleep 2
    local ip=$1
    local gateway=$2
    local netmask=$3
    
    # Convert IP, gateway, and subnet mask to binary
    ip_binary=$(ip_to_binary "$ip")
    gateway_binary=$(ip_to_binary "$gateway")
    subnet_mask_binary=$(ip_to_binary "$netmask")
    
    # Perform bitwise AND with subnet mask
    network_ip=$(bitwise_and "$ip_binary" "$subnet_mask_binary")
    network_gateway=$(bitwise_and "$gateway_binary" "$subnet_mask_binary")
    
    # Check if both IP and Gateway belong to the same network
    if [ "$network_ip" = "$network_gateway" ]; then
        echo -e "\e[32mIP in the same network, will continue with the process\e[0m" "\e[32m✔\e[0m"
        sleep 3
        return 0  # Same network
    else
        echo -e "\e[31mThe ip provided would make the media player unreachable.\e[0m"
        sleep 3
        return 1 # not the same network
        
    fi
}

#check ips availability
check_ip_available() {
    local ip="$1"
    local count=3  # Number of pings to send
    echo "Verifying if IP is available, please hold ........."
    # Ping the IP address
    if ping -c $count "$ip" &>/dev/null; then
        echo -e "\e[31mIP\e[0m" "$ip" "\e[31mis already in use. Not changing anything.\e[0m"
        sleep 3
        return 1
    else
        echo -e "\e[32mIP\e[0m" "$ip" "\e[32m is available. Continuing process\e[0m" "\e[32m✔\e[0m"
        sleep 2
        return 0  # IP is available
    fi
}


dhcp_to_static(){
    echo "Changing to static settings"
    #we acquire thet media players network settings
    f_obtain_DHCP_IP
    f_obtain_DHCP_gateway
    f_obtain_DHCP_netmask
    f_obtain_DHCP_nameservers
    #we update variables
    ip_address=$dhcp_IP
    gateway=$dhcp_gateway
    nameservers=$dhcp_nameservers
    netmask=$dhcp_netmask
    last_octet=$(retrieve_last_octet "$ip_address")
    
    #is_same_network "$ip_address" "$gateway" "$netmask"
    change_interface_file
    f_change_hostname
    echo -e "\e[32mSUCCESS, MP changed to static settings. IP adress: $ip_address\e[0m" "\U0001F60A"
    sleep 3
    read -p "Would you like to change the IP adress: $ip_address ? (Y/N): " answer
    if [[ "${answer^^}" == "Y" ]]; then
        echo "Perfect, Re running script to change the Static IP."
        sleep 3
        exit_flag=0
    else
        echo -e "\e[31mKeeping the same IP, good bye\e[0m"
        exit_flag=1
        sleep 3
        #sendreport
    fi
    #network-test
    #sudo systemctl restart networking
}

change_static_IP(){
    local ip=$1
    echo "Changing IP address to ${ip}"
    
    retrieve_static_settings
    
    #update variables with static values
    ip_address=$ip
    gateway=$static_gateway
    nameservers=$static_nameservers
    netmask=$static_netmask
    
    # Check if IP address is available
    if ! check_ip_available "$ip_address" || ! is_same_network "$ip_address" "$gateway" "$netmask"; then
        echo -e "\e[31mPlease review network settings and try again.\e[0m"
        sleep 4
        return 1 #Exit, not changing
    fi
    last_octet=$(retrieve_last_octet "$ip_address")
    echo "using ip address: $ip_address last octet $last_octet"
    change_interface_file
    f_change_hostname
    echo -e "\e[32mSUCCESS, IP changed to $ip_address \e[0m" "\U0001F60A"
    sleep 3
    #sendreport
    #network-test
    exit_flag=1
}

#---------MAIN FUNCTION-------------------
#rm "$0"
while [ "$exit_flag" -ne 1 ]; do
    
    #is the media player in DHCP?
    if grep "$interface_file_path" -e dhcp > /dev/null 2>&1; then
        echo -e "\e[1mMedia player in DHCP.\e[0m"
        read -p "Do you want to implement static settings? (Y/N): " answer
        if [[ "${answer^^}" == "Y" ]]; then
            echo "Perfect, we will change network settings to static for you, will keep the same IP"
            sleep 3
            dhcp_to_static
        else
            echo -e "\e[31mNot doing anything then, good bye\e[0m"
            sleep 2
            exit 0
        fi
    else
        echo -e "\e[1mMEDIA PLAYER is in Static settings\e[0m"
        read -p "To change the IP address, please enter the new IP address: " new_ip_address
        read -p "Confirm the new ip address $new_ip_address (Y/N): " confirm
        if [[ "${confirm^^}" == "Y" ]]; then
            echo -e "\e[32mConfirmed, continuing the process \e[0m"
            sleep 2
            change_static_IP "$new_ip_address"
        else
            echo -e "\e[31mNot doing anything then, good bye\e[0m"
            sleep 2
            exit 0
        fi
    fi
    
done