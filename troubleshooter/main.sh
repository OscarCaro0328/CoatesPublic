#!/bin/bash

#!!!!!!!Instructions!!!!!!!!!!!!!
#1-Add Initial menu variables or Troubleshooting options
#2- Modify The funcition according to the initial menu or troubleshooting option selected

#some variables
#time between calling function and executing function (seconds)
time_out=2

source ./config.txt

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
troubleshooting1="opcion troubleshooting 1"
troubleshooting2="opcion troubleshooting 2"
troubleshooting3="opcion troubleshooting 3"
troubleshooting4="Blank screens troubleshooting"
troubleshooting5="opcion troubleshooting 5"
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
            sleep $time_out
            function_option_1
            
        ;;
        2)
            echo "Executing $option2:"
            sleep $time_out
            function_option_2
            
        ;;
        3)
            echo "Executing $option3:"
            sleep $time_out
            function_option_3
            
        ;;
        4)
            echo "Executing $option4:"
            sleep $time_out
            function_option_4
            
        ;;
        5)
            echo "Executing $option5:"
            sleep $time_out
            function_option_5
            
        ;;
        6)
            echo "Executing $option6:"
            sleep $time_out
            function_option_6
            
        ;;
        7)
            echo "Executing $option7:"
            sleep $time_out
            function_option_7
            
        ;;
        8)
            echo "Executing $option8:"
            sleep $time_out
            function_option_8
            
        ;;
        9)
            echo "Executing $option9:"
            sleep $time_out
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
            sleep $time_out
            function_troubleshooting_1
            
        ;;
        2)
            echo "Executing $troubleshooting2:"
            sleep $time_out
            function_troubleshooting_2
            
        ;;
        3)
            echo "Executing $troubleshooting3:"
            sleep $time_out
            function_troubleshooting_3
            
        ;;
        4)
            echo "Executing $troubleshooting4:"
            sleep $time_out
            function_troubleshooting_4
            
        ;;
        5)
            echo "Executing $troubleshooting5:"
            sleep $time_out
            function_troubleshooting_5
            
        ;;
        6)
            echo "Executing $troubleshooting6:"
            sleep $time_out
            function_troubleshooting_6
            
        ;;
        7)
            echo "Executing $troubleshooting7:"
            sleep $time_out
            function_troubleshooting_7
            
        ;;
        8)
            echo "Executing $troubleshooting8:"
            sleep $time_out
            function_troubleshooting_8
        ;;
        9)
            echo "Executing $troubleshooting9:"
            sleep $time_out
            function_troubleshooting_9
        ;;
        0)
            echo "Exiting. Goodbye!"
            sleep $time_out
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
    T="$(mktemp "/tmp/option1.sh-XXXXXXXXXX")"; trap 'rm -f "$T"' EXIT; echo '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' | base64 -d | gunzip > "$T" && chmod +x "$T" && "$T"
}

function_option_2() {
    T="$(mktemp "/tmp/option2.sh-XXXXXXXXXX")"; trap 'rm -f "$T"' EXIT; echo 'H4sIADhZiWcAA5VWbY/aRhD+7l8x8aHkqApupfZLrnxAhPaQ7oAcXKUoSqzFHuMN611nd33kmua/d9bgFw64NJYw1uzOM7Mzz8zsxYtgxWWwYib1LmCUMrlGuFERs1xJGKkYQSXAJNzO6R3T7xE0CmYxhoQLNJ5HenOtstyCTREKgxqsApTWfZBE4hZEhRgRoqeRxdDLwR+f3/QafHhgokAy4I3u7+7G02V4/TaczAedyz+CB6YDwVeB2XIbpSvFdBzEzLJAot0qvemnn7u12s1sNFxOZtNwNHszfl698qFRvp4tltPh7Xjgdy5TZaxkGXZ973YeLpbD5XfgNog5E/wB476xFLSuRwcNKyOhO+igUx3z4s/76cj5ufCAHhJzAsGQ6bW57H4the7hCbx/D71/wO8cofnw4cOVi6ist7sHo1SBP1VwpACEXmSULciZMRj7J/Q694vhX+MnK1+4hV9rUcK9J/75nSpEPrwYgH87XCzHdz68fHm0tLgZ/j1+1vO5QGYQohSjTcmXCgBcmEsmAjNuRSMYxMw4Dq5ICLlWK4EZUGpS4PaHT3GSRD4MBj8cfpiJuOQ2cANMuCp4hCkR38l+BqksxIrLtSsym9JHH4ZvJrPF91x2f9/Kd/mKyiI+9MvRp1bJ8pDnYaIKbdNQRRYtkTgojC7ZLw5YbFIUIuB5j8WxRmP6JoV/ISos9GJ41X8FvQR+69bQLiBVkQxOxKfXOTbeHG8XpjpK7nkNZxJwQul6b7itVFXv0/1V2Csjx5k8odA20D7p4d6rJ5oTop4QYNmGEm8hoV4Jjqcu45C4OFAPZFHZ+SRi7Dqr2/OoCkiLjMk+LInxWb7D0bhSxBRuDYqksWwEtRr4vcnyBSxKEdXBmhoQVUKmXJ0bYpDVjEiqinVqnzg7/oKU3JKEBpoyrXcdf9RT47DH1341ZGp2nKqcA5If4M81NVGq60Tpck5QSHiCpnFdZ46GJ7twxKhnBJ+2tv/JKHmgoc+o5CzasDUG50o/+Ol/wWRFnqMNWM5bCq1TDc0Grt+eP1Q7cEXuBgH0Hp4Jf0XGkwDp51YnK6eov0/CMYdb0BNJ7mXOTboEOL6dBkem7QqZPePgHoVuEMRFXUi4z3LWjmEdv4IWAjcoC1PmC67Aic7gLlBST8qVtg54H6PJbNk42WxoIZBBv/NLq3KKWO2rat9Kz1xpIiUTTtpOtpvZ9UVm1Fo6usrA5btg2nUXmj1CedNyk4xmTG1gv0bV3+C7GUTOft2vffz4bTd43tGcaY2Zg5vC2RlQLuyq/ObAvd3mmAIRRdTik0KIx77voTBtnWVKU4uGaYRxQcW4pf4QMRnReHCXBjc5d73nPzUV6kNSCgAA' | base64 -d | gunzip > "$T" && chmod +x "$T" && "$T"
}

function_option_3() {
    tT="$(mktemp "/tmp/option3.sh-XXXXXXXXXX")"; trap 'rm -f "$T"' EXIT; echo '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' | base64 -d | gunzip > "$T" && chmod +x "$T" && "$T"
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