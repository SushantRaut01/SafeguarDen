#!/bin/bash

if [ `whoami` != 'root' ]
  then
echo "You Must Have Root Privileges To Run This Script (Run As Sudo)"
echo "Usage: sudo ./setup.sh"
exit
fi


    LR='\033[1;31m'
    LG='\033[1;32m'
    LY='\033[1;33m'
    LC='\033[1;36m'
    LW='\033[1;37m'
    NC='\033[0m'
requirements(){
sudo apt-get macchanger || sudo apt install macchanger &> /dev/null 
sudo apt-get install python 
sudo apt-get install tor || sudo apt install tor
sudo apt-get install  proxychains || sudo apt-get install proxychains  

MODULES=("colorama" "subprocess" "sys" "os" "time" "fake_useragent" "selenium" "stem" "webdriver_manager")

if ! command -v pip &> /dev/null
then
    echo -e "${LG}\t [${LG}""${LW}pip${LW}""${LG}]${LG}""${LR}(Not Found !)${LR}""${LW} Installing... ${LW}"
    echo "pip is not installed. Installing pip..."
    sudo apt-get update || sudo apt update  &> /dev/null
    sudo apt-get install python-pip -y || sudo apt install python-pip -y  &> /dev/null
fi
for MODULE_NAME in "${MODULES[@]}"
do
    if python -c "import $MODULE_NAME" &> /dev/null || python3 -c "import $MODULE_NAME" &> /dev/null
    then
        echo -e "${LG}[${LG}""${LW}$MODULE_NAME${LW}""${LG}]${LG}""${LR}-->${LR}""${LW}is already installed. ${LW}"
    else
        echo -e "${LG}[${LG}""${LW}$MODULE_NAME${LW}""${LG}]${LG}""${LR}(Not Found !)${LR}""${LW} Installing... ${LW}"
        sudo pip install $MODULE_NAME 
    fi
done

}

backup(){
  echo -en ${LC}"\n Enter Your Interface :${LC}"
read interface
  if [[ -f /etc/os-release && $(grep -E "^ID=" /etc/os-release | cut -d= -f2) == "kali" ]]
    then
      ifconfig $interface | grep ether | awk '{print$2}' > /usr/share/SafeguardDen/Backup/mac.bak                  
  else 
    ip link show enp0s3 | awk '/ether/ {print $2}' > /usr/share/SafeguardDen/Backup/mac.bak
  fi



timedatectl | grep Time  | awk '{print$3}'   > /usr/share/SafeguardDen/Backup/timezone.bak 
sudo cat /etc/hostname  > /usr/share/SafeguardDen/Backup/hostname.bak
}
reset(){

  sudo cat /usr/share/SafeguardDen/Backup/hostname.bak > /etc/hostname 
  echo -e "${LG}[+]${LG}" "${LW}Hostname Successfully Reset ${LW}" 
  sleep 3
  restore_timezone=$(cat /usr/share/SafeguardDen/Backup/timezone.bak) && timedatectl set-timezone $restore_timezone
  echo -e "${LG}[+]${LG}" "${LW}Time-Zone Successfully Reset ${LW}"
  sleep 3
  echo -n "Enter Your Interface : "
  read u_interface
  restore_Mac=$(cat /usr/share/SafeguardDen/Backup/mac.bak)
  if [[ -f /etc/os-release && $(grep -E "^ID=" /etc/os-release | cut -d= -f2) == "kali" ]]
    then

      ifconfig $u_interface down 2>/dev/null
      ifconfig $u_interface hw ether $restore_Mac 2>/dev/null
      ifconfig $u_interface up 2>/dev/null

      ifconfig $u_interface down 2>/dev/null
      ifconfig $u_interface hw ether $restore_Mac  2>/dev/null 
      ifconfig $u_interface up 2>/dev/null
      sleep 3
  echo -e "${LG}[+]${LG}" "${LW}MAC-ADDRESS Successfully Reset ${LW}"
  else 
    sudo ip link set $u_interface up 2>/dev/null
    sudo ip link set $u_interface address $restore_Mac 2>/dev/null
    sudo ip link set $u_interface down 2>/dev/null

    sudo ip link set $u_interface up 2>/dev/null
    sudo ip link set $u_interface address $restore_Mac 2>/dev/null
    sudo ip link set $u_interface down 2>/dev/null
    sleep 3
    echo -e "${LG}[+]${LG}" "${LW}MAC-ADDRESS Successfully Reset ${LW}"

  fi

}

install(){
  echo -e "${LG}[+]${LG}" "${LW}Selection of installation destination ${LW}"
mkdir /usr/share/SafeguardDen 
mkdir /usr/share/SafeguardDen/Backup
sleep 1
cp -r * /usr/share/SafeguardDen
chmod +x /usr/share/SafeguardDen

}

uninstall(){
  echo -e "${LR}\t [-] User confirmation before starting uninstallation${LR}"
  echo -en ${LR}"Are you sure you want to uninstall the program? (Y/n): ${LR}" 
  read confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
      echo -e "${LR}[-]${LR}""${LR}Removal of program files${LR}"
      rm -rf /usr/share/SafeguardDen
      sleep 3
      echo -en ${LC}"Do you want to Delete Tor-Browser? (Y/n):"${LC}
      read resp
      if [ "$resp" == "y" ] || [ "$resp" == "Y" ];then
       sudo apt-get remove --purge tor torbrowser-launcher
       sleep 3
       echo -e "${LR}[-] Tor-Browser Delete Successfully${LR}"
      else
        echo -e "${LG}[-]${LG}""${LW} Removing Tor-Browser was Cancled${LW}"
      fi
      sleep 3
        echo -e "${LG}[+]${LG}""${LW}SafeguardDen removed Succesfully${LW}"
fi 

}

if [ "$1" == "" ] 
  then
    echo "Usage: sudo ./setup.sh  install OR uninstall OR reinstall"
elif [ $1 == "install" ] 
  then
     echo -e "${LG}\n [+]${LG}" "${LW}Verification of system requirements\n${LW}"
     sleep 3
  requirements
  sleep 3
  echo -e "${LG}\n[+]${LG}" "${LW}Initialization of the installation process ${LW}"
  install
  sleep 3
  echo -e "${LG}[+]${LG}" "${LW}Getting Backup of All Required Files ${LW}"
  backup
  sleep 3

elif [ $1 == "uninstall" ] 
  then
      reset
      uninstall
elif [ $1 == "reinstall" ] 
  then
      requirements
else 
  echo -e "Error"
fi

  
