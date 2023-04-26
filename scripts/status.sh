#!/bin/bash


    LR='\033[1;31m'
    LG='\033[1;32m'
    LY='\033[1;33m'
    LC='\033[1;36m'
    LW='\033[1;37m'
    NC='\033[0m'

log_list=(
"~/.bash_history"
"~/.zsh_history"
"/var/log/cron.log"
"/var/log/auth.log"
"/var/log/auth.log.1"
"/var/log/dpkg.log"
"/var/log/messages"
"/var/log/mail.log"
"/var/log/wtmp"
"/var/log/lastlog"
"/var/log/syslog"
"/var/log/user.log.1"
"/var/log/syslog.1"
"/var/log/kern.log"
"/var/log/faillog"
"/var/log/daemon.log"
"/var/log/debug"
"/var/log/debug.1"
"/var/log/boot.log"
"/var/log/kern.log"
"/var/log/kern.log"
)

not_cleared=0

for log in ${log_list[@]}; do
  if [ -f "$log" ]; then
    if [ -s "$log" ]; then
      not_cleared=1
      break
    fi
  fi
done
if [ $not_cleared -eq 1 ]; then
  echo -e ${LG}"\nSystem Logs       : "${LG}${LR}"[ "${LR} ${LR}"NOT CLEARED"${LR}${LR}" ] "${LR}
else
  echo -e ${LG}"System Logs       : "${LG}${LR}"[ "${LR} ${LW}"ALL CLEARED"${LW}${LR}" ] "${LR}

fi

if [[ -f /etc/os-release && $(grep -E "^ID=" /etc/os-release | cut -d= -f2) == "kali" ]]
    then
      echo -e ${LG}"New MacAddress    : "${LG}${LR}"[ "${LR} ${LW}`ifconfig eth0 | grep ether |awk '{print$2}'`${LW}${LR}" ] "${LR}
else 
      echo -e ${LG}"New MacAddress    : "${LG}${LR}"[ "${LR} ${LY}`ip link show enp0s3 | awk '/ether/ {print $2}'`${LY}${LR}" ] ""\n"${LR}
fi
echo -e ${LG}"\nNew Hostname      : "${LG} ${LW}"`cat /etc/hostname`"${LW} 2>/dev/null
echo -e ${LG}"\nUpdated Time-Zone : "${LG} ${LW}"`timedatectl | grep Time  | awk '{print$3}' `"${LW} 2>/dev/null
echo -e ${LG}"Universal Time    : "${LG} ${LW}"`timedatectl | grep Universal`"${LW} 2>/dev/null


user=$(users | awk '{print$1}')
if [ -d "/usr/share/torbrowser-launcher" ] ; 
  then
  echo -e "${LG}\n[+]${LG}${LW} Tor-browser successfully Installed ${LW}"
else
  echo -e "${LR}\n[+]${LR}${LW} Tor-browser Not Installed ${LW}"
  echo -en "${LG}Do you want to install tor-browser?(Y/n) :${LG}"
  read resp
  if [[ "$resp" == "y" || "$resp" == "Y" ]]; then
    sudo apt-get install tor torbrowser-launcher
    clear
    sudo -u $user torbrowser-launcher 2>&1 &
    echo -e "${LG}\n[+]${LG}" "${LW}Tor-Browser Successfully Installed. ${LW}"
  elif [[ "$resp" == "n" || "$resp" == "N" ]]; then
      echo -e "${LR}\n[-]${LR}" "${LW}Tor-Browser Installation has been Canceled ${LW}"
    fi
     

fi


