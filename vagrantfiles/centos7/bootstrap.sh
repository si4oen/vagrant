#!/bin/bash

## Update the system
#echo "[TASK] Updating the system"
#yum install -y epel-release >/dev/null 2>&1
#yum update -y >/dev/null 2>&1

## Install desired packages
echo "[TASK] Installing desired packages"
yum install -y -q net-tools bind-utils  >/dev/null 2>&1

## Enable password authentication
#echo "[TASK] Enabled password authentication in sshd config"
#sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
#systemctl reload sshd

## Disable Password authentication
echo "[TASK] Disabled Password authentication in sshd config"
sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
systemctl reload sshd

## Set Root Password
echo "[TASK] Set root password"
echo "centos" | passwd --stdin root >/dev/null 2>&1

## Disable and Stop firewalld
echo "[TASK] Disable and stop firewalld"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

## Disable SELinux
echo "[TASK] Disable SELinux"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

## Shutdown Server
echo "[TASK] Shutting down server"
sudo reboot now

## Update hosts file
#echo "[TASK] Update host file /etc/hosts"
#cat >>/etc/hosts<<EOF
#172.42.42.10 server.example.com server
#172.42.42.20 client.example.com client
#EOF
