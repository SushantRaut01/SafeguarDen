import time
import sys
from fake_useragent import UserAgent
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from stem import Signal
from stem.control import Controller
from selenium.webdriver.firefox.service import Service as FirefoxService
from webdriver_manager.firefox import GeckoDriverManager




def usage():
    print("\n\n[Welcome to Help Menu]")
    print("[Usage]: python3 input-test.py parameter\n")
    print("[Parameters]")
    print("-h      --> To show this Menu")
    print("pl      --> To provide Proxy list Ex pl proxy.txt")
    print("ip port --> To provide perticular ip and port Ex ip 127.0.0.1 port 80")
    print("w$      --> Number of windows you want to open\n\n")

def take_input(ip, port):
    ip_port = []
    ip_port.append(ip)
    ip_port.append(port)
    return ip_port

def proxy_operation(proxy,count):
    try:
        proxy_list = proxy.split(":")
        ip = proxy_list[0]
        port = int(proxy_list[1])
        headers = {"User-Agent": UserAgent().random}

        options = Options()
        options.set_preference("network.proxy.type", 1)
        options.set_preference("network.proxy.ssl", ip)
        options.set_preference("network.proxy.ssl_port", port)
        options.set_preference("network.proxy.http", ip)
        options.set_preference("network.proxy.http_port", port)
        options.set_preference("general.useragent.override", str(headers))
        print(f'Opening Browser for {ip}:{port}')
        driver = webdriver.Firefox(service=FirefoxService(GeckoDriverManager().install()))

        print("Changing IP Address...")
        print("Wait for 10 sec")
        print("Page is loading...")

        driver.get("https://ipleak.net")
        time.sleep(5)

        print("Page loaded Successfully\n")
        count = count + 1
        return count
    except:
        driver.quit()
        print("\nProxy is not working\nChanging Proxy...\n")
        return count

if __name__ == "__main__":
    a = sys.argv
    if (len(a) == 1 or a[1] == "--help" or a[1] == "-h"):
        usage()
        exit()
    elif a[1] == "pl":
        file_name = a[2]
        w = a[3].split('w')
        with open(file_name, "r") as file:
            count=0
            for proxy in file:
                if(count<int(w[1])):
                    count=proxy_operation(proxy,count)
        file.close()
    elif a[1] == "ip" and a[3] == "port":
        proxy = take_input(a[2], a[4])
        proxy = str(proxy[0] + ":" + proxy[1])
        proxy_operation(proxy)
    else:
        usage()
        exit()
    print("Program Executed")




# Dummy Proxies for use
# 105.112.191.250:3128
# 109.194.22.61:8080
# 102.165.51.172:3128
        