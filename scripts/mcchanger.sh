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



sudo sed -i 's/managed=false/managed=true/g' /etc/NetworkManager/NetworkManager.conf
mac_changer(){
echo -n "Enter Your Interface : "
read interface
venID=$(shuf -n 1 /usr/share/SafeguardDen/resources/vendormac.txt | awk '{print$3}')
ranID=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
macAdd="$venID:$ranID"
echo -e ${LR}"Old   : "${LR}${LR}"[ "${LR} ${LW}`ifconfig eth0 | grep ether |awk '{print$2}'`${LW}${LR}" ] "${LR}
ifconfig $interface down 2>/dev/null
ifconfig $interface hw ether "$macAdd" 2>/dev/null
ifconfig $interface up 2>/dev/null
        
ifconfig $interface down 2>/dev/null
ifconfig $interface hw ether $macAdd 2>/dev/null 
ifconfig $interface up 2>/dev/null

echo -e "${LC}[+]${LC}" "${LW} Genrating MacAddress...${LW}"
echo -e ${LG}"New   : "${LG}${LR}"[ "${LR} ${LY}`ifconfig eth0 | grep ether |awk '{print$2}'`${LY}${LR}" ] "${LR}
}
if [[ -f /etc/os-release && $(grep -E "^ID=" /etc/os-release | cut -d= -f2) == "kali" ]]
    then
        mac_changer
else 

venID=$(shuf -n 1 /usr/share/SafeguardDen/resources/vendormac.txt | awk '{print$3}')
ranID=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
macAdd="$venID:$ranID"


    echo -n "Enter Your Interface : "
    read interface
    echo -e ${LR}"\nOld   : "${LR}${LR}"[ "${LR} ${LW}`ip link show $interface | awk '/ether/ {print $2}'`${LW}${LR}" ] "${LR}

    sudo ip link set $interface up 2>/dev/null
    sudo ip link set $interface address $macAdd 2>/dev/null
    sudo ip link set $interface down 2>/dev/null

    sudo ip link set $interface up 2>/dev/null
    sudo ip link set $interface address $macAdd 2>/dev/null
    sudo ip link set $interface down 2>/dev/null
    echo -e ${LG}"New   : "${LG}${LR}"[ "${LR} ${LY}`ip link show $interface | awk '/ether/ {print $2}'`${LY}${LR}" ] ""\n"${LR}



fi

progreSh 100 
sleep 1
echo -e "${LG}[+]${LG}" "${LW}MAC-ADDRESS Successfully Changed${LW}" 


