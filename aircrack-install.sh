#!/bin/bash
#
# Copy this to the boot directory and 
# run sudo
#
# from https://medium.com/@THESMASHY/raspberry-pi-zero-w-wifi-hacking-gadget-63e3fa1c3c8d
# https://re4son-kernel.com/re4son-pi-kernel/

if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# upgrade the O/S
echo "Updating to latest packages"
apt-get update && apt-get -y upgrade

echo "Download and install re4son special kernel"
## Stable repository
cd /tmp
echo "deb http://http.re4son-kernel.com/re4son/ kali-pi main" > /etc/apt/sources.list.d/re4son.list
wget -O - https://re4son-kernel.com/keys/http/archive-key.asc | apt-key add -
apt update
apt-get -y install kalipi-kernel kalipi-bootloader kalipi-re4son-firmware kalipi-kernel-headers libraspberrypi0 libraspberrypi-dev libraspberrypi-doc libraspberrypi-bin

echo "Add mon0 to /etc/rc.local if not already there"
cd /tmp
if ! grep -q "ifconfig mon0" "/etc/rc.local"; then
  sudo sed -i "s/exit 0/#exit 0/g" /etc/rc.local
  echo "
iw phy phy0 interface add mon0 type monitor
ifconfig mon0 up

exit 0
" >> /etc/rc.local
fi

# should this run after reboot
echo "Download and install aircrack"
cd /tmp
curl -s https://packagecloud.io/install/repositories/aircrack-ng/release/script.deb.sh | bash
apt-get -y install aircrack-ng

echo "Rebooting to enable everything - must reboot manually for now"
#reboot

# can verify with looking for wi-fi monitoring mode 'monitor' is supported
# iw phy phy0 info | grep monitor
# can verify looking to see if mon0 came up
# ifconfig | grep mon0
