#!/bin/bash

## Remove unnecessary components >/dev/null 2>&1
echo "[TASK] Remove unnecessary components"
systemctl stop postfix && systemctl disable postfix && yum -y remove postfix
systemctl stop chronyd && systemctl disable chronyd && yum -y remove chrony
systemctl stop avahi-daemon.socket avahi-daemon.service
systemctl disable avahi-daemon.socket avahi-daemon.service
yum -y remove avahi-autoipd avahi-libs avahi
#chkconfig network on
#systemctl restart network

## Cleanup system >/dev/null 2>&1
echo "[TASK] Cleanup system"
yum -y install yum-utils
package-cleanup -y --oldkernels --count=1
yum -y autoremove
yum clean all
rm -rf /tmp/*
rm -f /var/log/wtmp /var/log/btmp
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c

## Rebooting Server
echo "[TASK] Rebooting server"
sudo reboot now