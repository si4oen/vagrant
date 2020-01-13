#!/bin/bash

## Update the system
echo ">>>>> [TASK] Updating the system"
apt update >/dev/null 2>&1
apt upgrade -y >/dev/null 2>&1

## Install desired packages
echo ">>>>> [TASK] Installing desired packages"
apt install -y net-tools wget unzip >/dev/null 2>&1

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
#echo ">>>>> [TASK] Update host file /etc/hosts"
#cat >>/etc/hosts<<EOF
#172.42.42.10 server.example.com server
#172.42.42.20 client.example.com client
#EOF
