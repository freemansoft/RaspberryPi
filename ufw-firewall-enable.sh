#!/bin/bash
# Enable the firewall as the following
#   block inbound
#   allow outbound
#   allow inbound on usb0 - gadget 

if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

apt-get -y install ufw
echo "Blocking all inbound"
echo "Blocking all outbound"
sudo ufw default allow outgoing
sudo ufw default deny incoming
# enable anything over the usb0 port and eth0 - only Zero supports usb0
echo "Allowing inbound on wired connections usb0 and eth0"
sudo ufw allow in on usb0
sudo ufw allow in on eth0

#sudo ufw allow proto tcp from any to any port 80,443

# start the firewall without prompting
ufw --force enable
ufw status verbose
