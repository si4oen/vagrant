#!/bin/bash

## Set TimeZone to Asia/Ho_Chi_Minh
echo ">>>>> [TASK] Set TimeZone to Asia/Ho_Chi_Minh"
timedatectl set-timezone Asia/Ho_Chi_Minh

## Update the system >/dev/null 2>&1
echo ">>>>> [TASK] Updating the system"
apt update >/dev/null 2>&1
apt upgrade -y >/dev/null 2>&1

## Install desired packages
echo ">>>>> [TASK] Installing desired packages"
apt install -y net-tools telnet htop wget unzip >/dev/null 2>&1

## Enable password authentication & SSH root login
echo ">>>>> [TASK] Enabled password authentication in sshd config"
sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
systemctl reload sshd

## Enable SSH root login
echo ">>>>> [TASK] Enable SSH root login"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

## Set Root Password
echo ">>>>> [TASK] Set root password"
echo "root:ubuntu" | sudo chpasswd >/dev/null 2>&1

## Update hosts file
#echo "[TASK] Update host file /etc/hosts"
#cat >>/etc/hosts<<EOF
#172.42.42.10 server.example.com server
#172.42.42.20 client.example.com client
#EOF

## Cleanup system >/dev/null 2>&1
echo ">>>>> [TASK] Cleanup system"
apt-get --purge autoremove -y >/dev/null 2>&1
apt-get autoremove -y >/dev/null 2>&1
apt-get clean >/dev/null 2>&1
rm -rf /tmp/*
rm -f /var/log/wtmp /var/log/btmp
#dd if=/dev/zero of=/EMPTY bs=1M
#rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c
