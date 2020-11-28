#!/bin/bash
#
# WRITE DOWN THE NEW GENERATED HOSTNAME BEFORE REBOOTING!
# 
# Sets the hostname to pi-<serial> 
# bonjour hostname will be pi-<serial>.local
# host entry will still exist for raspberrypi.local
#
# based on https://pricklytech.wordpress.com/2013/04/24/ubuntu-change-hostname-permanently-using-the-command-line/

if [ $(id -u) -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

hostname_orig=$(cat /etc/hostname)
pi_serial=$(cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2 | sed s/0//g)
hostname_new="pi"-$pi_serial

if ! grep -q $hostname_new /etc/hostname; then
    echo "Changing hostname from $hostname_orig to $hostname_new"
    sudo sed -i "s/$hostname_orig/$hostname_new/g" /etc/hostname
    sudo sed -i "s/$hostname_orig/$hostname_new $hostname_orig/g" /etc/hosts
    echo "Reboot to make change take effect"
else
    echo "No change made. Name already set to $hostname_new"
fi
