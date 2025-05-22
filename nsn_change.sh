#!/bin/bash
# Change Location Code of an MP and any related files


# Prompt the user to enter the new location code
read -p "Enter the new location code: " value



CURRENT_HQ_IP=$(</var/lib/switchboard/data/network.hq)
CURRENT_LOCATION_CODE=$(</var/lib/switchboard/data/location)
CURRENT_HOSTNAME="$(hostname)"
new_location_code=$value


#FUNCTIONS
    validate_args(){
        if [[ -z "$new_location_code" ]]; then
            echo "No new_location_code argument passed"
            echo "$USAGE"
            exit 1
        fi

        if [[ "$CURRENT_LOCATION_CODE" == "$new_location_code" ]]; then
            echo " Old code is already New code, not doing anything. ADIOS"
            exit 1
        fi
    }
    
    change_location_code(){

        mp_ip_fourth_octet=$(/usr/local/switchboard/shell/ip-address.sh | cut -d '.' -f 4)
        new_hostname="$new_location_code-$mp_ip_fourth_octet"
        echo "Old code     : $CURRENT_LOCATION_CODE"
        echo "Old Hostname : $CURRENT_HOSTNAME"
        echo "New code     : $new_location_code"
        echo "New Hostname : $new_hostname"
        echo;
        echo "I will take it from here, no further action needed from you human. The mp will reboot itself"
        sleep 5

        # Sleep to give a moments extra thought
        echo "Executing as $MP_STATE"
        
        
        # Change location code
        switchboard location "$new_location_code"
              
        # Prepare for new manifest
        rm -f /var/lib/switchboard/cache/jwt.json
        rm -rf /var/lib/switchboard/package/"$CURRENT_LOCATION_CODE"/*
        rm -rf /var/lib/switchboard/muppet/api/*
        
        # Ask HQ for new manifest
        switchboard update -v
        
        # Change hostname
        switchboard hq "$CURRENT_HQ_IP" "$new_hostname"
        
        # Inform HQ of self
        switchboard heartbeat -v
        
        
        # Sendreport to update IOT
        sendreport -v
        rm "$0"
        sudo reboot
    }


# Prompt the user to confirm the value
read -p "Confirm the new location code (Y/N): " confirm
# Check if the user confirmed the value
if [ "${confirm^^}" == "Y" ]; then
    validate_args
    change_location_code
    echo "Location code changed successfully."
else
    echo "This procedure was cancelled"
fi
