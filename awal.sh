# Decrypted by K-fuscator
# Github- https://github.com/KasRoudra/k-fuscator

rm -rf xray
clear
NC='\e[0m'
DEFBOLD='\e[39;1m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
MB='\e[35;1m'
CB='\e[35;1m'
WB='\e[37;1m'
secs_to_human() {
echo -e "${WB}Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds${NC}"
}
start=$(date +%s)
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install socat netfilter-persistent -y
apt install vnstat lsof fail2ban -y
apt install curl sudo -y
apt install screen cron screenfetch -y
mkdir /backup >> /dev/null 2>&1
mkdir /user >> /dev/null 2>&1
mkdir /tmp >> /dev/null 2>&1
apt install resolvconf network-manager dnsutils bind9 -y
cat > /etc/systemd/resolved.conf << END
[Resolve]
DNS=8.8.8.8 8.8.4.4
Domains=~.
ReadEtcHosts=yes
END
systemctl enable resolvconf
systemctl enable systemd-resolved
systemctl enable NetworkManager
rm -rf /etc/resolv.conf
rm -rf /etc/resolvconf/resolv.conf.d/head
echo "
nameserver 127.0.0.53
" >> /etc/resolv.conf
echo "
" >> /etc/resolvconf/resolv.conf.d/head
systemctl restart resolvconf
systemctl restart systemd-resolved
systemctl restart NetworkManager
echo "Google DNS" > /user/current
rm /usr/local/etc/xray/city >> /dev/null 2>&1
rm /usr/local/etc/xray/org >> /dev/null 2>&1
rm /usr/local/etc/xray/timezone >> /dev/null 2>&1
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" - install --beta
cp /usr/local/bin/xray /backup/xray.official.backup
curl -s ipinfo.io/city >> /usr/local/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /usr/local/etc/xray/org
curl -s ipinfo.io/timezone >> /usr/local/etc/xray/timezone
clear
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Xray-core mod${NC}"
sleep 0.5
wget -q -O /backup/xray.mod.backup "https://github.com/dharak36/Xray-core/releases/download/v1.0.0/xray.linux.64bit"
echo -e "${GB}[ INFO ]${NC} ${YB}Download Xray-core done${NC}"
sleep 1
cd
clear
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
clear
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
apt install nginx -y
rm /var/www/html/*.html
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
mkdir -p /var/www/html/vmess
mkdir -p /var/www/html/vless
mkdir -p /var/www/html/trojan
mkdir -p /var/www/html/shadowsocks
mkdir -p /var/www/html/shadowsocks2022
mkdir -p /var/www/html/socks5
mkdir -p /var/www/html/allxray
systemctl restart nginx
clear
touch /usr/local/etc/xray/domain
echo -e "${YB}Input Domain${NC} "
echo " "
read -rp "Input domain kamu : " -e dns
if [ -z $dns ]; then
echo -e "Nothing input for domain!"
else
echo "$dns" > /usr/local/etc/xray/domain
echo "DNS=$dns" > /var/lib/dnsvps.conf
fi
clear
systemctl stop nginx
systemctl stop xray
domain=$(cat /usr/local/etc/xray/domain)
curl https://get.acme.sh | sh
source ~/.bashrc
cd .acme.sh
bash acme.sh --issue -d $domain --server letsencrypt --keylength ec-256 --fullchain-file /usr/local/etc/xray/fullchain.crt --key-file /usr/local/etc/xray/private.key --standalone --force
clear
echo -e "${GB}[ INFO ]${NC} ${YB}Setup Nginx & Xray Conf${NC}"
echo "UQ3w2q98BItd3DPgyctdoJw4cqQFmY59ppiDQdqMKbw=" > /usr/local/etc/xray/serverpsk
wget -q -O /usr/local/etc/xray/config.json https://raw.githubusercontent.com/dugong-lewat/dugong-lewat/other/config.json
wget -q -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/dugong-lewat/dugong-lewat/other/nginx.conf
wget -q -O /etc/nginx/conf.d/xray.conf https://raw.githubusercontent.com/dugong-lewat/dugong-lewat/other/xray.conf
systemctl restart nginx
systemctl restart xray
echo -e "${GB}[ INFO ]${NC} ${YB}Setup Done${NC}"
sleep 2
clear
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
cd /usr/bin
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Main Menu${NC}"
wget -q -O menu "https://raw.githubusercontent.com/titis69/sc2024/main/menu/menu.sh"
wget -q -O vmess "https://is.gd/POryQg"
wget -q -O vless "https://is.gd/xMh4kv"
wget -q -O trojan "https://is.gd/f9pZcW"
wget -q -O shadowsocks "https://is.gd/1Dz0tB"
wget -q -O shadowsocks2022 "https://is.gd/8kPafk"
wget -q -O socks "https://is.gd/4ym6fT"
wget -q -O allxray "https://is.gd/mngf1y"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vmess${NC}"
wget -q -O add-vmess "https://is.gd/GXSlVT"
wget -q -O del-vmess "https://is.gd/4xLaAj"
wget -q -O extend-vmess "https://is.gd/tL8efq"
wget -q -O trialvmess "https://is.gd/D5zrOw"
wget -q -O cek-vmess "https://is.gd/ehK3Eu"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Vless${NC}"
wget -q -O add-vless "https://is.gd/fvySZA"
wget -q -O del-vless "https://is.gd/Fc1RCO"
wget -q -O extend-vless "https://is.gd/iQ3EYO"
wget -q -O trialvless "https://is.gd/k0ZvU0"
wget -q -O cek-vless "https://is.gd/ZB1eMO"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Trojan${NC}"
wget -q -O add-trojan "https://is.gd/0DKHZm"
wget -q -O del-trojan "https://is.gd/Rxnw0J"
wget -q -O extend-trojan "https://is.gd/d0WGjO"
wget -q -O trialtrojan "https://is.gd/mZUtmc"
wget -q -O cek-trojan "https://is.gd/rn8HLl"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks${NC}"
wget -q -O add-ss "https://is.gd/NeRCxN"
wget -q -O del-ss "https://is.gd/YWa6Jk"
wget -q -O extend-ss "https://is.gd/01N6gG"
wget -q -O trialss "https://is.gd/8jWMIr"
wget -q -O cek-ss "https://is.gd/8LYTH6"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Shadowsocks 2022${NC}"
wget -q -O add-ss2022 "https://is.gd/AxOwsm"
wget -q -O del-ss2022 "https://is.gd/35bb0L"
wget -q -O extend-ss2022 "https://is.gd/jH8Mb0"
wget -q -O trialss2022 "https://is.gd/6IRoGp"
wget -q -O cek-ss2022 "https://is.gd/Bk62I8"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Socks5${NC}"
wget -q -O add-socks "https://is.gd/wqfHyG"
wget -q -O del-socks "https://is.gd/jTDu9J"
wget -q -O extend-socks "https://is.gd/WOLshy"
wget -q -O trialsocks "https://is.gd/Txue8k"
wget -q -O cek-socks "https://is.gd/9iFu8D"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu All Xray${NC}"
wget -q -O add-xray "https://is.gd/Z7UF0L"
wget -q -O del-xray "https://is.gd/gJAaV1"
wget -q -O extend-xray "https://is.gd/1TFJGd"
wget -q -O trialxray "https://is.gd/Q3lVnb"
wget -q -O cek-xray "https://is.gd/NXBkoM"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Menu Log${NC}"
wget -q -O log-create "https://is.gd/PQUZxM"
wget -q -O log-vmess "https://is.gd/fdf0kT"
wget -q -O log-vless "https://is.gd/q4K40U"
wget -q -O log-trojan "https://is.gd/y9WOpD"
wget -q -O log-ss "https://is.gd/EgLiSK"
wget -q -O log-ss2022 "https://is.gd/XsRD4Q"
wget -q -O log-socks "https://is.gd/tfc8G1"
wget -q -O log-allxray "https://is.gd/NM1LYo"
sleep 0.5
echo -e "${GB}[ INFO ]${NC} ${YB}Downloading Other Menu${NC}"
wget -q -O xp "https://is.gd/BT6edK"
wget -q -O dns "https://is.gd/keEZNQ"
wget -q -O certxray "https://is.gd/3KMw7y"
wget -q -O xraymod "https://is.gd/DA5m5F"
wget -q -O xrayofficial "https://is.gd/kRu8Oz"
wget -q -O about "https://is.gd/iNocqp"
wget -q -O clear-log "https://is.gd/iJ0jly"
wget -q -O changer "https://is.gd/d3m3Qi"
echo -e "${GB}[ INFO ]${NC} ${YB}Download All Menu Done${NC}"
sleep 2
chmod +x add-vmess
chmod +x del-vmess
chmod +x extend-vmess
chmod +x trialvmess
chmod +x cek-vmess
chmod +x add-vless
chmod +x del-vless
chmod +x extend-vless
chmod +x trialvless
chmod +x cek-vless
chmod +x add-trojan
chmod +x del-trojan
chmod +x extend-trojan
chmod +x trialtrojan
chmod +x cek-trojan
chmod +x add-ss
chmod +x del-ss
chmod +x extend-ss
chmod +x trialss
chmod +x cek-ss
chmod +x add-ss2022
chmod +x del-ss2022
chmod +x extend-ss2022
chmod +x trialss2022
chmod +x cek-ss2022
chmod +x add-socks
chmod +x del-socks
chmod +x extend-socks
chmod +x trialsocks
chmod +x cek-socks
chmod +x add-xray
chmod +x del-xray
chmod +x extend-xray
chmod +x trialxray
chmod +x cek-xray
chmod +x log-create
chmod +x log-vmess
chmod +x log-vless
chmod +x log-trojan
chmod +x log-ss
chmod +x log-ss2022
chmod +x log-socks
chmod +x log-allxray
chmod +x menu
chmod +x vmess
chmod +x vless
chmod +x trojan
chmod +x shadowsocks
chmod +x shadowsocks2022
chmod +x socks
chmod +x allxray
chmod +x xp
chmod +x dns
chmod +x certxray
chmod +x xraymod
chmod +x xrayofficial
chmod +x about
chmod +x clear-log
chmod +x changer
cd
echo "0 0 * * * root xp" >> /etc/crontab
echo "*/3 * * * * root clear-log" >> /etc/crontab
systemctl restart cron
cat > /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
clear
echo ""
echo ""
echo -e "${BB}—————————————————————————————————————————————————————————${NC}"
echo -e "                  ${WB}MINI SCRIPT BY RIDWAN${NC}"
echo -e "${BB}—————————————————————————————————————————————————————————${NC}"
echo -e "  ${WB}»»» Protocol Service «««  |  »»» Network Protocol «««${NC}  "
echo -e "${BB}—————————————————————————————————————————————————————————${NC}"
echo -e "  ${YB}- Vless${NC}                   ${WB}|${NC}  ${YB}- Websocket (CDN) non TLS${NC}"
echo -e "  ${YB}- Vmess${NC}                   ${WB}|${NC}  ${YB}- Websocket (CDN) TLS${NC}"
echo -e "  ${YB}- Trojan${NC}                  ${WB}|${NC}  ${YB}- gRPC (CDN) TLS${NC}"
echo -e "  ${YB}- Socks5${NC}                  ${WB}|${NC}"
echo -e "  ${YB}- Shadowsocks${NC}             ${WB}|${NC}"
echo -e "  ${YB}- Shadowsocks 2022${NC}        ${WB}|${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "               ${WB}»»» Network Port Service «««${NC}             "
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo -e "  ${YB}- HTTPS : 443, 2053, 2083, 2087, 2096, 8443${NC}"
echo -e "  ${YB}- HTTP  : 80, 8080, 8880, 2052, 2082, 2086, 2095${NC}"
echo -e "${BB}————————————————————————————————————————————————————————${NC}"
echo ""
rm -f xray
secs_to_human "$(($(date +%s) - ${start}))"
echo -e "${YB}[ WARNING ] reboot now ? (Y/N)${NC} "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi
