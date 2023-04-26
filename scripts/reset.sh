#!/bin/bash

	LR='\033[1;31m'
    LG='\033[1;32m'
    LY='\033[1;33m'
    LC='\033[1;36m'
    LW='\033[1;37m'
    NC='\033[0m'


reset(){

  sudo cat /usr/share/SafeguardDen/Backup/hostname.bak > /etc/hostname 
  echo -e "${LG}[+]${LG}" "${LW}Hostname Successfully Reset ${LW}" 
  sleep 3
  restore_timezone=$(cat /usr/share/SafeguardDen/Backup/timezone.bak) && timedatectl set-timezone $restore_timezone
  echo -e "${LG}[+]${LG}" "${LW}Time-Zone Successfully Reset ${LW}"
  sleep 3
  echo -n "Enter Your Interface : "
  read u_interface
  ifconfig $u_interface down 2>/dev/null
  restore_Mac=$(cat /usr/share/SafeguardDen/Backup/mac.bak)
  ifconfig $u_interface hw ether $restore_Mac 2>/dev/null
  ifconfig $u_interface up 2>/dev/null

  ifconfig $u_interface down 2>/dev/null
  ifconfig $u_interface hw ether $restore_Mac  2>/dev/null 
  ifconfig $u_interface up 2>/dev/null
  sleep 3
  echo -e "${LG}[+]${LG}" "${LW}MAC-ADDRESS Successfully Reset ${LW}"


}
reset