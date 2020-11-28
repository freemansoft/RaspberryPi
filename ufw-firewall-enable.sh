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
sudo ufw default allow outgoing
sudo ufw default deny incoming
# enable anything over the usb0 port
sudo ufw allow in on usb0
# start the firewall without prompting
ufw --force enable
