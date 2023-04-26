#!/bin/bash

	LR='\033[1;31m'
    LG='\033[1;32m'
    LY='\033[1;33m'
    LC='\033[1;36m'
    LW='\033[1;37m'
    NC='\033[0m'

user=$(users | awk '{print$1}')
if [ -d "/usr/share/torbrowser-launcher" ] ; 
	then
		sudo -u $user torbrowser-launcher &> /dev/null
		echo -e "${LG}[+]${LG}" "${LW} Opening Tor-Browser ${LW}" 
else 
	
	echo -en "${LG}Do you want to install tor-browser?(Y/n) :${LG}"
	read resp
	if [[ "$resp" == "y" || "$resp" == "Y" ]]; then
		sudo apt-get install tor torbrowser-launcher
		sudo -u $user torbrowser-launcher &> /dev/null
		echo -e "${LG}[+]${LG}" "${LW}Tor-Browser Successfully Installed. ${LW}"
	elif [[ "$resp" == "n" || "$resp" == "N" ]]; then
    echo -e "${LR}[-]${LR}" "${LW}Tor-Browser Installation Canceled ${LW}"
		 
	fi
fi