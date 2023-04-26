#!/bin/bash

# Developer is Not Responsible For Misuse of this Script.
	user=$(whoami)
wget https://dist.torproject.org/torbrowser/12.0.4/tor-browser-linux64-12.0.4_ALL.tar.xz
pcd=$(pwd)
file=$(find -L $pcd  -name "*.tar.xz")
tar -xf $pcd
sudo mv tor-browser /opt
cd /opt/tor-browser
./start-tor-browser.desktop --register-app

echo "Do you want to create a desktop shortcut? (Y/n)"
read resp
if [[ "$resp" == "y" || "$resp" == "Y" ]]; then
	sudo cp start-tor-browser.desktop /home/$user/Desktop
fi



wget https://dist.torproject.org/torbrowser/12.0.4/tor-browser-linux64-12.0.4_ALL.tar.xz 
	










	#!/bin/bash

	LR='\033[1;31m'
    LG='\033[1;32m'
    LY='\033[1;33m'
    LC='\033[1;36m'
    LW='\033[1;37m'
    NC='\033[0m'

if [ -d "/opt/tor-browser" ] ; 
then

    cd /opt/tor-browser
    ./start-tor-browser.desktop 
    echo -e "${LG}[+]${LG}" "${LW} Opening Tor-Browser ${LW}" 
else 
	user=$(whoami)
	user2=$(users | awk '{print$1}')
	file=$(find -L /usr/share/SafeguardDen/  -name "*.tar.xz")
	tar -xf $file
	sudo mv tor-browser /opt
	echo -e "${LW}Copy below command and Paste it on New terminal ${LG}(Make sure Do not run as root!)${LG}${LW}"
	echo -e "${LR}[${LR}""${LW}cd /opt/tor-browser/start-tor-browser.desktop --register-app${LW}""${LR}]${LR}"
	echo -e ${LC}"Do you want to create a desktop shortcut? (Y/n) :"${LC}
	sudo -u "$user2"cd /opt/tor-browser/
	sudo -u "$user2"./start-tor-browser --register-app
	
	echo -e ${LC}"Do you want to create a desktop shortcut? (Y/n)"${LC}
	read resp
	if [[ "$resp" == "y" || "$resp" == "Y" ]]; then
		sudo cp start-tor-browser.desktop /home/$user/Desktop
	fi
	echo -e "${LG}[+]${LG}" "${LW}Tor-Browser Successfully Installed${LW}" 
fi