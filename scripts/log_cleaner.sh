#!/bin/bash

    LR='\033[1;31m'
    LG='\033[1;32m'
    LY='\033[1;33m'
    LC='\033[1;36m'
    LW='\033[1;37m'
    NC='\033[0m'

progreSh() {
    
    SEC=`echo "Progress"`
    PRC=`printf "%.0f" ${1}`
    SHW=`printf "%3d\n" ${PRC}`
    LNE=`printf "%.0f" $((${PRC}/2))`
    LRR=`printf "%.0f" $((${PRC}/2-12))`; if [ ${LRR} -le 0 ]; then LRR=0; fi;
    LYY=`printf "%.0f" $((${PRC}/2-24))`; if [ ${LYY} -le 0 ]; then LYY=0; fi;
    LCC=`printf "%.0f" $((${PRC}/2-36))`; if [ ${LCC} -le 0 ]; then LCC=0; fi;
    LGG=`printf "%.0f" $((${PRC}/2-48))`; if [ ${LGG} -le 0 ]; then LGG=0; fi;
    LRR_=""
    LYY_=""
    LCC_=""
    LGG_=""
    for ((i=1;i<=13;i++))
    do
        DOTS=""; for ((ii=${i};ii<13;ii++)); do DOTS="${DOTS}."; done
        if [ ${i} -le ${LNE} ]; then LRR_="${LRR_}#"; else LRR_="${LRR_}."; fi
        echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${DOTS}${LY}............${LC}............${LG}............ ${SHW}%${NC}\r"
        if [ ${LNE} -ge 1 ]; then sleep .05; fi
    done
    for ((i=14;i<=25;i++))
    do
        DOTS=""; for ((ii=${i};ii<25;ii++)); do DOTS="${DOTS}."; done
        if [ ${i} -le ${LNE} ]; then LYY_="${LYY_}#"; else LYY_="${LYY_}."; fi
        echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${DOTS}${LC}............${LG}............ ${SHW}%${NC}\r"
        if [ ${LNE} -ge 14 ]; then sleep .05; fi
    done
    for ((i=26;i<=37;i++))
    do
        DOTS=""; for ((ii=${i};ii<37;ii++)); do DOTS="${DOTS}."; done
        if [ ${i} -le ${LNE} ]; then LCC_="${LCC_}#"; else LCC_="${LCC_}."; fi
        echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${LC}${LCC_}${DOTS}${LG}............ ${SHW}%${NC}\r"
        if [ ${LNE} -ge 26 ]; then sleep .05; fi
    done
    for ((i=38;i<=49;i++))
    do
        DOTS=""; for ((ii=${i};ii<49;ii++)); do DOTS="${DOTS}."; done
        if [ ${i} -le ${LNE} ]; then LGG_="${LGG_}#"; else LGG_="${LGG_}."; fi
        echo -ne "  ${LW}${SEC}  ${LR}${LRR_}${LY}${LYY_}${LC}${LCC_}${LG}${LGG_}${DOTS} ${SHW}%${NC}\r"
        if [ ${LNE} -ge 38 ]; then sleep .05; fi
    done
}

log_list=(
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

sh_history(){
for home in /home/*/; do
  bash_history="${home}.bash_history"
  zsh_history="${home}.zsh_history"
  
  if [ -f "${bash_history}" ] && [ -s "${bash_history}" ]; then
    cat /dev/null > "${bash_history}"
  fi
  
  if [ -f "${zsh_history}" ] && [ -s "${zsh_history}" ]; then
    cat /dev/null > "${zsh_history}"
  fi
done
}

function clear_log_files() {
  for log in "${log_list[@]}"; do
    if [ -f "$log" ]; then
      truncate -s 0 "$log"
    fi
  done
}

function prompt_user_to_clear_logs() {
  existing_logs=()
  for log in "${log_list[@]}"; do
    if [ -f "$log" ]; then
      existing_logs+=("$log")
    fi
  done

  if [ ${#existing_logs[@]} -eq 0 ]; then
    echo "No log files found."
  else
    echo -e "${LG}[+]${LG}"${LW}" The following log files will be cleared:"${LW}
    for log in "${existing_logs[@]}"; do
      echo -e ${LR}"- $log"${LR}
    done
    echo -en ${LC}" Do you want to clear these log files? (y/n): "${LC}
    read clear_logs
    if [ "$clear_logs" == "y" ] || [ "$clear_logs" == "Y" ]; then
      clear_log_files
      sh_history
      progreSh 100  
      sleep 1
      echo -e "${LG}\n[+]${LG}${LW} All log successfully Cleaned \n${LW}"

    else
      echo -e "${LR}\n[-]${LR}"${LR}" Log files will not be cleared.\n"${LR}
    fi
  fi
}

prompt_user_to_clear_logs
