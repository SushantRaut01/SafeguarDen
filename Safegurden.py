#!/usr/bin/python
from colorama import Fore, Back, Style
import subprocess,sys
import os

if not os.geteuid() == 0:
    print("\nMake sure You run This Script After ./setup.sh\n")
    print("Usage: sudo ./Safeguarden.py")
    sys.exit("\nYou Must Have Root Privileges To Run This Script (Run As Sudo)\n")
    
os.system('clear')

os.system('clear')
def main():
    print(Fore.CYAN + '''
 __________________________________________________________________________________________________    
│                                                                                                  │
│                                                                                                  │
│    ███████  █████  ███████ ███████  ██████  ██    ██  █████  ██████  ██████  ███████ ███    ██   │
│    ██      ██   ██ ██      ██      ██       ██    ██ ██   ██ ██   ██ ██   ██ ██      ████   ██   │
│    ███████ ███████ █████   █████   ██   ███ ██    ██ ███████ ██████  ██   ██ █████   ██ ██  ██   │
│         ██ ██   ██ ██      ██      ██    ██ ██    ██ ██   ██ ██   ██ ██   ██ ██      ██  ██ ██   │
│    ███████ ██   ██ ██      ███████  ██████   ██████  ██   ██ ██   ██ ██████  ███████ ██   ████   │
│                                                                                                  │
│__________________________________________________________________________________________________│
    ''')
    print(Fore.WHITE+"     ╔════════════════════════════════════════════════╗")
    print(Fore.WHITE+"     ║"+Fore.YELLOW + "✱  " + Fore.WHITE + "Purpose   " + Fore.RED + ":" + Fore.GREEN + " Stay Safe And Secured          "+Fore.WHITE + "  ║")
    print(Fore.WHITE+"     ║"+Fore.YELLOW + "✱  " + Fore.WHITE + "Coded By  " + Fore.RED + ":" + Fore.GREEN + " ANuJ & SUsh4Nt                   "+Fore.WHITE+"║")
    print(Fore.WHITE+"     ║"+Fore.YELLOW + "✱  " + Fore.WHITE + "Github    " + Fore.RED + ":" + Fore.GREEN + " https://github.com/SushantRaut01 "+Fore.WHITE+"║")
    print(Fore.WHITE+"     ║"+Fore.YELLOW + "✱  " + Fore.WHITE + "Languages " + Fore.RED + ":" + Fore.BLUE + " Python,Shell                     "+Fore.WHITE+"║")
    print(Fore.WHITE+"     ║"+Fore.YELLOW + "✱  " + Fore.WHITE + "Licence   " + Fore.RED + ":" + Fore.GREEN + " G.P.L SAFEGUARDEN                "+Fore.WHITE+"║")
    print(Fore.WHITE+"     ║"+Fore.YELLOW + "✱  " + Fore.WHITE + "Version   " + Fore.RED + ":" + Fore.BLUE + " 1.0                              "+Fore.WHITE+"║")
    print(Fore.WHITE+"     ╚════════════════════════════════════════════════╝")

    print("     ║"+Fore.RED+"["+Fore.GREEN+"✔"+Fore.RED+"] "+Fore.WHITE+"Name "+Fore.RED+":"+Fore.BLUE+" ANUJ GHOM & SUSHANT RAUT")
    # print(Fore.WHITE+"     ║"+Fore.RED+"["+Fore.GREEN+"✔"+Fore.RED+"] "+Fore.WHITE+"ID "+Fore.RED+":"+Fore.BLUE+" ")
    print(Fore.WHITE+"     ╚═════════════════════════════════════════════════")

    print("     --"+Fore.RED+">"+Fore.GREEN+" 1."+Fore.WHITE+" Browse Anonymously")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 2."+Fore.WHITE+" MAC-ADDR Change")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 3."+Fore.WHITE+" Host-Name Change")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 4."+Fore.WHITE+" Time-zone Change")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 5."+Fore.WHITE+" IP Change")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 6."+Fore.WHITE+" Use tor Browser")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 7."+Fore.WHITE+" log Clean")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 8."+Fore.WHITE+" Status")
    print("     --"+Fore.RED+">"+Fore.GREEN+" 9."+Fore.WHITE+" Reset "+Fore.RED+"["+Fore.RED+Fore.WHITE+"Reset All Settings"+Fore.WHITE+Fore.RED+"]"+Fore.RED)
    print("     --"+Fore.RED+">"+Fore.GREEN+" 0."+Fore.WHITE+" Exit the Program\n")


if __name__ == '__main__':
    main()
    while True :
        user_input = int(input(Fore.BLUE+"Enter Your Choice: "+Fore.BLUE))
        if user_input == 1 :
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/proxyWindow.py'])
        elif user_input == 2:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/ip_changer'])
        elif user_input == 3:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/hostname.sh'])
        elif user_input == 4:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/timezone_changer.sh'])
        elif user_input == 5:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/mcchanger.sh'])
        elif user_input == 6:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/tor_browser.sh'])
        elif user_input == 7:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/log_cleaner.sh'])
        elif user_input == 8:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/status.sh'])
        elif user_input == 9:
            subprocess.call(['bash','/usr/share/SafeguardDen/scripts/reset.sh'])
        elif user_input == 0:
            os.system('clear')
            sys.exit()
        else :
            print(Fore.RED+ "Please Select correct Option ! "+Fore.RED)


