#!/bin/bash

# Fungsi untuk menangani kesalahan
function handle_error() {
    echo "Kesalahan: $1"
    exit 1
}

# Fungsi untuk mendapatkan domain dari pengguna
function get_domain() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[97;1m   DOMAINS CHANGES TO VPS    \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[92;1m 1. Domain sendiri \e[0m"
    echo -e "\e[92;1m 2. Domain random  \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e ""
    read -p "Select choice domain 1-2: " DOMAINS_SELECT

    if [ "$DOMAINS_SELECT" == "1" ]; then
        clear
        echo -e "\e[97;1m =========================== \e[0m"
        echo -e "\e[96;1m      DOMAINS SENDIRI        \e[0m"
        echo -e "\e[97;1m =========================== \e[0m"
        echo -e ""
        read -p "Your domains: " YUDOMAINS
        echo "$YUDOMAINS" > /etc/xray/domain
        echo "$YUDOMAINS" > /root/domain
    elif [ "$DOMAINS_SELECT" == "2" ]; then
        wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/domains.sh \
             -O /tmp/domains.sh && \
             chmod +x /tmp/domains.sh && /tmp/domains.sh
    else
        handle_error "Pilihan tidak valid!"
    fi
    clear
}

# Fungsi untuk menginstal paket-paket dasar
function install_packages() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING PACKAGES      \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    apt update
    apt install -y curl wget jq
    apt install -y git python
}

# Fungsi untuk menginstal SSH dan OpenVPN
function install_ssh_openvpn() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING SSH & OPENVPN  \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    apt install -y at
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/ssh/ssh-vpn.sh \
         -O ssh-vpn.sh && \
         chmod +x ssh-vpn.sh && ./ssh-vpn.sh

    # Menginstal gotop
    gotop_latest=$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v$gotop_latest"_linux_amd64.deb
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb

    # Instal gotop, areuh, baby!
    dpkg -i /tmp/gotop.deb
}

# Fungsi untuk menginstal Xray
function install_xray() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING XRAY        \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/xray/ins-xray.sh \
         -O ins-xray.sh && \
         chmod +x ins-xray.sh && ./ins-xray.sh

    # Menginstal limit quota dan service Xray
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/Xbw_LIMIT/install.sh \
         -O install.sh && \
         chmod +x install.sh && ./install.sh

    # Menginstal limit service IP Xray
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/AUTOKILL_SERVICE/service.sh \
         -O service.sh && \
         chmod +x service.sh && ./service.sh
}

# Fungsi untuk menginstal WebSocket SSH
function install_websocket() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING WEBSOCKET SSH  \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/ws/install-ws.sh \
         -O install-ws.sh && \
         chmod +x install-ws.sh && ./install-ws.sh

    # Menginstal banner SSH
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/ws/banner_ssh.sh \
         -O banner_ssh.sh && \
         chmod +x banner_ssh.sh && ./banner_ssh.sh
}

# Fungsi untuk menginstal menu backup
function install_backup() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING BACKUP MENU   \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    apt install -y rclone
    printf "q\n" | rclone config
    wget -q -O /root/.config/rclone/rclone.conf "https://github.com/CODE1-cpu/xscriptx/raw/main/rclone.conf"
    git clone -q https://github.com/CODE1-cpu/wondershaper.git
    cd wondershaper
    make install
    cd
    rm -rf wondershaper
    
    rm -f /root/set-br.sh
    rm -f /root/limit.sh
}

# Fungsi untuk menginstal OHP
function install_ohp() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING OHP          \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/ws/ohp.sh \
         -O ohp.sh && \
         chmod +x ohp.sh && ./ohp.sh
}

# Fungsi untuk menginstal fitur tambahan
function install_features() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING FEATURES      \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/menu/install_menu.sh \
         -O install_menu.sh && \
         chmod +x install_menu.sh && ./install_menu.sh
}

# Fungsi untuk menginstal UDP custom
function install_udp_custom() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING UDP CUSTOM    \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/ws/UDP.sh \
         -O UDP.sh && \
         chmod +x UDP.sh && ./UDP.sh
}

# Fungsi untuk mengatur nilai fs.file-max
function set_file_max() {
    NEW_FILE_MAX=65535
    CURRENT_FILE_MAX=$(grep "^fs.file-max" "$SYSCTL_CONF" | awk '{print $3}' 2>/dev/null)

    if [ "$CURRENT_FILE_MAX" != "$NEW_FILE_MAX" ]; then
        if grep -q "^fs.file-max" "$SYSCTL_CONF"; then
            sed -i "s/^fs.file-max.*/fs.file-max = $NEW_FILE_MAX/" "$SYSCTL_CONF"
        else
            echo "fs.file-max = $NEW_FILE_MAX" >> "$SYSCTL_CONF"
        fi
    fi

    sysctl -p
}

# Fungsi untuk menginstal cron
function install_cron() {
    echo -e "\e[97;1m =========================== \e[0m"
    echo -e "\e[96;1m      INSTALLING CRON          \e[0m"
    echo -e "\e[97;1m =========================== \e[0m"
    wget -q https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/install_cron.sh \
         -O install_cron.sh && \
         chmod +x install_cron.sh && ./install_cron.sh
}

# Memeriksa izin root
if [ "$EUID" -ne 0 ]; then
    echo "Anda perlu menjalankan skrip ini sebagai root."
    exit 1
fi

# Memeriksa dan mengatur nilai fs.file-max
SYSCTL_CONF="/etc/sysctl.conf"
set_file_max

# Memeriksa dan mengatur nilai netfilter
NF_CONNTRACK_MAX="net.netfilter.nf_conntrack_max=262144"
NF_CONNTRACK_TIMEOUT="net.netfilter.nf_conntrack_tcp_timeout_time_wait=30"

if ! grep -q "^$NF_CONNTRACK_MAX" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_MAX" >> "$SYSCTL_CONF"
fi

if ! grep -q "^$NF_CONNTRACK_TIMEOUT" "$SYSCTL_CONF"; then
    echo "$NF_CONNTRACK_TIMEOUT" >> "$SYSCTL_CONF"
fi

sysctl -p

# Memeriksa dan mengatur direktori
function make_directories() {
    main_dirs=(
        "/etc/xray" "/var/lib/LT" "/etc/lunatic" "/etc/limit"
        "/etc/vmess" "/etc/vless" "/etc/trojan" "/etc/ssh"
    )

    lunatic_subdirs=("vmess" "vless" "trojan" "ssh" "bot")
    lunatic_types=("usage" "ip" "detail")

    protocols=("vmess" "vless" "trojan" "ssh")

    for dir in "${main_dirs[@]}"; do
        mkdir -p "$dir"
    done

    for service in "${lunatic_subdirs[@]}"; do
        for type in "${lunatic_types[@]}"; do
            mkdir -p "/etc/lunatic/$service/$type"
        done
    done

    for protocol in "${protocols[@]}"; do
        mkdir -p "/etc/limit/$protocol"
    done

    databases=(
        "/etc/lunatic/vmess/.vmess.db"
        "/etc/lunatic/vless/.vless.db"
        "/etc/lunatic/trojan/.trojan.db"
        "/etc/lunatic/ssh/.ssh.db"
        "/etc/lunatic/bot/.bot.db"
    )

    for db in "${databases[@]}"; do
        touch "$db"
        echo "& plugin Account" >> "$db"
    done

    touch /etc/.{ssh,vmess,vless,trojan}.db
    echo "IP=" > /var/lib/LT/ipvps.conf
}

# Memanggil fungsi
make_directories

# Memanggil fungsi instalasi
install_packages
install_ssh_openvpn
install_xray
install_websocket
install_backup
install_ohp
install_features
install_udp_custom
install_cron

# Mengirim notifikasi ke Telegram
CHATID="6909128011"
KEY="7665798896:AAH6oThmdoWiZYQ7Z_Sv9V-kzV26KcmJzVU"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TEXT="
<code>= = = = = = = = = = = = =</code>
<b>   🧱 AUTOSCRIPT PREMIUM 🧱 </b>
<b>        Notifications       </b>
<code>= = = = = = = = = = = = =</code>
<b>Client  :</b> <code>$client</code>
<b>ISP     :</b> <code>$ISP</code>
<b>Country :</b> <code>$CITY</code>
<b>DATE    :</b> <code>$date</code>
<b>Time    :</b> <code>$time</code>
<b>Expired :</b> <code>$exp</code>
<code>= = = = = = = = = = = = =</code>
<b>     ULTRASONIC TECHNOLOGY    </b>
<code>= = = = = = = = = = = = =</code>"
curl -s --max-time 10 -X POST "$URL" \
-d "chat_id=$CHATID" \
-d "text=$TEXT" \
-d "parse_mode=HTML" \
-d "disable_web_page_preview=true" \
-d "reply_markup={\"inline_keyboard\":[[{\"text\":\" ʙᴜʏ ꜱᴄʀɪᴘᴛ \",\"url\":\"https://t.me/ian_khvicha\"}]]}"

# Bersihkan file-file yang tidak diperlukan
rm -f openvpn key.pem cert.pem
rm -f ~/.bash_history

# Reboot setelah 3 detik
echo -e "\e[92;1m dalam 3 detik akan Melakukan reboot.... \e[0m"
sleep 3
reboot
# Langsung reboot
reboot