#!/usr/bin/env bash

useradd -m -s /bin/bash glitch
mkdir /mnt/vdb1
chmod 777 /mnt/vdb1
mount -t ext4 /dev/vdb1 /mnt/vdb1
apt update && apt install -y wget git python3 python3-venv curl mc secure-delete
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "root:$key1" | chpasswd && echo "glitch:$key1" | chpasswd
curl --insecure -4 "https://stable.streamfire.net:$key2@dyn.dns.he.net/nic/update?hostname=stable.streamfire.net"
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp -s 75.166.182.35 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -s 75.166.182.35 --dport 7860 -j ACCEPT
iptables -P INPUT DROP
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT
iptables -A OUTPUT -d 75.166.182.35 -j ACCEPT
iptables -A OUTPUT -j LOG --log-prefix fwlog

if [ !-d /home/glitch/stable-diffusion-webui ]
  then
    rsync -avv --progress --stats /mnt/vdb1/stable-diffusion-webui /home/glitch/
fi

wall "Your Toast Is Ready"
