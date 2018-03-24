#!/bin/bash
# is rerunable
#
# Portions styled from 
# ref: https://kerneltalks.com/virtualization/how-to-reset-iptables-to-default-settings/
# ref: https://makezine.com/2017/09/07/secure-your-raspberry-pi-against-attackers/
# ref: https://www.raspberrypi.org/documentation/remote-access/ssh/
# ref: https://serverfault.com/questions/475717/iptables-block-incoming-on-eth1-and-allow-all-from-eth0
# ref: https://askubuntu.com/a/30157/8698

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Commands that you don't want run with root would be invoked
# with: sudo -u $real_user
# So they will be ran as the user who invoked the sudo command
# Keep in mind, if the user is using a root shell (they're logged in as root),
# then $real_user is actually root
# sudo -u $real_user non-root-command
# Commands that need to be ran with root would be invoked without sudo

# log the current rules
echo "----------------------------------------------"
echo inbound rules before more reset and ssh block
iptables --list --verbose
echo
ip6tables --list --verbose
echo "----------------------------------------------"
# reset the inbound rules
iptables -F INPUT
ip6tables -F INPUT
echo "Reset Input Rules"

# enable iptables inbound rule blocking SSH on wlan0/eth0
if [ -e /sys/class/net/wlan0 ]; then
    echo "Blocking port 22: wlan0"
    iptables -A INPUT -p tcp --dport 22 -i wlan0 -j DROP
    ip6tables -A INPUT -p tcp --dport 22 -i wlan0 -j DROP
fi
if [ -e /sys/class/net/eth0 ]; then
    echo "Blocking port 22: eth0"
    iptables -A INPUT -p tcp --dport 22 -i eth0 -j DROP
    ip6tables -A INPUT -p tcp --dport 22 -i eth0 -j DROP
fi
# log the current rules
echo "----------------------------------------------"
echo inbound rules after blocking ssh on  wlan0/eth0
iptables --list --verbose
echo
ip6tables --list --verbose
echo "----------------------------------------------"

# install if not already there
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' iptables-persistent | grep "install ok installed")
echo Determined status for iptables-persistent: '$PKG_OK'
if [ -z "$PKG_OK" ]; then
  echo "No iptables-persistent. iptables-persistent up somelib."
  apt-get --force-yes --yes install iptables-persistent
else
  # persist the changes.
  echo "iptables-persistent present so just reconfigure."
  iptables-save >/etc/iptables/rules.v4
  ip6tables-save >/etc/iptables/rules.v6
fi

if [ "`systemctl is-active ssh`" != "active" ] 
then
    echo "starting ssh"
    systemctl enable ssh
    systemctl start ssh
else
    echo "ssh already started"
fi
