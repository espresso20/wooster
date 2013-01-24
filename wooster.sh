#!/bin/bash

#Display colorized information output
function g1() {
        COLOR='\033[01;33m'     # bold yellow
        RESET='\033[00;00m'     # normal white
        MESSAGE=${@:-"${RESET}Hold PLEASE!"}
        echo -e "${COLOR}${MESSAGE}${RESET}"
}
# Display colorized warning output
function g2() {
        COLOR='\033[01;31m'     # bold red
        RESET='\033[00;00m'     # normal white
        MESSAGE=${@:-"${RESET}ALL DONE!"}
        echo -e "${COLOR}${MESSAGE}${RESET}"
}
# Distplays colorized warning output
function g3() {
        COLOR='\e[1;32m'        #Bold Green
        RESET='\033[00;00m'     # normal white
        MESSAGE=${@:-"${RESET}ALL DONE!"}
        echo -e "${COLOR}${MESSAGE}${RESET}"
}
# Distplays colorized warning output
function g4() {
        COLOR='\e[1;32m"'          #Bold Blue
        RESET='\033[00;00m'     #normal white
        MESSAGE=${@:-"${RESET}ALL DONE!"}
        echo -e "${COLOR}${MESSAGE}${RESET}"
}

# Displays colorized wrning output.
#This keeps a uninformed user from wipeing a good log out.
#yes to continue no to exit if not sure
function ConfirmOrExit() {
        while true
                do
                        g2 -n "Are you finished?! (y or n) :"
                        read CONFIRM
                        case $CONFIRM in
                        y|Y|YES|yes|Yes) break ;;
                        n|N|no|NO|No)
                        g1 "The Gerbal finds no intrest in your puny attempts!" $CONFIRM
                        exit
                        ;;
                        *) g2 "Please enter only y or n to Please the Gerbal"
                        esac
                        done
                        g1 "$CONFIRM. Continuing ..."
}


function continueornot() {
        while true
                do
                         g2 -n "Do you wish to continue? (y or n)"
                         read CONFIRM
                         case $CONFIRM in
                         y|Y|YES|yes|Yes) break ;;
                         n|N|no|NO|No)
                         g1 "Gerbal says Goodby then !" $CONFIRM
                         exit
                         ;;
                         *) g2 "please enter only y or n"
                         esac
                         done
                         g1 "Continuing!" $CONFIRM
}

#welcome message
g3 "Welcome to Gerbal!, a script writen to make YOUR life easier."
    sleep 3
g3 "This script will help you to do task on the server with some automation."
    sleep 3
g3 "Keep in mind it only does what you TELL, it to do ;) "
continueornot

#start with checking uptime!
    sleep 3
g4 "Checking server uptime..."
        uptime
    sleep 1
continueornot

#check free memory 
g4 "Checking free memory..."
        free -t -m
continueornot

#checking for memory in consumption
g4 "Checking Memory Usage"
        egrep -h --color 'Mem|Cache|Swap' /proc/meminfo
g3 "all done with memory checks!"
continueornot

#checking diskspace 
g4 "Checking server disk space"
        df -h
continueornot

#checking amount of disk used per user account
g4 "Checking disk usage for /home directories"
g1 "Disk useage on user minecraft"
        du -sh /home/minecraft
g1 "Disk useage on user root"
        du -sh /root
g1 "Disk useage on user bobmarker"
        du -sh /home/bobmarker
g1 "Disk useage on user monkey"
        du -sh /home/monkey
g1 "Disk useage on user andrewph"
        du -sh /home/andrewph
g4 "disk useage print out done"

g4 "read your profile's Disk useage printout, if it seems overly large, please consider cleaning up your home directory ;) thx!"
continueornot

#checking ports open on server
g4 "checking what ports are open on server!"
        netstat -tulpn
    sleep 3
continueornot

g4 "Checking on ping to outside"
    sleep 2
        ping www.google.com -c 3
#added ping alert- can send to mail.
continueornot

#This part is based on debian build for aptitude and apt-get controls
#will have to be changed if used on a CentOS build

g4 "OK now for the fun stuff!!"

#asks if you have a debain kernal installed, if not; exits
function debianornot() {
        while true
                do
                        g2 -n "Are you running a Debian build? (y or n) :"
                        read CONFIRM
                        case $CONFIRM in
                        y|Y|YES|yes|Yes) break ;;
                        n|N|no|NO|No)
                        g1 "I'm sorry, Gerbal perfers Debian builds at the moment only, Try back later" $CONFIRM
                        exit
                        ;;
                        *) g2 "Please enter only y or n"
                        esac
                        done
                        g1 "Starting Updates now $CONFIRM."
}

#run Warning about debian build, if yes continue to next session
debianornot

#ask if you want to install updates if not; exits
function timetoexit() {
        while true
                do
                        g2 -n "The next section will run updated to os and system. Do you wish to proceed with this? (y or n) :"
                        read CONFIRM
                        case $CONFIRM in
                        y|Y|YES|yes|Yes) break ;;
                        n|N|no|NO|No)
                        g1 "We are done then!" $CONFIRM
                        exit
                        ;;
                        *) g2 "Please enter only y or n"
                        esac
                        done
                        g1 "starting Aptitude for updates $CONFIRM. Continuing ..."
}

#run warning about apt-get update, if yes continue with updates 
timetoexit

g3 "running updates to server deb packages"
        apt-get update

g3 "running upgrades to server systems from deb packages"
        #insert auto yes for packages updates
        apt-get upgrade -y

g3 "running aptitude for checksum"
        #aptitude is better version of apt-get (more control), run both for diff.
        aptitude update

g3 "updating packages on aptitued recomendation"
        #aptitude auto yes
        aptitude upgrade -y
ConfirmOrExit
